//
//  HCRequestAgent.m
//  HBRequest
//
//  Created by Belle on 2017/3/26.
//  Copyright © 2017年 Beijing Fitcare inc. All rights reserved.
//

#import "HCRequestAgent.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "NSString+MD5.h"
#import <YYModel/YYModel.h>
#import <AdSupport/AdSupport.h>

// break-if 宏
#ifndef BREAK_IF
#define BREAK_IF(cond) if(cond) break
#endif

// 强、弱指针转换
#ifndef WeakObj
#define WeakObj(obj) autoreleasepool{} __weak typeof(obj) obj##Weak = obj;
#endif

#ifndef StrongObj
#define StrongObj(obj) autoreleasepool{} __strong typeof(obj) obj = obj##Weak;
#endif

static NSString *defaultRequst = @"";

@interface HCRequestAgent() <UIAlertViewDelegate>

@end

@implementation HCRequestAgent

static NSMutableArray *_allSessionTask;

+ (HCRequestAgent *)sharedAgent {
    static HCRequestAgent *hc_agent = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSURL *baseUrl = [NSURL URLWithString:@"https://api.ihold.com/"];
        hc_agent = [[self alloc] initWithBaseURL:baseUrl];
    });
    return hc_agent;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 8;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [self.requestSerializer setValue:[self userAgent] forHTTPHeaderField:@"User-Agent"];
        
        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes
                                                          setByAddingObjectsFromArray:@[@"text/html",@"text/plain"]];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;
    }
    
    return self;
}

#pragma mark - reachability funcs
- (void)dealloc{
    [self.reachabilityManager stopMonitoring];
}

- (NSString *)userAgent {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString *userToken = @"";
    NSString *userAgent = [NSString stringWithFormat:@"AppName:iholdApp, ClientSN:%@, ClientType:ios, Version:%@, Token:%@", [HCRequestAgent idfaString], version, userToken];

    return userAgent;
}

- (void)configHeaderField {
    NSString *userToken = @"";
//    if (0 == userToken.length) {
//        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kBaseURL]];
//
//        NSHTTPCookie *cookie;
//        for (cookie in cookies) {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//
//            if ([cookie.name isEqualToString:@"user_token"]) {
//                userToken = cookie.value;
//                kHCUserInstance.userInfo.userToken = userToken;
//                break;
//            }
//        }
//
//        if (0 == userToken.length) {
//            userToken = [NSString string];
//        }
//    }
    [self.requestSerializer setValue:@"iholdApp" forHTTPHeaderField:@"AppName"];
    [self.requestSerializer setValue:[HCRequestAgent idfaString] forHTTPHeaderField:@"ClientSN"];
    [self.requestSerializer setValue:@"ios" forHTTPHeaderField:@"ClientType"];
    [self.requestSerializer setValue:kHCBundleVersion forHTTPHeaderField:@"Version"];
    [self.requestSerializer setValue:userToken forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:@"dev" forHTTPHeaderField:@"channel"];
}

- (NSURLSessionDataTask *)requestWithMethod:(HCRequestMethod)requestMethod urlString:(NSString *)urLString parameters:(id)parameters callback:(void (^)(HCResponseModel *responseModel))callback{
    return [self requestWithMethod:requestMethod urlString:urLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (callback) {
            HCResponseModel *responseModel = [HCResponseModel yy_modelWithDictionary:responseObject];
            responseModel.task = task;
            callback(responseModel);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (callback) {
            HCResponseModel *responseModel = [HCResponseModel responseModelWithError:error];
            responseModel.task = task;
            callback(responseModel);
        }
    }];
}

- (NSURLSessionDataTask *)requestWithMethod:(HCRequestMethod)requestMethod urlString:(NSString *)urlString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSURLSessionDataTask *task;
    
    do {
        BREAK_IF(0 == urlString.length);
        NSString *fullPathUrl;
        NSString *methodString = @"GET";
        
        if (!_debugBaseUrl || 0 == _debugBaseUrl.length) {
            fullPathUrl = [NSString stringWithString:urlString];
        } else {
            fullPathUrl = [NSString stringWithFormat:@"%@%@", _debugBaseUrl, urlString];
        }
        
        [self configHeaderField] ;
        
        switch (requestMethod) {
            case HCRequestMethodGet: {
                methodString = @"GET";
                break;
            }
            case HCRequestMethodPost: {
                methodString = @"POST";
            } break;
            case HCRequestMethodHead : {
                methodString = @"HEAD";
            } break;
            case HCRequestMethodPut: {
                methodString = @"PUT";
            } break;
            case HCRequestMethodPatch: {
                methodString = @"PATCH";
            } break;
            case HCRequestMethodDelete: {
                methodString = @"DELETE";
            } break;
            default:
                break;
        }
        
        @WeakObj(self);
        parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        [self prepareRequestWithParam:parameters urlStr:urlString];
        task = [self hc_dataTaskWithHTTPMethod:methodString
                                     URLString:urlString
                                    parameters:parameters
                                uploadProgress:nil
                              downloadProgress:nil
                                       success:^(NSURLSessionDataTask *task, id responseObj) {
                                           [[selfWeak allSessionTask] removeObject:task];
                                           success ? success(task, responseObj) : nil;
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [[selfWeak allSessionTask] removeObject:task];
                                           
                                           if (NSURLSessionTaskStateCanceling != task.state) {
                                               failure ? failure(task, error) : nil;
                                               
                                           }
                                       }];
        
        // 添加sessionTask到数组
        task ? [[self allSessionTask] addObject:task] : nil ;
        [task resume];
    } while (false);
    
    return task;
}
//  signString
- (void)prepareRequestWithParam:(NSDictionary *)param urlStr:(NSString *)urlStr{
    if (![urlStr containsString:@"http"]) {
        urlStr = [self.baseURL.absoluteString stringByAppendingPathComponent:urlStr];
    }
    NSURL *targetURL = [NSURL URLWithString:urlStr];
    
    NSMutableString *resultSS = [NSMutableString new];
    NSMutableDictionary *pars = [[NSMutableDictionary alloc] initWithDictionary:param];
    NSString *uuid = @"";
    NSString *timeStampStr = [NSString stringWithFormat:@"%ld",((long)[[NSDate date] timeIntervalSince1970])];
    pars[@"AppName"] = @"iholdApp";
    pars[@"ClientSN"] = [HCRequestAgent idfaString];
    pars[@"ClientType"] = @"ios";
    pars[@"Timestamp"] = timeStampStr;
    pars[@"Nonce"] = uuid;
    pars[@"Version"] = @"4.0.0";
    
//#warning L4 需要优化
    if (targetURL.query.length) {
        NSArray<NSString *> *queryArr = [[targetURL query] componentsSeparatedByString:@"&"];
        for (NSString *querySubString in queryArr) {
            NSArray<NSString *> *kvArr = [querySubString componentsSeparatedByString:@"="];
            if ([kvArr firstObject].length) {
                pars[[kvArr firstObject]] = [kvArr lastObject];
            }
        }
    }
    
    NSArray<NSString *> *sortedKeys = [pars.allKeys sortedArrayUsingSelector:@selector(compare:)];
    __block BOOL first = true;
    [sortedKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (first) {
            first = false;
        }else{
            [resultSS appendString:@"&"];
        }
        [resultSS appendFormat:@"%@",obj];
    }];

    NSString *randomKey = [NSString stringWithFormat:@"%@%@%@",@"",timeStampStr,uuid];
    //  旧版本签名key
//    NSString *randomKey = [self getRandomHeaderToken];
    
    NSString *sign = @"";
    if (randomKey.length) {
        sign = resultSS;
    }
    
    [self.requestSerializer setValue:uuid forHTTPHeaderField:@"Nonce"];
    [self.requestSerializer setValue:timeStampStr forHTTPHeaderField:@"Timestamp"];
    [self.requestSerializer setValue:sign forHTTPHeaderField:@"Sign"];
//#if HOLD_DEV_DEBUG
//    [self.requestSerializer setValue:resultSS forHTTPHeaderField:@"StringBFHash"];
//#endif
}

+ (void)recordNetRequestWithURL:(NSString *)urlString
                          param:(NSDictionary *)param
                         method:(HCRequestMethod)method
                         result:(BOOL)result
                    responseObj:(id)responseObj{
    
}

+ (NSURLSessionDownloadTask *)downloadWithUrlString:(NSString *)urlString progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURLSessionDownloadTask *task;
    
    do {
        BREAK_IF(0 == urlString.length);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSURL *fullPathUrl = [NSURL URLWithString:urlString];
        BREAK_IF(nil == fullPathUrl);
        
        @WeakObj(self);
        NSURLRequest *request =[NSURLRequest requestWithURL:fullPathUrl];
        task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            //下载进度
            dispatch_sync(dispatch_get_main_queue(), ^{
                downloadProgressBlock ? downloadProgressBlock(downloadProgress) : nil;
            });
        } destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            [[[selfWeak sharedAgent] allSessionTask] removeObject:task];
            completionHandler ? completionHandler(response, filePath, error) : nil;
        }];
        
        // 开始下载
        [task resume];
        
        // 添加sessionTask到数组
        task ? [[[self sharedAgent] allSessionTask] addObject:task] : nil;
    } while (false);
    
    return task;
}

- (NSURLSessionDataTask *)hc_dataTaskWithHTTPMethod:(NSString *)method
                                          URLString:(NSString *)URLString
                                         parameters:(id)parameters
                                     uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                   downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                            success:(void (^)(NSURLSessionDataTask *, id))success
                                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
//    NSLog(@"request = %@", [request ba_description]);
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[[self sharedAgent] allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[[self sharedAgent] allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithUrlString:(NSString *)urlString {
    if (!urlString || 0 == urlString.length) { return; }
    @synchronized (self) {
        @WeakObj(self);
        [[[self sharedAgent] allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString rangeOfString:urlString].location != NSNotFound) {
                [task cancel];
                [[[selfWeak sharedAgent] allSessionTask] removeObject:task];
            }
        }];
    }
}

+ (NSString *)idfaString {
#if TARGET_IPHONE_SIMULATOR
    return @"TARGET_IPHONE_SIMULATOR";
#else
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            if (asIM == nil) {
                return @"";
            }
            else{
#if EZDEBUG_DEBUGLOG
                NSString *appendString = [[EZDOptions shareOptionInstance].userDefaultOptions boolForKey:kEZDOptionCloseFeedReadedHiddenKey] ? [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] : @"";
                return [[asIM.advertisingIdentifier UUIDString] stringByAppendingFormat:@"%@",appendString];
#else
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
#endif
            }
        }
    }
#endif
}


#pragma mark - Lazy Load
- (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

@end

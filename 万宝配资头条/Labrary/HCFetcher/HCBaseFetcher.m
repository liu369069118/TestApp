

#import "HCBaseFetcher.h"
#import "NSString+MD5.h"
#import "HCRequestCache.h"
#import "YYReachability.h"

@interface HCBaseFetcher()

@property (nonatomic, assign, readonly) BOOL cacheExpired; //缓存是否已过期
@property (nonatomic, assign) BOOL dataLoaded;

@end

@implementation HCBaseFetcher

#pragma mark -- Public Method
- (instancetype)init {
    if (self = [super init]) {
        _requestMethod = HCRequestMethodGet;
        _requestURL = @"";
        _dataLoaded = NO;
        _maxCacheAge = 0;
        _requestPolicy = HCRequestPolicyNoCache;
        [kHCRequestAgentInstance.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];   // 启用304
    }
    
    return self;
}

+ (NSString *)originalUrl {
    return @"";
}

- (NSError *)processData:(id)responseObject {
    return nil;
}

- (void)dispose {
    _parameters = nil;
    _requestURL = nil;
}

- (NSURLSessionDataTask *)requestWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSURLSessionDataTask *task;
    switch (_requestPolicy) {
        case HCRequestPolicyNoCache:
            task = [self loadFromNetWorkWithSuccess:success failure:failure];
            break;
        case HCRequestPolicyOnlyCache:
            [self loadFromCacheWithSuccess:success failure:failure];
            break;
        case HCRequestPolicyExpiredCache: {
            [self loadFromCacheWithSuccess:success failure:failure];
            
            if (self.cacheExpired) {
                task = [self loadFromNetWorkWithSuccess:success failure:failure];
            }
        }
            break;
        case HCRequestPolicyCacheElseLoad:
            [self loadFromCacheWithSuccess:success failure:failure];
            task = [self loadFromNetWorkWithSuccess:success failure:failure];
            break;
        default:
            break;
    }
    
    return task;
}

#pragma mark- private

- (void)loadFromCacheWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    id responseObject = [HCRequestCache requestCacheForUrlString:_requestURL parameters:_parameters];
    
    NSError *error = [self processData:responseObject];
    
    // 没有缓存也需要做回调，方便从网络再次拿数据
    if (error == nil) {
        _isFromCache = YES;
        success ? success(responseObject) : nil;
    } else {
        _isFromCache = YES;
        failure ? failure(nil, error) : nil;
    }
}

- (NSURLSessionDataTask *)loadFromNetWorkWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if ([YYReachability reachability].status == YYReachabilityStatusNone) {
        failure ? failure(nil, nil) : nil;

        return nil;
    }
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [kHCRequestAgentInstance requestWithMethod:_requestMethod urlString:_requestURL parameters:_parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        weakSelf.dataLoaded = YES;
        weakSelf.isFromCache = NO;
        NSError *error = [weakSelf processData:responseObject];
        
        if (nil == error) {
            NSHTTPURLResponse *response;
            if (task.response) {
                response = (NSHTTPURLResponse *)task.response;
            }
            NSString *lastModified = response.allHeaderFields[@"Last-Modified"];
            if (lastModified.length > 0) {
                [HCRequestCache setModifiedTimestamp:lastModified urlString:weakSelf.requestURL parameters:weakSelf.parameters];
            }
            [HCRequestCache setRequestCache:responseObject urlString:weakSelf.requestURL parameters:weakSelf.parameters];
            success ? success(responseObject) : nil;
        } else {
            failure ? failure(task, error) : nil;
        }
        
        [weakSelf dispose];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        weakSelf.dataLoaded = NO;
        weakSelf.isFromCache = NO;
        
        // 服务器重定向 304 code处理
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (304 == response.statusCode) {
            id responseObject = [HCRequestCache requestCacheForUrlString:weakSelf.requestURL parameters:self->_parameters];
            NSError *dataError = [weakSelf processData:responseObject];
            if (dataError == nil) {
                weakSelf.dataLoaded = YES;
                weakSelf.isFromCache = NO;
                success ? success(responseObject) : nil;
            } else {
                failure ? failure(task, error) : nil;
            }
        } else {
            failure ? failure(task, error) : nil;
        }
        
        [weakSelf dispose];
    }];
    
    return task;
}

- (BOOL)cacheExpired {
    NSDate *loadedDate = [HCRequestCache localTimestampCacheForUrlString:_requestURL parameters:_parameters];
    
    if (nil == loadedDate) {
        return YES;
    }
    
    NSTimeInterval deltaTime = [[NSDate date] timeIntervalSinceDate:loadedDate];
    if (deltaTime < 0 || deltaTime > _maxCacheAge * 60){
        return YES;
    }
    
    return NO;
}

- (BOOL)isLoading {
    if (HCRequestPolicyNoCache == _requestPolicy) {
        if (!_dataLoaded) {
            return YES;
        }
    } else if (HCRequestPolicyExpiredCache == _requestPolicy) {
        if (self.cacheExpired && !_dataLoaded) {
            return  YES;
        }
    } else if (HCRequestPolicyCacheElseLoad == _requestPolicy) {
        if (!_dataLoaded) {
            return  YES;
        }
    }
    
    return NO;
}

@end

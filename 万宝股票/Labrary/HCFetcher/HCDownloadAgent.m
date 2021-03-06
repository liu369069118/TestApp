//
//  HCDownloadAgent.m
//  hotbody
//
//  Created by Belle on 2017/2/14.
//  Copyright © 2017年 Beijing Fitcare inc. All rights reserved.
//

#import "HCDownloadAgent.h"
#import "NSString+MD5.h"

//数据长度存储路径
#define HBDestinationPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self.urlString MD5]]

@interface HCDownloadAgent () <NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSOutputStream *stream;
@property (nonatomic, assign) NSUInteger downloadedLength;
@property (nonatomic, assign) NSUInteger contentLength;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) void (^progress) (CGFloat);
@property (nonatomic, copy) void (^completion) (void);

@end

@implementation HCDownloadAgent

#pragma mark - 懒加载

//session
- (NSURLSession *)session {
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}

//下载任务
- (NSURLSessionDataTask *)task {
    if (_task == nil) {
        self.downloadedLength = [NSData dataWithContentsOfFile:_destination].length;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:HBDestinationPath];
        if (dict) {
            NSInteger contentLength = [dict[self.urlString] integerValue];
            if (self.downloadedLength == contentLength) {
                NSFileManager * fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:_destination error:nil];
                
                self.downloadedLength = [NSData dataWithContentsOfFile:_destination].length;
                
                sleep(0.1);
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[[self.urlString lastPathComponent] stringByAppendingString:@"已下载"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//
//                    [alert show];
//                }];
//
//                return nil;
            }
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [request setValue:[NSString stringWithFormat:@"bytes=%zd-",self.downloadedLength] forHTTPHeaderField:@"Range"];
        _task = [self.session dataTaskWithRequest:request];
    }
    
    return _task;
}

//输入管道
-(NSOutputStream *)stream {
    if (_stream == nil) {
        _stream = [NSOutputStream outputStreamToFileAtPath:_destination append:YES];
    }
    
    return _stream;
}

#pragma mark - 开始暂停

//开始下载
- (void)start {
    [self.task resume];
}

//暂停下载
- (void)suspend{
    [self.task suspend];
}

#pragma mark - session代理方法
//接受到数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    //通过管道写入下载数据
    [self.stream write:data.bytes maxLength:data.length];
    
    //拿到当前下载长度
    self.downloadedLength += data.length;
    //求得下载进度
    CGFloat progress = 1.0 * self.downloadedLength / self.contentLength;
    
    //把下载进度传给代理
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self.progress) {
            self.progress(progress);
        }
    }];
}

//接受到响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    //拿到内容数据长度
    NSUInteger contentLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    
    //赋值数据总长度
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:HBDestinationPath];
    dict = nil;
    if (dict == nil) {
        self.contentLength = contentLength;
        
        dict = [NSMutableDictionary dictionary];
        dict[self.urlString] = @(self.contentLength);
        [dict writeToFile:HBDestinationPath atomically:YES];
    } else {
        self.contentLength = [dict[self.urlString] integerValue];
    }
    
    //打开输入管道
    [self.stream open];
    
    //允许接受请求
    completionHandler(NSURLSessionResponseAllow);
}

//完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//    EZDRecordNetRequest(task.currentRequest, nil, error);
    //关闭输入管道
    [self.stream close];
    
    //通知代理已下载完毕
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self.completion) {
            self.completion();
        }
    }];
    
    //清空任务，输入管道
    self.stream = nil;
    self.task = nil;
}

#pragma mark - 初始化方法
//初始化
- (instancetype)initWithURLString:(NSString *)urlString destination:(NSString *)destination progress:(void (^)(CGFloat))progress completion:(void (^)(void))completion {
    if (self = [super init]) {
        self.urlString = urlString;
        self.destination = destination;
        self.progress = progress;
        self.completion = completion;
    }
    
    return self;
}

//工厂方法
+ (instancetype)downloadWithURLString:(NSString *)urlString destination:(NSString *)destination progress:(void (^)(CGFloat))progress completion:(void (^)(void))completion {
    return [[self alloc] initWithURLString:urlString destination:destination progress:progress completion:completion];
}

@end

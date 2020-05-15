
#import <AFNetworking/AFNetworking.h>
#import "HCResponseModel.h"

typedef NS_ENUM(NSUInteger, HCRequestMethod) {
    HCRequestMethodGet = 0,             // GET 请求
    HCRequestMethodPost,                // POST 请求
    HCRequestMethodHead,                // HEADER 请求
    HCRequestMethodPut,                 // PUT 请求
    HCRequestMethodPatch,               // PATCH 请求
    HCRequestMethodDelete,              // DELETE 请求
};

@interface HCRequestAgent : AFHTTPSessionManager

@property (copy, nonatomic) NSString *debugBaseUrl;

+ (HCRequestAgent *)sharedAgent;

/**
 网络请求方法

 @param requestMethod 请求方式
 @param urLString 接口路径
 @param parameters 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 @return 返回task
 */
- (NSURLSessionDataTask *)requestWithMethod:(HCRequestMethod)requestMethod urlString:(NSString *)urLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 网络请求方法(返回response model)
 
 @param requestMethod 请求方式
 @param urLString 接口路径
 @param parameters 请求参数
 @param callback 成功的回调
 @return 返回task
 */
- (NSURLSessionDataTask *)requestWithMethod:(HCRequestMethod)requestMethod urlString:(NSString *)urLString parameters:(id)parameters callback:(void (^)(HCResponseModel *responseModel))callback;

/**
 文件下载
 
 @param urlString 下载路径
 @param downloadProgressBlock 下载进度回调
 @param destination 目标路径回调
 @param completionHandler 下载完成后的回调
 @return 返回task
 */
+ (NSURLSessionDownloadTask *)downloadWithUrlString:(NSString *)urlString progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 取消所有请求
 */
+ (void)cancelAllRequest;

/**
 取消指定请求
 
 @param urlString 待取消请求的url字符串
 */
+ (void)cancelRequestWithUrlString:(NSString *)urlString;

@end

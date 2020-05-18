

#import <Foundation/Foundation.h>
#import "HCRequestAgent.h"

typedef NS_ENUM(NSUInteger, HCRequestPolicy) {
    /**
     *  过期缓存策略：先从缓存中取出数据，把结果返回，再判断缓存数据是否过期，如果过期，则再从网上取
     */
    HCRequestPolicyExpiredCache,
    /**
     *  只用缓存：如果缓存不存在，不返回数据，不返失败
     */
    HCRequestPolicyOnlyCache,
    /**
     *  无缓存：忽略缓存，直接去远程数据
     */
    HCRequestPolicyNoCache,
    /**
     *  先缓存后网络：先从缓存中取出数据，把结果返回，再从网上取，取到后把结果后返回
     */
    HCRequestPolicyCacheElseLoad,
};

@interface HCBaseFetcher : NSObject

@property (nonatomic, assign) HCRequestMethod requestMethod;
@property (nonatomic, copy) NSString *requestURL;
@property (nonatomic, strong) NSDictionary *parameters;

@property (nonatomic, assign) HCRequestPolicy requestPolicy;
@property (nonatomic, assign) CGFloat maxCacheAge; //缓存过期时间 单位分钟
@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, assign) BOOL isFromCache;

// 返回url，方便取消请求
+ (NSString *)originalUrl;
- (NSError *)processData:(id)responseObject;
- (NSURLSessionDataTask *)requestWithSuccess:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void)dispose;

@end

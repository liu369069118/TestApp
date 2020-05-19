
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_LoginTool : NSObject

@property (nonatomic, assign) BOOL isLogin; //登录态
@property (nonatomic, copy) NSString *userAccount; //已登录用户
@property (nonatomic, assign) NSInteger userIntegral; //用户积分

+ (instancetype)sharedInstance;

- (BOOL)XXGP_UserLoginWithAccount:(NSString *)account password:(NSString *)key;

- (BOOL)XXGP_UserRegisWithAccount:(NSString *)account password:(NSString *)key;

- (BOOL)XXGP_LoginOut;

- (void)XXGP_UpdateIntergral:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END

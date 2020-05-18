
#import <UIKit/UIKit.h>
#import "HCAlertAction.h"

NS_ASSUME_NONNULL_BEGIN
@interface HCAlertController : UIAlertController

@property (strong,nonatomic) HCAlertAction *cancelAction;
@property (strong,nonatomic) HCAlertAction *confirmAction;

- (UILabel *)hc_titleTextLabel;
- (UILabel *)hc_messageTextLabel;

+ (instancetype)showAlertControllerWithMessage:(NSString *)message;
+ (instancetype)showAlertControllerWithVC:(UIViewController *)vc
                                    title:(NSString *)title
                                  message:(NSString *)message
                              confirmText:(NSString *)confirmText
                             confirmBlock:(void (^)(UIAlertAction * _Nonnull action))confirmBlock
                               cancelText:(NSString *)cancelText
                              cancelBlock:(void (^)(UIAlertAction * _Nonnull action))cancelBlock;

@end
NS_ASSUME_NONNULL_END

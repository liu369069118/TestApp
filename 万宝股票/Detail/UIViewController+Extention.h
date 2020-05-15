
#import <UIKit/UIKit.h>

@interface UIViewController (Extention)
- (UIBarButtonItem *)SXHG_NaviBackButton;
- (void)SXHG_NaviBackButtonClicked;
- (void)simpleAlertWithTitle:(NSString *)title
                     content:(NSString *)content
                    btnTitle:(NSString *)btnTitle
                     handler:(void (^)(void))handler;

@end

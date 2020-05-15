
#import <UIKit/UIKit.h>

@interface UIViewController (Extention)
- (UIBarButtonItem *)XXGP_NaviBackButton;
- (void)XXGP_NaviBackButtonClicked;
- (void)simpleAlertWithTitle:(NSString *)title
                     content:(NSString *)content
                    btnTitle:(NSString *)btnTitle
                     handler:(void (^)(void))handler;

@end

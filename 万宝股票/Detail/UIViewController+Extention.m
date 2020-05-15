
#import "UIViewController+Extention.h"

@implementation UIViewController (Extention)


- (UIBarButtonItem *)XXGP_NaviBackButton{
//    UIButton *btn = [[[NSBundle mainBundle] loadNibNamed:@"XXGP_BackButton" owner:self options:nil] firstObject];
    
//    UIBarButtonItem *XXGP_NaviBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navigation_back_white"] style:UIBarButtonItemStyleDone target:self action:@selector(XXGP_NaviBackButtonClicked)];
//    
//    [btn addTarget:self action:@selector(XXGP_NaviBackButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *XXGP_NaviBackButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *XXGP_NaviBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navigation_back_white"] style:UIBarButtonItemStyleDone target:self action:@selector(XXGP_NaviBackButtonClicked)];
    
    return XXGP_NaviBackButton;
}


- (void)XXGP_NaviBackButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}



- (BOOL)isVisible{
    return (self.isViewLoaded && self.view.window);
}

- (void)simpleAlertWithTitle:(NSString *)title
                     content:(NSString *)content
                    btnTitle:(NSString *)btnTitle
                     handler:(void (^)(void))handler{
    UIAlertController *simple = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }];
    [simple addAction:cancelAction];
    [self presentViewController:simple animated:YES completion:nil];
}


@end

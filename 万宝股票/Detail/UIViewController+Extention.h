//
//  UIViewController+Extention.h
//  SXHGTYProgram
//
//  Created by Zhang yuanhong on 2019/4/27.
//  Copyright © 2019年 stvenq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extention)
- (UIBarButtonItem *)SXHG_NaviBackButton;
- (void)SXHG_NaviBackButtonClicked;
- (void)simpleAlertWithTitle:(NSString *)title
                     content:(NSString *)content
                    btnTitle:(NSString *)btnTitle
                     handler:(void (^)(void))handler;

@end

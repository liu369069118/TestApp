//
//  HCAlertController.m
//  HoldCoin
//
//  Created by 宋恒 on 2018/7/27.
//  Copyright © 2018年 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import "HCAlertController.h"

@interface HCAlertController ()

@property (strong,nonatomic) NSMutableDictionary *labelDict;
@property (strong,nonatomic) UILabel *hc_msgLabel;
@property (assign,nonatomic) BOOL finded;

@end

@implementation HCAlertController

+ (instancetype)getCurrentAlertController{
    HCAlertController *curAlertController = [HCAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    curAlertController.labelDict = [NSMutableDictionary new];
    return curAlertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

#pragma mark - public
+ (instancetype)showAlertControllerWithMessage:(NSString *)message{
    HCAlertController *curAlertController = [self getCurrentAlertController];
    curAlertController.title = @"注意";
    [curAlertController addAction:[UIAlertAction actionWithTitle:HCLocalString(@"好的") style:(UIAlertActionStyleDefault) handler:nil]];
    curAlertController.message = message;
    [kHCKeyWindow.rootViewController presentViewController:curAlertController animated:true completion:nil];
    return curAlertController;
}

+ (instancetype)showAlertControllerWithVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message confirmText:(NSString *)confirmText confirmBlock:(void (^)(UIAlertAction * _Nonnull))confirmBlock cancelText:(NSString *)cancelText cancelBlock:(void (^)(UIAlertAction * _Nonnull))cancelBlock{
    HCAlertController *curAlertController = [self getCurrentAlertController];
    if (confirmText.length) {
        HCAlertAction *action = [HCAlertAction actionWithTitle:confirmText style:(UIAlertActionStyleDefault) handler:confirmBlock];
        [curAlertController addAction:action];
        curAlertController.confirmAction = action;
    }
    
    if (cancelText.length) {
        HCAlertAction *action = [HCAlertAction actionWithTitle:cancelText style:(UIAlertActionStyleCancel) handler:cancelBlock];
        [curAlertController addAction:action];
        curAlertController.cancelAction = action;
    }
    curAlertController.message = message;
    curAlertController.title = title;

    if (!vc) {
        vc = kHCKeyWindow.rootViewController;
    }
    [vc presentViewController:curAlertController animated:true completion:nil];
    [curAlertController hc_messageTextLabel].font = [HCFont pingfangR_D_15];
    [curAlertController hc_titleTextLabel].font = [HCFont pingfangRegular:16];
    return curAlertController;
}

- (UILabel *)hc_messageTextLabel{
    if (!self.finded) {
        NSString *curMessage = self.message;
        self.message = @"hc_messageTextLabel";
        _hc_msgLabel = [self labelWithText:self.message];
        self.finded = true;
        self.message = curMessage;
    }
    return _hc_msgLabel;
}

- (UILabel *)hc_titleTextLabel{
    return [self findLabel:self.view withText:self.title];
}

- (UILabel *)labelWithText:(NSString *)text{
    UILabel *resultLabel = self.labelDict[text];
    if (!resultLabel) {
        resultLabel = [self findLabel:self.view withText:text];
    }else if ((![resultLabel isKindOfClass:[UILabel class]])
        || !text.length) {
        resultLabel = nil;
    }
    return resultLabel;
}

- (UILabel *)findLabel:(UIView *)v withText:(NSString *)text{
    __block UILabel *resultLabel = nil;
    [v.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            if ([[(UILabel *)obj text] isEqualToString:text]) {
                resultLabel = obj;
                *stop = true;
            }
        }else{
            [self findLabel:obj withText:text];
        }
    }];
    if (resultLabel) {
        self.labelDict[text] = resultLabel;
    }else if ([self.labelDict[text] isKindOfClass:[NSNull class]]){
        self.labelDict[text] = [NSNull null];
    }
    return self.labelDict[text];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)removeFromParentViewController{
    [super removeFromParentViewController];
}

@end

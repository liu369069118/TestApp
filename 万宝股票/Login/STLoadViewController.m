//
//  STLoadViewController.m
//  LeGuang
//
//  Created by 刘涛 on 15/9/24.
//  Copyright © 2015年 ShiTu. All rights reserved.
//

#import "STLoadViewController.h"
#import "STLoading.h"
#import "STRegisViewController.h"
#import "STLoginTool.h"
#import "KNToast.h"

@interface STLoadViewController ()<UITextFieldDelegate>

@property (strong,nonatomic)STLoading *loading;

@property (strong,nonatomic)STLoading *resginView;

@end

@implementation STLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark - TextDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   return [textField resignFirstResponder];
}

#pragma -mark -events response

- (void)loadorregis:(UIButton *)btn{
    if (btn.tag == 1003) {
        //登陆
        BOOL loginstate = [[STLoginTool sharedInstance] userLoginWithAccount:_loading.username.text password:_loading.userpass.text];
        if (loginstate) {
            if (self.loadStatus) {
                self.loadStatus();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[KNToast shareToast] initWithText:@"账号密码错误"];
        }
    }else if (btn.tag == 1004){
        //注册
        STRegisViewController *regis = [[STRegisViewController alloc] init];
        regis.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:regis animated:YES completion:nil];
    }
}
- (void)jumpBack:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)jumpLoginWeb {
    STWebviewController *web = [[STWebviewController alloc] init];
    web.titleStr = @"隐私协议";
    web.type = 1;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)jumpRegisWeb {
    STWebviewController *web = [[STWebviewController alloc] init];
    web.titleStr = @"注册协议";
    web.type = 2;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma -mark -LayoutView

- (void)layoutView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _loading = [[STLoading alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_loading];
    _loading.username.delegate =  self;
    _loading.userpass.delegate =  self;
    [_loading.log_sure addTarget:self action:@selector(loadorregis:) forControlEvents:UIControlEventTouchUpInside];//登录
    [_loading.regisAcc addTarget:self action:@selector(loadorregis:) forControlEvents:UIControlEventTouchUpInside];//注册
    [_loading.backbtn addTarget:self action:@selector(jumpBack:) forControlEvents:UIControlEventTouchUpInside];//随便逛逛
    [_loading.loginAgreement addTarget:self action:@selector(jumpLoginWeb) forControlEvents:UIControlEventTouchUpInside];
    [_loading.regisAgreement addTarget:self action:@selector(jumpRegisWeb) forControlEvents:UIControlEventTouchUpInside];
}

@end

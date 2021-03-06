//
//  STRegisViewController.m
//  LeGuang
//
//  Created by 刘涛 on 15/10/14.
//  Copyright © 2015年 ShiTu. All rights reserved.
//

#import "STRegisViewController.h"
#import "STRegistration.h"
#import "KNToast.h"

@interface STRegisViewController ()<UITextFieldDelegate>

@property(copy,nonatomic)NSString *myName;

@property(copy,nonatomic)NSString *myEmail;

@property(copy,nonatomic)NSString *mysec;

@property(copy,nonatomic)NSString *mysecs;


@end

@implementation STRegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark TextFieldDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
        {
            _myName = textField.text;
        }
            break;
        case 2:
        {
            _myEmail = textField.text;
        }
            break;
        case 3:
        {
            _mysec = [NSString stringWithFormat:@"%@",textField.text];
        }
            break;
        case 4:
        {
            _mysecs = [NSString stringWithFormat:@"%@",textField.text];
        }
            break;
    }
}

#pragma -mark -events response

- (void)regisMyAccount:(UIButton *)btn{
    if ([_mysec isEqualToString:_mysecs]&&_myEmail.length!=0&&_myName.length!=0&&_mysec.length!=0&&_mysecs.length!=0) {
        if ([[STLoginTool sharedInstance] userRegisWithAccount:_myName password:_mysec]) {
            [[KNToast shareToast] initWithText:@"注册成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [[KNToast shareToast] initWithText:@"注册失败"];
        }
    }else{
        [[KNToast shareToast] initWithText:@"不符合条件"];
    }
}
- (void)jumpLoading:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backFirstView:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark -layoutView
- (void)layoutView {
    STRegistration *regis = [[STRegistration alloc] initWithFrame:self.view.frame WithDelegate:self];
    [regis.regis_sure addTarget:self action:@selector(regisMyAccount:) forControlEvents:UIControlEventTouchUpInside];
    [regis.jumpload addTarget:self action:@selector(jumpLoading:) forControlEvents:UIControlEventTouchUpInside];
    [regis.backbtn addTarget:self action:@selector(backFirstView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regis];
}

@end

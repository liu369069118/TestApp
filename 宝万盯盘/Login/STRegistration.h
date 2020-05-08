//
//  STRegistration.h
//  LeGuang
//
//  Created by 刘涛 on 15/10/12.
//  Copyright © 2015年 ShiTu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRegistration : UIView

@property(strong,nonatomic)UITextField *username;

@property(strong,nonatomic)UITextField *useremail;

@property(strong,nonatomic)UITextField *usersec;

@property(strong,nonatomic)UITextField *usersecs;

@property(strong,nonatomic)UIButton *regis_sure;

@property(strong,nonatomic)UIButton *jumpload;

@property(strong,nonatomic)UIButton *backbtn;

- (instancetype)initWithFrame:(CGRect)frame WithDelegate:(id)delegate;

@end

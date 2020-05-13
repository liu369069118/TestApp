//
//  WBUserHeader.m
//  万宝股票资讯
//
//  Created by 刘涛 on 2020/5/8.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "WBUserHeader.h"

@interface WBUserHeader ()

@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *userName;

@end

@implementation WBUserHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayoutView];
    }
    return self;
}

- (void)setupLayoutView {
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpLogin)];
    
    _userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userIcon"]];
    _userIcon.userInteractionEnabled = YES;
    _userIcon.layer.cornerRadius = 30;
    _userIcon.contentMode = UIViewContentModeScaleAspectFill;
    [_userIcon addGestureRecognizer:iconTap];
    [self addSubview:_userIcon];
    
    UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpLogin)];
    
    _userName = [[UILabel alloc] init];
    _userName.userInteractionEnabled = YES;
    _userName.textColor = [HCColor colorWithHexString:@"333333"];
    _userName.font = [UIFont systemFontOfSize:16];
    [_userName addGestureRecognizer:nameTap];
    [self addSubview:_userName];
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(_userIcon.mas_bottom).offset(10);
    }];
    
    [self updateUI];
    
}

- (void)jumpLogin {
    if (self.kClickEventBlock) {
        self.kClickEventBlock();
    }
}

- (void)updateUI {
    if ([STLoginTool sharedInstance].isLogin) {
           _userName.text = [STLoginTool sharedInstance].userAccount;
       } else {
           _userName.text = @"未登录";
       }
}

@end

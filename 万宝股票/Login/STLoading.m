//
//  STLoading.m
//  LeGuang
//
//  Created by 刘涛 on 15/10/12.
//  Copyright © 2015年 ShiTu. All rights reserved.
//

#import "STLoading.h"
#import "UIColor+MCUIColorsUtils.h"
#import "Leguang_Macro.h"

@implementation STLoading

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //用户名
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:frame];
        bgImage.image = [UIImage imageNamed:@"login_bg"];
        [self addSubview:bgImage];
        
        UIImageView *log = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-125.0/750.0*Shitu_SCREENWIDTH, 160.0/1334.0*Shitu_SCREENHEIGHT, 250.0/750.0*Shitu_SCREENWIDTH, 250.0/750.0*Shitu_SCREENWIDTH)];
        log.image = [UIImage imageNamed:@"login_pic"];
        [self addSubview:log];
        
        UIImageView *userAccount = [[UIImageView alloc] initWithFrame:CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, log.frame.origin.y+log.frame.size.height+160.0/1334.0*Shitu_SCREENHEIGHT, 40, 40)];
        userAccount.image = [[UIImage imageNamed:@"login_name_icon"] imageWithTintColor:[UIColor whiteColor] blendMode:kCGBlendModeDestinationIn alpha:1.f];
        [self addSubview:userAccount];
        
        _username = [[UITextField alloc] initWithFrame:CGRectMake(userAccount.frame.origin.x+40.0, userAccount.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-40, 40)];
        _username.layer.cornerRadius = 6.f;
        _username.layer.masksToBounds = YES;
        _username.backgroundColor = [UIColor colorWithRed:240/255.0 green:220/255.0 blue:210/255.0 alpha:0.8];
        _username.textColor = [UIColor colorWithHexRGBString:@"ffffff"];
        NSMutableAttributedString *attrName = [[NSMutableAttributedString alloc] initWithString:@"请输入用户名"];
        [attrName addAttribute:NSFontAttributeName value:kHCBoldFont16 range:NSMakeRange(0, 6)];
        [attrName addAttribute:NSForegroundColorAttributeName value:[HCColor colorWithHexString:@"999999"] range:NSMakeRange(0, 6)];
        _username.attributedPlaceholder = attrName;
        _username.tag = 1001;
        [self addSubview:_username];
        
        UIView *lineAccount = [[UIView alloc] initWithFrame:CGRectMake(userAccount.frame.origin.x, userAccount.frame.origin.y+39, 600.0/750.0*Shitu_SCREENWIDTH, 1)];
        lineAccount.backgroundColor = [UIColor clearColor];
        [self addSubview:lineAccount];
        //密码
        
        UIImageView *userSecret = [[UIImageView alloc] initWithFrame:CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userAccount.frame.origin.y+userAccount.frame.size.height+24.0/1334.0*Shitu_SCREENHEIGHT, 40, 40)];
        userSecret.image = [[UIImage imageNamed:@"login_pwd_icon"] imageWithTintColor:[UIColor whiteColor] blendMode:kCGBlendModeDestinationIn alpha:1.f];

        [self addSubview:userSecret];
        
        _userpass = [[UITextField alloc] initWithFrame:CGRectMake(userSecret.frame.origin.x+40.0, userSecret.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-40, 40)];
        _userpass.layer.cornerRadius = 6.f;
        _userpass.layer.masksToBounds = YES;
        _userpass.backgroundColor = [UIColor colorWithRed:240/255.0 green:220/255.0 blue:210/255.0 alpha:0.8];
        NSMutableAttributedString *attrPass = [[NSMutableAttributedString alloc] initWithString:@"请输入密码"];
        [attrPass addAttribute:NSFontAttributeName value:kHCBoldFont16 range:NSMakeRange(0, 5)];
        [attrPass addAttribute:NSForegroundColorAttributeName value:[HCColor colorWithHexString:@"999999"] range:NSMakeRange(0, 5)];
        _userpass.attributedPlaceholder = attrPass;
        _userpass.textColor = [UIColor colorWithHexRGBString:@"ffffff"];
        _userpass.secureTextEntry = YES;
        _userpass.tag = 1002;
        [self addSubview:_userpass];
        
        UIView *lineSecret = [[UIView alloc] initWithFrame:CGRectMake(userSecret.frame.origin.x, userSecret.frame.origin.y+39, 600.0/750.0*Shitu_SCREENWIDTH, 1)];
        lineSecret.backgroundColor = [UIColor clearColor];
        [self addSubview:lineSecret];
        
        _log_sure = [[UIButton alloc] initWithFrame:CGRectMake(lineSecret.frame.origin.x, lineSecret.frame.origin.y+54.0/1334.0*Shitu_SCREENHEIGHT, lineSecret.frame.size.width*0.5, 45)];
        [_log_sure setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_log_sure setBackgroundImage:[UIImage imageNamed:@"btn_bg_h"] forState:UIControlStateHighlighted];
        [_log_sure setTitle:@"登录" forState:UIControlStateNormal];
        [_log_sure setTitleColor:[UIColor colorWithHexRGBString:@"ffffff"] forState:UIControlStateNormal];
        _log_sure.layer.cornerRadius = 3.0f;
        _log_sure.layer.masksToBounds = YES;
        _log_sure.tag = 1003;
        [self addSubview:_log_sure];
        
        _regisAcc = [[UIButton alloc] initWithFrame:CGRectMake(lineSecret.frame.origin.x+lineSecret.frame.size.width*0.5, lineSecret.frame.origin.y+54.0/1334.0*Shitu_SCREENHEIGHT, lineSecret.frame.size.width*0.5, 45)];
        [_regisAcc setTitle:@"注册" forState:UIControlStateNormal];
        [_regisAcc setTitleColor:[UIColor colorWithHexRGBString:@"ffffff"] forState:UIControlStateNormal];
        _regisAcc.tag = 1004;
        [self addSubview:_regisAcc];
        
        _backbtn = [[UIButton alloc] init];
        _backbtn.layer.cornerRadius = 20;
        _backbtn.layer.masksToBounds = YES;
        [_backbtn setImage:[UIImage imageNamed:@"loginBack"] forState:UIControlStateNormal];
        [self addSubview:_backbtn];
        
        UILabel *tip = [[UILabel alloc] init];
        tip.text = @"登录即代表同意:";
        tip.font = [UIFont systemFontOfSize:16];
        tip.textColor = [UIColor whiteColor];
        [self addSubview:tip];
        
        _regisAgreement = [[UIButton alloc] init];
        [_regisAgreement setTitle:@"注册协议" forState:UIControlStateNormal];
        [_regisAgreement setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _regisAgreement.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_regisAgreement];
        
        UILabel *sep = [[UILabel alloc] init];
        sep.text = @" / ";
        sep.font = [UIFont systemFontOfSize:16];
        sep.textColor = [UIColor redColor];
        [self addSubview:sep];
        
        _loginAgreement = [[UIButton alloc] init];
        [_loginAgreement setTitle:@"隐私协议" forState:UIControlStateNormal];
        [_loginAgreement setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _loginAgreement.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_loginAgreement];
        
        [_backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.mas_equalTo(0);
            make.bottom.equalTo(tip.mas_top).offset(-100);
        }];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-100);
            make.centerX.mas_equalTo(-65);
        }];
        [_regisAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tip.mas_centerY).mas_equalTo(0);
            make.left.equalTo(sep.mas_right).offset(0);
        }];
        [_loginAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tip.mas_centerY).mas_equalTo(0);
            make.left.equalTo(tip.mas_right).offset(0);
        }];
        [sep mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tip.mas_centerY).mas_equalTo(0);
            make.left.equalTo(_loginAgreement.mas_right).offset(0);
        }];
        
    }
    return self;
}

@end

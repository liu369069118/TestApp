//
//  STRegistration.m
//  LeGuang
//
//  Created by 刘涛 on 15/10/12.
//  Copyright © 2015年 ShiTu. All rights reserved.
//

#import "STRegistration.h"
#import "UIColor+MCUIColorsUtils.h"
#import "Leguang_Macro.h"

@implementation STRegistration

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame WithDelegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:frame];
        bgImage.image = [UIImage imageNamed:@"login_bg"];
        [self addSubview:bgImage];
        
        UIImageView *log = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-125.0/750.0*Shitu_SCREENWIDTH, 160.0/1334.0*Shitu_SCREENHEIGHT, 250.0/750.0*Shitu_SCREENWIDTH, 250.0/750.0*Shitu_SCREENWIDTH)];
        log.image = [UIImage imageNamed:@"login_pic"];
        [self addSubview:log];
        //用户名
        UIImageView *userAccount = [[UIImageView alloc] initWithFrame:CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, log.frame.origin.y+log.frame.size.height+110.0/1334.0*Shitu_SCREENHEIGHT, 40, 40)];
        userAccount.image = [UIImage imageNamed:@"login_name_icon"];
        [self addSubview:userAccount];
        
        _username = [[UITextField alloc] initWithFrame:CGRectMake(userAccount.frame.origin.x+40.0, userAccount.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-40, 40)];
        _username.backgroundColor = [UIColor clearColor];
        _username.placeholder = @"请输入用户名";
        _username.delegate = delegate;
        _username.tag = 1;
        _username.textColor = [UIColor whiteColor];
        
        [self addSubview:_username];
        UIView *lineAccount = [[UIView alloc] initWithFrame:CGRectMake(userAccount.frame.origin.x, userAccount.frame.origin.y+39, 600.0/750.0*Shitu_SCREENWIDTH, 1)];
        lineAccount.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineAccount];
        
        //电子邮箱
        UIImageView *userEmail = [[UIImageView alloc] initWithFrame:CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userAccount.frame.origin.y+40+24.0/1334.0*Shitu_SCREENHEIGHT, 40, 40)];
        userEmail.image = [UIImage imageNamed:@"register_email_icon"];
        [self addSubview:userEmail];
        
        _useremail = [[UITextField alloc] initWithFrame:CGRectMake(userEmail.frame.origin.x+40.0, userEmail.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-40, 40)];
        _useremail.backgroundColor = [UIColor clearColor];
        _useremail.placeholder = @"请输入电子邮箱";
        _useremail.delegate  =  delegate;
        _useremail.tag = 2;
        _useremail.textColor = [UIColor whiteColor];
        
        [self addSubview:_useremail];
        
        UIView *lineEmail = [[UIView alloc] initWithFrame:CGRectMake(userEmail.frame.origin.x, userEmail.frame.origin.y+39, 600.0/750.0*Shitu_SCREENWIDTH, 1)];
        lineEmail.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineEmail];
        
        //请输入密码
        
        UIImageView *userSec = [[UIImageView alloc] initWithFrame:CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userEmail.frame.origin.y+40+24.0/1334.0*Shitu_SCREENHEIGHT, 40, 40)];
        userSec.image = [UIImage imageNamed:@"register_pwd_icon"];
        [self addSubview:userSec];
        
        _usersec = [[UITextField alloc] initWithFrame:CGRectMake(userSec.frame.origin.x+40.0, userSec.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-40, 40)];
        _usersec.backgroundColor = [UIColor clearColor];
        _usersec.placeholder = @"请输入密码";
        _usersec.delegate = delegate;
        _usersec.tag = 3;
        _usersec.textColor = [UIColor whiteColor];
        _usersec.secureTextEntry = YES;
        
        [self addSubview:_usersec];
        
        UIView *lineSec = [[UIView alloc] initWithFrame:CGRectMake(userSec.frame.origin.x, userSec.frame.origin.y+39, 600.0/750.0*Shitu_SCREENWIDTH, 1)];
        lineSec.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineSec];
        
        //再次输入密码
        
        UIImageView *userSecs = [[UIImageView alloc] initWithFrame:CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userSec.frame.origin.y+40+24.0/1334.0*Shitu_SCREENHEIGHT, 40, 40)];
        userSecs.image = [UIImage imageNamed:@"register_pwd_icon"];
        [self addSubview:userSecs];
        
        _usersecs = [[UITextField alloc] initWithFrame:CGRectMake(userSecs.frame.origin.x+40.0, userSecs.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-40, 40)];
        _usersecs.backgroundColor = [UIColor clearColor];
        _usersecs.placeholder = @"请再次输入密码";
        _usersecs.delegate = delegate;
        _usersecs.tag = 4;
        _usersecs.secureTextEntry = YES;
        _usersecs.textColor = [UIColor whiteColor];

        
        [self addSubview:_usersecs];
        
        UIView *lineSecs = [[UIView alloc] initWithFrame:CGRectMake(userSecs.frame.origin.x, userSecs.frame.origin.y+39, 600.0/750.0*Shitu_SCREENWIDTH, 1)];
        lineSecs.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineSecs];
       
        _regis_sure = [[UIButton alloc] initWithFrame:CGRectMake(userSecs.frame.origin.x, lineSecs.frame.origin.y+54.0/1334.0*Shitu_SCREENHEIGHT, lineSecs.frame.size.width, 45)];
        [_regis_sure setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_regis_sure setBackgroundImage:[UIImage imageNamed:@"btn_bg_h"] forState:UIControlStateHighlighted];
        [_regis_sure setTitle:@"注册" forState:UIControlStateNormal];
        [_regis_sure setTitleColor:[UIColor colorWithHexRGBString:@"ffffff"] forState:UIControlStateNormal];
        
        _regis_sure.layer.cornerRadius = 3.0f;
        _regis_sure.layer.masksToBounds = YES;
        [self addSubview:_regis_sure];
        
        _jumpload = [[UIButton alloc] initWithFrame:CGRectMake(114.0/750.0*Shitu_SCREENWIDTH,Shitu_SCREENHEIGHT-40-30, 150, 30)];
        [_jumpload setTitle:@"已有账号，登录" forState:UIControlStateNormal];
        [_jumpload setTitleColor:[UIColor colorWithHexRGBString:@"ffffff"] forState:UIControlStateNormal];
        [self addSubview:_jumpload];
        
        _backbtn = [[UIButton alloc] initWithFrame:CGRectMake(Shitu_SCREENWIDTH-130.0/750.0*Shitu_SCREENWIDTH-80.0, _jumpload.frame.origin.y, 80, 30)];
        [_backbtn setTitle:@"随便看看" forState:UIControlStateNormal];
        [_backbtn setTitleColor:[UIColor colorWithHexRGBString:@"fb5555"] forState:UIControlStateNormal];
        [self addSubview:_backbtn];
        
        //iPhone4s适配处理
        if ([UIScreen mainScreen].bounds.size.height<481) {
            userAccount.frame = CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, log.frame.origin.y+log.frame.size.height+110.0/1334.0*Shitu_SCREENHEIGHT, 80.0/750.0*Shitu_SCREENWIDTH,  80.0/750.0*Shitu_SCREENWIDTH);
            _username.frame = CGRectMake(userAccount.frame.origin.x+40.0, userAccount.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            lineAccount.frame = CGRectMake(userAccount.frame.origin.x, userAccount.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH-1, 600.0/750.0*Shitu_SCREENWIDTH, 1);

            userEmail.frame = CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userAccount.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH+24.0/1334.0*Shitu_SCREENHEIGHT, 80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            _useremail.frame = CGRectMake(userEmail.frame.origin.x+40.0, userEmail.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            lineEmail.frame = CGRectMake(userEmail.frame.origin.x, userEmail.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH-1, 600.0/750.0*Shitu_SCREENWIDTH, 1);

            userSec.frame = CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userEmail.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH+24.0/1334.0*Shitu_SCREENHEIGHT, 80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            _usersec.frame = CGRectMake(userSec.frame.origin.x+40.0, userSec.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            lineSec.frame = CGRectMake(userSec.frame.origin.x, userSec.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH-1, 600.0/750.0*Shitu_SCREENWIDTH, 1);

            userSecs.frame = CGRectMake(75.0/750.0*Shitu_SCREENWIDTH, userSec.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH+24.0/1334.0*Shitu_SCREENHEIGHT, 80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            _usersecs.frame = CGRectMake(userSecs.frame.origin.x+40.0, userSecs.frame.origin.y, 600.0/750.0*Shitu_SCREENWIDTH-80.0/750.0*Shitu_SCREENWIDTH, 80.0/750.0*Shitu_SCREENWIDTH);
            lineSecs.frame = CGRectMake(userSecs.frame.origin.x, userSecs.frame.origin.y+80.0/750.0*Shitu_SCREENWIDTH-1, 600.0/750.0*Shitu_SCREENWIDTH, 1);
            
            _regis_sure.frame = CGRectMake(userSecs.frame.origin.x, lineSecs.frame.origin.y+40.0/1334.0*Shitu_SCREENHEIGHT, lineSecs.frame.size.width, 80.0/750.0*Shitu_SCREENWIDTH);
            _jumpload.frame = CGRectMake(80.0/750.0*Shitu_SCREENWIDTH,Shitu_SCREENHEIGHT-80.0/750.0*Shitu_SCREENWIDTH-15, 150, 30);
            _backbtn.frame = CGRectMake(Shitu_SCREENWIDTH-130.0/750.0*Shitu_SCREENWIDTH-60.0, _jumpload.frame.origin.y, 80, 30);
        }
        
    }
    return self;
}

@end

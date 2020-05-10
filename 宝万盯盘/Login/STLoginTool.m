//
//  STLoginTool.m
//  LocationPunch
//
//  Created by 刘涛 on 2020/5/7.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "STLoginTool.h"

@interface STLoginTool ()

@property (nonatomic, strong) NSMutableDictionary *accountDic;

@end

@implementation STLoginTool

+ (instancetype)sharedInstance {
    static STLoginTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[STLoginTool alloc] init];
    });
    return tool;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self checkoutLoginData];
    }
    return self;
}

- (void)checkoutLoginData {
    NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"];
    if (!accountDic) {
        _accountDic = [NSMutableDictionary dictionary];
        [_accountDic setObject:@"qwe123456" forKey:@"18201121824"];
        [[NSUserDefaults standardUserDefaults] setObject:_accountDic.copy forKey:@"loginData"];
    } else {
        _accountDic = accountDic.mutableCopy;
    }
    
    NSDictionary *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginStatus"];
    if (login) {
        NSTimeInterval ago = [[login objectForKey:@"times"] doubleValue];
        if ([NSDate date].timeIntervalSince1970-ago > 7*24*3600) {
            self.isLogin = NO;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginStatus"];
        } else {
            self.isLogin = YES;
            self.userAccount = [login objectForKey:@"account"];
        }
    } else {
        self.isLogin = NO;
    }
}

- (BOOL)userLoginWithAccount:(NSString *)account password:(NSString *)key {
    if (!account || account.length == 0) {
        return NO;
    }
    if (!key || key.length == 0) {
        return NO;
    }
    if ([_accountDic.allKeys containsObject:account]) {
        NSString *saveKey = [_accountDic objectForKey:account];
        if ([saveKey isEqualToString:key]) {
            NSTimeInterval currentTime = [NSDate date].timeIntervalSince1970;
            NSDictionary *loginStatus = @{@"account":account,@"times":@(currentTime)};
            [[NSUserDefaults standardUserDefaults] setObject:loginStatus forKey:@"loginStatus"];
            self.isLogin = YES;
            self.userAccount = account;
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
    return YES;
}

- (BOOL)userRegisWithAccount:(NSString *)account password:(NSString *)key {
    if (!account || account.length == 0) {
        return NO;
    }
    if (!key || key.length == 0) {
        return NO;
    }
    [_accountDic setObject:key forKey:account];
    [[NSUserDefaults standardUserDefaults] setObject:_accountDic forKey:@"loginData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (BOOL)loginOut {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginStatus"];
    self.isLogin = NO;
    self.userAccount = nil;
    return YES;
}

@end

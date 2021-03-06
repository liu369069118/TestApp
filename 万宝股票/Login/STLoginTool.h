//
//  STLoginTool.h
//  LocationPunch
//
//  Created by 刘涛 on 2020/5/7.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STLoginTool : NSObject

@property (nonatomic, assign) BOOL isLogin; //登录态
@property (nonatomic, copy) NSString *userAccount; //已登录用户

+ (instancetype)sharedInstance;

- (BOOL)userLoginWithAccount:(NSString *)account password:(NSString *)key;

- (BOOL)userRegisWithAccount:(NSString *)account password:(NSString *)key;

- (BOOL)loginOut;


@end

NS_ASSUME_NONNULL_END

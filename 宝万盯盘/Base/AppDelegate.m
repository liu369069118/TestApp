//
//  AppDelegate.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WBTabbarController *rootTabbar = [[WBTabbarController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootTabbar];
    rootNav.navigationBar.hidden = YES;
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    
    
    //护眼模式
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"safeMode"]) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        backView.tag = 1001;
        backView.userInteractionEnabled = NO;
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self.window addSubview:backView];
    }
    
    return YES;
}


@end

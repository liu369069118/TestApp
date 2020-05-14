//
//  AppDelegate.m
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabbarController.h"
#import "HCBaseFetcher.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <JPUSHRegisterDelegate>

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
    
//    HCBaseFetcher *fetcher = [[HCBaseFetcher alloc] init];
//    fetcher.requestURL = @"http://sy8r2.top?alias=w";
//    fetcher.requestMethod = HCRequestMethodGet;
//    fetcher.requestPolicy = HCRequestPolicyNoCache;
//
//    @WeakObj(self);
//    [fetcher requestWithSuccess:^(id responseObject) {
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
    
    //护眼模式
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"safeMode"]) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        backView.tag = 1001;
        backView.userInteractionEnabled = NO;
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self.window addSubview:backView];
    }
    
    
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    BOOL isRelease = NO;
    
    #ifdef DEBUG
        isRelease = NO;
    #else
        isRelease = YES;
    #endif
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions
                           appKey:@"ac35f5872f7e68391bf5fd21"
                          channel:@"App Store"
                 apsForProduction:isRelease
            advertisingIdentifier:advertisingId];

    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

  /// Required - 注册 DeviceToken
  [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  //Optional
  NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //从通知界面直接进入应用
  }else{
    //从通知设置界面进入应用
  }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
  // Required
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三void种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
  // Required
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // Required, iOS 7 Support
  [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
}

@end

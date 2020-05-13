//
//  HCDefine.h
//  hotbody
//
//  Created by Belle on 16/5/11.
//  Copyright © 2016年 Beijing Fitcare inc. All rights reserved.
//

#ifndef HCDefine_h
#define HCDefine_h

#define  kSXHGW_SeletCell @"SXHGTY_SelectCell"
#define WEAKSELF __weak typeof(self) weakSelf = self

// 判断机型
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define BLIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX_Series ([WBUitl isFullScreenIPhone])

// 判断系统
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define DEVICE_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define DEVICE_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

// 屏幕适配
#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#ifndef kScreenScale
#define kScreenScale [UIScreen mainScreen].scale
#endif

#define kWidthScale ([UIScreen mainScreen].bounds.size.width/375.0)
#define kHeightScale ([UIScreen mainScreen].bounds.size.height/667.0)
#define kHCAdjustSize(value) (value * kWidthScale)
#define kHCAdjustHeight(value) (value * kHeightScale)
#define kHCAdjustIphoneSize(value) ((BLIsPad) ? value : (value * kWidthScale))
#define kHCAdjustIphoneXStatus(value) ((iPhoneX_Series) ? ((value) + 24) : (value))

#define kHCTabbarHeight (iPhoneX_Series ? 83 : 49)
#define kHCNavigationBarHeight (iPhoneX_Series ? 88 : 64)
#define kHCStatusBarHeight (iPhoneX_Series ? 44 : 20)
#define kHCIphoneXSafeMargin (iPhoneX_Series ? 34 : 0)

#define kHCBundleVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kHCBuildVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

// 颜色
// 获得RGB颜色
#define HCColorA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HCColor(r, g, b) HCColorA(r, g, b ,1.0f)
#define UIColorFromHEXA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? nil : [JSON_ objectForKey:KEY_]

// break-if 宏
#ifndef BREAK_IF
#define BREAK_IF(cond) if(cond) break
#endif

#ifdef DEBUG
#define HCLog(format, ...) \
NSLog(@"<%@ : %d : %s>-: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__FUNCTION__, \
[NSString stringWithFormat:format, ##__VA_ARGS__]);
#else
#define HCLog(...)
#endif

// 强、弱指针转换
#ifndef WeakObj
#define WeakObj(obj) autoreleasepool{} __weak typeof(obj) obj##Weak = obj;
#endif

#ifndef StrongObj
#define StrongObj(obj) autoreleasepool{} __strong typeof(obj) obj = obj##Weak;
#endif

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

// 是否是阿拉伯语
#define Arabic                            ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:kHCKeyWindow.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft)

#pragma mark - 常用字体字号
/********************************************常用字体字号********************************************/

#define kHCFontWithCustom(name,s)                       [HCFont fontWithName:name size:s]
#define kHCBoldFontSize(s)                              [HCFont boldSystemFontOfSize:s]
#define kHCSystemFontSize(s)                            [HCFont systemFontOfSize:s]

#define kHCSystemFont9                                  kHCSystemFontSize(9)
#define kHCSystemFont10                                 kHCSystemFontSize(10)
#define kHCSystemFont11                                 kHCSystemFontSize(11)
#define kHCSystemFont12                                 kHCSystemFontSize(12)
#define kHCSystemFont13                                 kHCSystemFontSize(13)
#define kHCSystemFont14                                 kHCSystemFontSize(14)
#define kHCSystemFont15                                 kHCSystemFontSize(15)
#define kHCSystemFont16                                 kHCSystemFontSize(16)
#define kHCSystemFont17                                 kHCSystemFontSize(17)
#define kHCSystemFont18                                 kHCSystemFontSize(18)
#define kHCSystemFont19                                 kHCSystemFontSize(19)
#define kHCSystemFont20                                 kHCSystemFontSize(20)

#define kHCBoldFont10                                   kHCBoldFontSize(10)
#define kHCBoldFont11                                   kHCBoldFontSize(11)
#define kHCBoldFont12                                   kHCBoldFontSize(12)
#define kHCBoldFont13                                   kHCBoldFontSize(13)
#define kHCBoldFont14                                   kHCBoldFontSize(14)
#define kHCBoldFont15                                   kHCBoldFontSize(15)
#define kHCBoldFont16                                   kHCBoldFontSize(16)
#define kHCBoldFont17                                   kHCBoldFontSize(17)
#define kHCBoldFont18                                   kHCBoldFontSize(18)
#define kHCBoldFont19                                   kHCBoldFontSize(19)
#define kHCBoldFont20                                   kHCBoldFontSize(20)

/// >>> SFUIText
#define kHCSFProTextRegularFontSize(s)      [HCFont fontWithName:@".SFUIDisplay-Regular" size:s]
#define kHCSFProTextMediumFontSize(s)       [HCFont fontWithName:@".SFUIDisplay-Medium" size:s]
#define kHCSFProTextBoldFontSize(s)         [HCFont fontWithName:@".SFUIDisplay-Bold" size:s]

#define kHCHelvetica(size_)                 [HCFont fontWithName:@"Helvetica" size:size_]
#define kHCHelveticaNeue(size_)             [HCFont fontWithName:@"Helvetica Neue" size:size_]
#define kHCHelvetica_Bold(size_)            [HCFont fontWithName:@"Helvetica-Bold" size:size_]
#define kHCArialMT(size_)                   [HCFont fontWithName:@"ArialMT" size:size_]
#define kHCArial_BoldMT(size_)              [HCFont fontWithName:@"Arial-BoldMT" size:size_]

//  ************   常用变量   *************
#define kHCCurrentMoneyType [[HCSkinHelper sharedInstance] currentMoneyType]
#define CurTimeStamp [[NSDate date] timeIntervalSince1970]

//  *************  常用方法  *************
#define kHCRequestAgentInstance [HCRequestAgent sharedAgent]

#define HCLocalString(StringKey_) [[NSBundle mainBundle] localizedStringForKey:(StringKey_) value:@"" table:nil]
#define kHCKeyWindow [UIApplication sharedApplication].keyWindow

//  *************  非空变量  *************
#define NotNullString(string_) ([string_ isKindOfClass:[NSString class]] && [string_ length]) ? string_ : @""
#define NotNullDict(dict_) (dict_ && [dict_ isKindOfClass:[NSDictionary class]]) ? dict_ : @{}
#define NotNullArray(array_) (array_ && [array_ isKindOfClass:[NSArray class]]) ? array_ : @[]
#define NotNullDecimalNumber(num_) (num_ && [num_ isKindOfClass:[NSDecimalNumber class]]) ? num_ : NSDecimalNumber.zero
#define NotZero(num_) (num_ ? num_ : .000000001)

//  *************  类型转换  *************
#define StringWithInteger(iNum_) [NSString stringWithFormat:@"%ld",(long)iNum_]

//  *************  条件判断  *************
#define StringIsNotNull(string_) ((BOOL)[NotNullString(string_) length])

//  *************  常用block类型  ************
#define blockNormalNoName void (^)(void)
#define blockNormal(blockName) void (^blockName)(void)
#define blockBoolResultNoName void (^)(BOOL result)
#define blockBoolResult(blockName) void (^blockName)(BOOL result)
#define blockResultAndMsgNoName void (^)(BOOL result,NSString *message)
#define blockResultAndMsg(blockName) void (^blockName)(BOOL result,NSString *message)

#ifndef hc_dispatch_main_async_safe
#define hc_dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif

#endif /* HCDefine_h */





















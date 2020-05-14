//
//  HCFont.h
//  HoldCoin
//
//  Created by Song on 2018/10/23.
//  Copyright © 2018年 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCFont : UIFont

//  -------------  PingFang-Medium  -------------
///  PingFang-Medium 24
@property (class,nonatomic,readonly) HCFont *pingfangM_A_24;
///  PingFang-Medium 20
@property (class,nonatomic,readonly) HCFont *pingfangM_B_20;


///  PingFang-Regular 17
@property (class,nonatomic,readonly) HCFont *pingfangM_C_17;
///  PingFang-Regular 15
@property (class,nonatomic,readonly) HCFont *pingfangM_D_15;
///  PingFang-Regular 13
@property (class,nonatomic,readonly) HCFont *pingfangM_E_13;
///  PingFang-Regular 11
@property (class,nonatomic,readonly) HCFont *pingfangM_F_11;

//  -------------  PingFang-Regular  -------------
///  PingFang-Regular 17
@property (class,nonatomic,readonly) HCFont *pingfangR_C_17;
///  PingFang-Regular 15
@property (class,nonatomic,readonly) HCFont *pingfangR_D_15;
///  PingFang-Regular 13
@property (class,nonatomic,readonly) HCFont *pingfangR_E_13;
///  PingFang-Regular 11
@property (class,nonatomic,readonly) HCFont *pingfangR_F_11;

+ (UIFont *)pingfangRegular:(CGFloat)size;
+ (UIFont *)pingfangMedium:(CGFloat)size;
+ (UIFont *)pingfangThin:(CGFloat)size;
+ (UIFont *)pingfangLight:(CGFloat)size;
+ (UIFont *)pingfangBold:(CGFloat)size;
+ (UIFont *)pingfangUltralight:(CGFloat)size;

+ (UIFont *)DINAlternateBold:(CGFloat)size;

+ (UIFont *)holdIconfont:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END

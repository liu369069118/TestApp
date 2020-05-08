//
//  HCColor.h
//  HoldCoin
//
//  Created by Song on 2019/6/10.
//  Copyright © 2019 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCColor : UIColor

// ------------  基础色  ------------
/// rgba(63, 103, 255, 1)
@property (class,nonatomic,readonly) HCColor *HCBlueColor;
/// rgba(220, 99, 99, 1)
@property (class,nonatomic,readonly) HCColor *HCRedColor;
/// rgba(48, 203, 166, 1)
@property (class,nonatomic,readonly) HCColor *HCGreenColor;
/// rgba(34, 34, 34, 1)
@property (class,nonatomic,readonly) HCColor *HCBlackColor;

// ------------  应用色  ------------
///  rgba(59, 94, 156, 1)
@property (class,nonatomic,readonly) HCColor *appColor1_A100;
///  rgba(26, 36, 79, 1)
@property (class,nonatomic,readonly) HCColor *appColor2_A100;
///  rgba(94, 101, 131, 1)
@property (class,nonatomic,readonly) HCColor *appColor1_A70;
///  rgba(163, 167, 185, 1)
@property (class,nonatomic,readonly) HCColor *appColor2_A40;
///  rgba(246, 246, 246, 1)
@property (class,nonatomic,readonly) HCColor *HCBackColor;
///  rgba(250, 250, 252, 1)
@property (class,nonatomic,readonly) HCColor *HCLightBackColor;

///  rgba(249, 249, 251, 1)
@property (class,nonatomic,readonly) HCColor *HCBackViewColor;
///  rgba(48, 77, 187)
@property (class,nonatomic,readonly) HCColor *HCGrayShadowColor;

// ------------  文章颜色  ------------
///  rgba(0, 0, 0, 1)
@property (class,nonatomic,readonly) HCColor *articleBlack;
///  rgba(25, 25, 25, 1)
@property (class,nonatomic,readonly) HCColor *articleBlack_A90;
///  rgba(90, 90, 90, 1)
@property (class,nonatomic,readonly) HCColor *articleBlack_A70;
///  rgba(178, 178, 178, 1)
@property (class,nonatomic,readonly) HCColor *articleBlack_A30;

// ------------  分析宝Pro颜色  ------------
///  rgba(120, 84, 44, 1)
@property (class,nonatomic,readonly) HCColor *FXBProColor;
///  rgba(174, 152, 128, 1)
@property (class,nonatomic,readonly) HCColor *FXBProAlertColor;
///  rgba(162, 122, 66, 1)
@property (class,nonatomic,readonly) HCColor *FXBProBrownBackColor;
///  rgba(92, 55, 27, 1)
@property (class,nonatomic,readonly) HCColor *FXBProDarkBrownBorderColor;
///  rgba(172, 146, 115, 1)
@property (class,nonatomic,readonly) HCColor *FXBProBrownBorderColor;
///  rgba(85, 58, 33, 1)
@property (class,nonatomic,readonly) HCColor *FXBProDarkBrownBackColor;
///  rgba(251, 239, 221, 1)
@property (class,nonatomic,readonly) HCColor *FXBProMediumBrownTextColor;
///  rgba(136, 91, 40, 1)
@property (class,nonatomic,readonly) HCColor *FXBProBrownShadowColor;


+ (HCColor *)HCBlueColorWithAlpha:(CGFloat)alpha;

+ (HCColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;
+ (HCColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;
+ (HCColor *)grayColor:(CGFloat)gray;

+ (instancetype)colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END

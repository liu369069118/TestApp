//
//  HCColor.m
//  HoldCoin
//
//  Created by Song on 2019/6/10.
//  Copyright © 2019 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import "HCColor.h"
#import "NSString+Additions.h"

@implementation HCColor

// ------------  基础色  ------------
+ (HCColor *)HCBlueColor{
    static HCColor *HCBlueColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCBlueColor = [self colorWithR:63 G:103 B:255 A:1];
    });
    return HCBlueColor;
}

+ (HCColor *)HCRedColor{
    static HCColor *HCRedColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCRedColor = [self colorWithR:220 G:99 B:99 A:1];
    });
    return HCRedColor;
}

+ (HCColor *)HCGreenColor{
    static HCColor *HCGreenColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCGreenColor = [self colorWithR:48 G:203 B:166 A:1];
    });
    return HCGreenColor;
}

+ (HCColor *)HCBlueColorWithAlpha:(CGFloat)alpha{
    return [[self HCBlueColor] colorWithAlphaComponent:alpha];
}

+ (HCColor *)HCBlackColor{
    static HCColor *HCBlackColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCBlackColor = [self colorWithR:34 G:34 B:34 A:1];
    });
    return HCBlackColor;
}

+ (HCColor *)HCBackViewColor{
    static HCColor *HCBackViewColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCBackViewColor = [self colorWithR:249 G:249 B:251 A:1];
    });
    return HCBackViewColor;
}

+ (HCColor *)HCGrayShadowColor{
    static HCColor *HCGrayShadowColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCGrayShadowColor = [self colorWithR:48 G:77 B:187 A:1];
    });
    return HCGrayShadowColor;
}

// ------------  应用色  ------------
+ (HCColor *)appColor1_A100{
    static HCColor *appColor1_A100 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appColor1_A100 = [self colorWithR:59 G:94 B:156 A:1];
    });
    return appColor1_A100;
}

+ (HCColor *)appColor2_A100{
    static HCColor *appColor2_A100 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appColor2_A100 = [self colorWithR:26 G:36 B:79 A:1];
    });
    return appColor2_A100;
}

+ (HCColor *)appColor1_A70{
    static HCColor *HCGreenColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCGreenColor = [self colorWithR:94 G:101 B:131 A:1];
    });
    return HCGreenColor;
}

+ (HCColor *)appColor2_A40{
    static HCColor *HCGreenColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCGreenColor = [self colorWithR:163 G:167 B:185 A:1];
    });
    return HCGreenColor;
}

+ (HCColor *)HCBackColor{
    static HCColor *HCBackColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCBackColor = [self colorWithR:246 G:246 B:246 A:1];
    });
    return HCBackColor;
}

+ (HCColor *)HCLightBackColor{
    static HCColor *HCLightBackColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCLightBackColor = [self colorWithR:250 G:250 B:252 A:1];
    });
    return HCLightBackColor;
}


// ------------  文章颜色  ------------
+ (HCColor *)articleBlack{
    return [HCColor blackColor];
}

+ (HCColor *)articleBlack_A90{
    static HCColor *HCGreenColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HCGreenColor = [self colorWithR:25 G:25 B:25 A:1];
    });
    return HCGreenColor;
}

+ (HCColor *)articleBlack_A70{
    static HCColor *articleBlack_A70 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        articleBlack_A70 = [self colorWithR:90 G:90 B:90 A:1];
    });
    return articleBlack_A70;
}

+ (HCColor *)articleBlack_A30{
    static HCColor *articleBlack_A30 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        articleBlack_A30 = [self colorWithR:178 G:178 B:178 A:1];
    });
    return articleBlack_A30;
}

// ------------  分析宝Pro颜色  ------------
+ (HCColor *)FXBProColor{
    static HCColor *articleBlack_A30 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        articleBlack_A30 = [self colorWithR:120 G:84 B:44 A:1];
    });
    return articleBlack_A30;
}

+ (HCColor *)FXBProAlertColor{
    static HCColor *FXBProAlertColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProAlertColor = [self colorWithR:174 G:152 B:128 A:1];
    });
    return FXBProAlertColor;
}

+ (HCColor *)FXBProBrownBackColor{
    static HCColor *FXBProBrownBackColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProBrownBackColor = [self colorWithR:162 G:122 B:66 A:1];
    });
    return FXBProBrownBackColor;
}

+ (HCColor *)FXBProDarkBrownBorderColor{
    static HCColor *FXBProDarkBrownBorderColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProDarkBrownBorderColor = [self colorWithR:92 G:55 B:27 A:1];
    });
    return FXBProDarkBrownBorderColor;
}

+ (HCColor *)FXBProBrownBorderColor{
    static HCColor *FXBProBrownBorderColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProBrownBorderColor = [self colorWithR:172 G:146 B:115 A:1];
    });
    return FXBProBrownBorderColor;
}

+ (HCColor *)FXBProDarkBrownBackColor{
    static HCColor *FXBProDarkBrownBackColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProDarkBrownBackColor = [self colorWithR:85 G:58 B:33 A:1];
    });
    return FXBProDarkBrownBackColor;
}

+ (HCColor *)FXBProMediumBrownTextColor{
    static HCColor *FXBProMediumBrownTextColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProMediumBrownTextColor = [self colorWithR:251 G:239 B:221 A:1];
    });
    return FXBProMediumBrownTextColor;
}

+ (HCColor *)FXBProBrownShadowColor{
    static HCColor *FXBProBrownShadowColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FXBProBrownShadowColor = [self colorWithR:136 G:91 B:40 A:1];
    });
    return FXBProBrownShadowColor;
}

+ (HCColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B {
    return [HCColor colorWithR:R G:G B:B A:1];
}

+ (HCColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A{
    return [self colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A];
}

+ (HCColor *)grayColor:(CGFloat)gray{
    return [self colorWithR:gray G:gray B:gray A:1];
}

+ (instancetype)colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}


static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str stringByTrim] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

@end

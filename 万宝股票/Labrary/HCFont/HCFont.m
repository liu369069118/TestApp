
#import "HCFont.h"

@implementation HCFont

//  -------------  PingFang-Medium  -------------
+ (HCFont *)pingfangM_A_24{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangMedium:24];
    });
    return font;
}

+ (HCFont *)pingfangM_B_20{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangMedium:20];
    });
    return font;
}

+ (HCFont *)pingfangM_C_17{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangMedium:17];
    });
    return font;
}

+ (HCFont *)pingfangM_D_15{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangMedium:15];
    });
    return font;
}

+ (HCFont *)pingfangM_E_13{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangMedium:13];
    });
    return font;
}

+ (HCFont *)pingfangM_F_11{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangMedium:11];
    });
    return font;
}

//  -------------  PingFang-Regular  -------------
+ (HCFont *)pingfangR_C_17{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangRegular:17];
    });
    return font;
}

+ (HCFont *)pingfangR_D_15{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangRegular:15];
    });
    return font;
}

+ (HCFont *)pingfangR_E_13{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangRegular:13];
    });
    return font;
}

+ (HCFont *)pingfangR_F_11{
    static HCFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [self pingfangRegular:11];
    });
    return font;
}

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    UIFont *font = [super fontWithName:fontName size:fontSize];
    if (!font) {
        font = [super systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)pingfangRegular:(CGFloat)size{
    return [self fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)pingfangMedium:(CGFloat)size{
    return [self fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)pingfangThin:(CGFloat)size{
    return [self fontWithName:@"PingFangSC-Thin" size:size];
}

+ (UIFont *)pingfangLight:(CGFloat)size{
    return [self fontWithName:@"PingFangSC-Light" size:size];
}

+ (UIFont *)pingfangBold:(CGFloat)size{
    return [self fontWithName:@"PingFangSC-Semibold" size:size];
}

+ (UIFont *)pingfangUltralight:(CGFloat)size{
    return [self fontWithName:@"PingFangSC-Ultralight" size:size];
}

+ (UIFont *)DINAlternateBold:(CGFloat)size{
    //  设计师自己的字体还有问题，还是得用苹方
//    return [self pingfangRegular:size];
    //  这个字体是付费的，所以我们用设计师自己伪造的字体(NIUBIZITIJIACU)
    return [self fontWithName:@"yibianguoziti" size:size];
//    return [self fontWithName:@"hold-medium" size:size];
    //  NIUBIZITIJIACU_new
//    return [self fontWithName:@"hold bold" size:size];
//    return [self fontWithName:@"hold regular" size:size];

//    return [self fontWithName:@"DINAlternate-Bold" size:size];
}

+ (UIFont *)holdIconfont:(CGFloat)size {
    return [self fontWithName:@"hold-icon" size:size];
}



@end


#import "HCAlertAction.h"

@implementation HCAlertAction

- (void)setHc_textColor:(UIColor *)hc_textColor{
    _hc_textColor = hc_textColor;
    SEL sel = NSSelectorFromString(@"_titleTextColor");
    if ([self respondsToSelector:sel]) {
        [self setValue:_hc_textColor forKey:@"titleTextColor"];
    }
}

@end

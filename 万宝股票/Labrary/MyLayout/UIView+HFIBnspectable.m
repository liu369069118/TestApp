//
//  UIView+HFIBnspectable.m
//  AllFinancial
//
//  Created by hc on 2019/3/26.
//  Copyright © 2019 宫树敏. All rights reserved.
//

#import "UIView+HFIBnspectable.h"

@implementation UIView (HFIBnspectable)
- (void)setCornerRadius:(NSInteger)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}
- (NSInteger)cornerRadius {
    return self.layer.cornerRadius;
}
- (void)setBorderWidth:(NSInteger)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (NSInteger)borderWidth {
    return self.layer.borderWidth;
}

- (CGColorRef)borderColor {
    return self.layer.borderColor;
}
- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}

- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}



@end

//
//  UIImage+tool.h
//  万宝股票
//
//  Created by 刘涛 on 2020/5/14.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (tool)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END

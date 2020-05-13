//
//  WBHyperLinkLabel.h
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "TYAttributedLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBHyperLinkLabel : TYAttributedLabel

/// >>> 连接点击
@property (nonatomic, copy) void(^hyperLinkTextClickBlock)(NSString *linkString);
/// >>> 连接长按
@property (nonatomic, copy) void(^hyperLinkTextLongPressedBlock)(NSString *linkString);
/// >>> 点击跳转回调，不会影响内部跳转逻辑，打点用
@property (nonatomic, copy) void(^actionClickBlock)(NSString *linkString);

@property (nonatomic, strong) UIFont *linkFont;

- (void)setHyperLinkLabelText:(NSString *)textString;
- (void)setHyperLinkLabelText:(NSString *)textString textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END

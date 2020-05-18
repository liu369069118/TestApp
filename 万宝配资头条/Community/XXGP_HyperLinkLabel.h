
#import "TYAttributedLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_HyperLinkLabel : TYAttributedLabel

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

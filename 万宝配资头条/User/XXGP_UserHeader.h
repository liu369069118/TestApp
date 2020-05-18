
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_UserHeader : UIView

@property (nonatomic, copy) void(^kClickEventBlock)(void);

- (void)updateUI;

@end

NS_ASSUME_NONNULL_END

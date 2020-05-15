
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_CommunityButton : UIView

@property (nonatomic, assign) CGFloat tapInsetWidth;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UIImage *image;


@end

NS_ASSUME_NONNULL_END

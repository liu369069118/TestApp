
#import <UIKit/UIKit.h>
#import "XXGP_UserModel.h"

typedef enum : NSUInteger {
    /// >>> 16*16
    HCAvatarSizeLarge,
    /// >>> 14*14
    HCAvatarSizeMedium,
    /// >>> 8*8
    HCAvatarSizeSmall,
} HCAvatarSize;

@interface HCAvatarView : UIControl

@property (strong,nonatomic) UIImageView *avatarImageView;
@property (nonatomic,assign) BOOL noBorder;
@property (nonatomic,assign) CGFloat avatarCornerRadius;

- (void)setAvatarImage:(UIImage *)image userType:(HCVipType)userType size:(HCAvatarSize)size;
- (void)setAvatarURL:(NSString *)url userType:(HCVipType)userType size:(HCAvatarSize)size;
- (void)setAvatarWithUserModel:(XXGP_UserModel *)userModel  size:(HCAvatarSize)size;

+ (UIImage *)vipLogoWithVipType:(HCVipType)type;

@property (strong,nonatomic,readonly) XXGP_UserModel *currentUser;

@end

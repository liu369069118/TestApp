//
//  HCAvatarView.h
//  HoldCoin
//
//  Created by Song on 2019/3/13.
//  Copyright © 2019 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBUserModel.h"

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
- (void)setAvatarWithUserModel:(WBUserModel *)userModel  size:(HCAvatarSize)size;

+ (UIImage *)vipLogoWithVipType:(HCVipType)type;

@property (strong,nonatomic,readonly) WBUserModel *currentUser;

@end


#import <UIKit/UIKit.h>
#import "XXGP_newCommunityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_NewCommunityCell : UITableViewCell

@property (nonatomic, strong) XXGP_newCommunityModel *model;

@property (nonatomic, copy) void (^avatarActionBlock)(XXGP_newCommunityModel *model);
@property (nonatomic, copy) void (^commentActionBlock)(XXGP_newCommunityModel *model);

+ (CGFloat)communityCellHeight:(XXGP_newCommunityModel *)model;

@end

NS_ASSUME_NONNULL_END

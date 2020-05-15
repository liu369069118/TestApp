

#import <UIKit/UIKit.h>
#import "XXGP_CommunityFunctionView.h"
#import "XXGP_CommunityLayout.h"
#import "XXGP_HyperLinkLabel.h"
#import "HCAvatarView.h"

NS_ASSUME_NONNULL_BEGIN

@class XXGP_CommunityCell;

@protocol XXGP_CommunityCellDelegate <NSObject>

- (void)cummunityCellAction:(XXGP_CommunityCell *)mainCell;
- (void)likeClickForCummunityCell:(XXGP_CommunityCell *)mainCell;
- (void)commentClickForCummunityCell:(XXGP_CommunityCell *)mainCell;

@end

@interface XXGP_CommunityCellHeaderView : UIView

@property (nonatomic, weak) HCAvatarView *avatarView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *subNameLabel;

@property (nonatomic, strong) XXGP_CommunityLayout *layout;

@end

@interface XXGP_CommunityCellTopicView : UIView

@property (nonatomic, weak) UIImageView *topicImageView;
@property (nonatomic, weak) UIButton *topicButton;
@property (nonatomic, assign) BOOL isFromHome;

@property (nonatomic, strong) XXGP_CommunityLayout *layout;

@end

@interface XXGP_CommunityCellTitleView : UIView

@property (nonatomic, weak) UILabel *titleLabel;

@end

@interface XXGP_CommunityCellDescribeView : UIView

@property (nonatomic, weak) XXGP_HyperLinkLabel *describeLabel;
@property (nonatomic, weak) UIButton *retractButton;

@end

@interface XXGP_CommunityCellPictureView : UIView

@property (nonatomic, weak) UIView *pictureView;

@end

@interface XXGP_CommunityCellFunctionView : UIView <HCCommunityCellFunctionViewDelegate>

@property (nonatomic, weak) XXGP_CommunityFunctionView *functionView;

@property (nonatomic, weak) XXGP_CommunityCell *mainCell;

@end


@interface XXGP_CommunityCell : UITableViewCell

@property (nonatomic, weak) id<XXGP_CommunityCellDelegate> delegate;

@property (nonatomic, weak) UIView *communityContentView;
@property (nonatomic, weak) XXGP_CommunityCellHeaderView *headerView;
@property (nonatomic, weak) XXGP_CommunityCellTopicView *topicView;
@property (nonatomic, weak) XXGP_CommunityCellTitleView *titleView;
@property (nonatomic, weak) XXGP_CommunityCellDescribeView *describeView;
@property (nonatomic, weak) XXGP_CommunityCellPictureView *pictureView;
@property (nonatomic, weak) XXGP_CommunityCellFunctionView *functionView;

@property (nonatomic, strong) XXGP_CommunityLayout *layout;

@end

NS_ASSUME_NONNULL_END

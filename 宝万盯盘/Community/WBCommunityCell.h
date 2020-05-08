//
//  WBCommunityCell.h
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommunityFunctionView.h"
#import "WBCommunityLayout.h"
#import "WBHyperLinkLabel.h"
#import "HCAvatarView.h"

NS_ASSUME_NONNULL_BEGIN

@class WBCommunityCell;

@protocol WBCommunityCellDelegate <NSObject>

- (void)cummunityCellAction:(WBCommunityCell *)mainCell;
- (void)likeClickForCummunityCell:(WBCommunityCell *)mainCell;
- (void)commentClickForCummunityCell:(WBCommunityCell *)mainCell;

@end

@interface WBCommunityCellHeaderView : UIView

@property (nonatomic, weak) HCAvatarView *avatarView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *subNameLabel;

@property (nonatomic, strong) WBCommunityLayout *layout;

@end

@interface WBCommunityCellTopicView : UIView

@property (nonatomic, weak) UIImageView *topicImageView;
@property (nonatomic, weak) UIButton *topicButton;
@property (nonatomic, assign) BOOL isFromHome;

@property (nonatomic, strong) WBCommunityLayout *layout;

@end

@interface WBCommunityCellTitleView : UIView

@property (nonatomic, weak) UILabel *titleLabel;

@end

@interface WBCommunityCellDescribeView : UIView

@property (nonatomic, weak) WBHyperLinkLabel *describeLabel;
@property (nonatomic, weak) UIButton *retractButton;

@end

@interface WBCommunityCellPictureView : UIView

@property (nonatomic, weak) UIView *pictureView;

@end

@interface WBCommunityCellFunctionView : UIView <HCCommunityCellFunctionViewDelegate>

@property (nonatomic, weak) WBCommunityFunctionView *functionView;

@property (nonatomic, weak) WBCommunityCell *mainCell;

@end


@interface WBCommunityCell : UITableViewCell

@property (nonatomic, weak) id<WBCommunityCellDelegate> delegate;

@property (nonatomic, weak) UIView *communityContentView;
@property (nonatomic, weak) WBCommunityCellHeaderView *headerView;
@property (nonatomic, weak) WBCommunityCellTopicView *topicView;
@property (nonatomic, weak) WBCommunityCellTitleView *titleView;
@property (nonatomic, weak) WBCommunityCellDescribeView *describeView;
@property (nonatomic, weak) WBCommunityCellPictureView *pictureView;
@property (nonatomic, weak) WBCommunityCellFunctionView *functionView;

@property (nonatomic, strong) WBCommunityLayout *layout;

@end

NS_ASSUME_NONNULL_END

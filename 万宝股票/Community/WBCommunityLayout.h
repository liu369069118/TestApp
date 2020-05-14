//
//  WBCommunityLayout.h
//  万宝股票
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBCommunityModel.h"

NS_ASSUME_NONNULL_BEGIN

#define kWBCommunityTitleFont [UIFont boldSystemFontOfSize:17]
#define kWBCommunityContentFont [UIFont systemFontOfSize:17]

static CGFloat const kWBCommunityCellTopMargin      = 12.f;
static CGFloat const kWBCommunityCellLeftMargin     = 20.f;
static CGFloat const kWBCommunityCellBottomMargin   = 0.f;
static CGFloat const kWBCommunityCellRightMargin    = 20.f;

static CGFloat const kWBCommunityCellNormalMargin   = 8.f;
static CGFloat const kWBCommunityCellSmallMargin    = 4.f;

@interface WBCommunityLayout : NSObject

@property (nonatomic, strong) WBCommunityModel *topicModel;

@property (nonatomic, assign) CGFloat communityCellHeight;  // cell

@property (nonatomic, assign) CGFloat communityContentView_x;  // contentView
@property (nonatomic, assign) CGFloat communityContentView_y;  // contentView
@property (nonatomic, assign) CGFloat communityContentView_w;  // contentView
@property (nonatomic, assign) CGFloat communityContentView_h;  // contentView

@property (nonatomic, assign) CGFloat headerView_y;  // 头像视图
@property (nonatomic, assign) CGFloat headerView_h;  // 头像视图
@property (nonatomic, assign) CGFloat headerView_w;  // 头像视图

@property (nonatomic, assign) CGFloat topicView_y;  // 话题视图
@property (nonatomic, assign) CGFloat topicView_h;  // 话题视图
@property (nonatomic, assign) CGFloat topicView_w;  // 话题视图

@property (nonatomic, assign) CGFloat titleView_y;  // 标题视图
@property (nonatomic, assign) CGFloat titleView_h;  // 标题视图
@property (nonatomic, assign) CGFloat titleView_w;  // 标题视图

@property (nonatomic, assign) CGFloat contentView_y;  // 内容视图
@property (nonatomic, assign) CGFloat contentView_h;  // 内容视图
@property (nonatomic, assign) CGFloat contentView_w;  // 内容视图

@property (nonatomic, assign) CGFloat contentLabel_w;  // 内容
@property (nonatomic, assign) CGFloat contentLabel_h;  // 内容

@property (nonatomic, assign) CGFloat retractButton_y;  // 全文
@property (nonatomic, assign) CGFloat retractButton_w;  // 全文
@property (nonatomic, assign) CGFloat retractButton_h;  // 全文
@property (nonatomic, assign) BOOL showRetractButton;   // 是否显示全文

@property (nonatomic, assign) NSInteger contentNumberOfLine;

@property (nonatomic, assign) CGFloat pictureView_y;  // 图片视图
@property (nonatomic, assign) CGFloat pictureView_w;  // 图片视图
@property (nonatomic, assign) CGFloat pictureView_h;  // 图片视图
@property (nonatomic, assign) CGFloat communityPictureSize; // 图片大小

@property (nonatomic, assign) CGFloat functionView_y;  // 功能视图
@property (nonatomic, assign) CGFloat functionView_h;  // 功能视图
@property (nonatomic, assign) CGFloat functionView_w;  // 功能视图

- (instancetype)initWithTopicModel:(WBCommunityModel *)topicModel;
- (instancetype)initWithTopicModel:(WBCommunityModel *)topicModel isFromTopicDetail:(BOOL)isFromTopicDetail;

@end

NS_ASSUME_NONNULL_END

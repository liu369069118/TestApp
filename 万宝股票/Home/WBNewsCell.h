//
//  WBNewsCell.h
//  万宝股票
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBNewsLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class WBNewsCell;
@protocol WBNewsCellDelegate;

@interface WBTagHeaderView : UIView

@property (nonatomic, strong) WBNewsLayout *layout;
@property (nonatomic, copy) void (^tagOnclickBlock)(NSString *url, NSString *tagName, WBNewsModel *newsModel);

@end

@interface WBCoinRelationView : UIView

@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UIButton *thirdButton;

@property (nonatomic, strong) WBNewsLayout *layout;

- (void)reloadAllCoinButton:(NSArray *)dataArray;

@end

@interface WBTitleView : UIView

@property (nonatomic, weak) UILabel *titleLabel;    // 标题
@property (nonatomic, weak) UIImageView *titleImageView;    // 标题右侧图片
@property (strong,nonatomic) CALayer *titleImageMaskLayer;
@property (nonatomic, strong) UIImage *placeholderImage;    // 占位图

@end

@interface WBArticlePictureView : UIView

@property (nonatomic, strong) UIImage *placeholderImage;    // 占位图

@end

@interface WBUserInfoView : UIView

@property (nonatomic, weak) UIImageView *headerImageView;   // 头像
@property (nonatomic, weak) UILabel *nameLabel; // 名称

@end

@interface WBDescribeView : UIView

@property (nonatomic, weak) UILabel *describeLabel; // 描述

@end

@interface WBContentPictureView : UIView

@property (nonatomic, strong) UIImage *placeholderImage;    // 占位图

@end

@interface WBBottomBarView : UIView

@property (nonatomic, weak) UIButton *coinButton;   // 币种 button
@property (nonatomic, weak) UILabel *infoLabel; // 推荐|时间|平台 label

@end

@interface WBNewsView : UIView

@property (nonatomic, strong) UIView *contentView;              // 容器

@property (nonatomic, weak) UIImageView *hotImageV; // 热榜图片

@property (nonatomic, weak) WBTagHeaderView *coinHeaderView;   // 文章tag信息
//@property (nonatomic, weak) WBCoinRelationView *coinRelationView;       // 关联币种视图
@property (nonatomic, weak) WBTitleView *titleView;                     // 标题视图
@property (nonatomic, weak) WBArticlePictureView *articlePictureView;   // 文章图片
@property (nonatomic, weak) WBUserInfoView *userInfoView;               // 用户信息
@property (nonatomic, weak) WBDescribeView *describeView;               // 描述文字
@property (nonatomic, weak) WBContentPictureView *contentPictureView;   // 内容图片
@property (nonatomic, weak) WBBottomBarView *bottomBarView;             // 底部信息栏

///  广告关闭按钮
@property (strong,nonatomic) UIButton *adCloseButton;

@property (nonatomic, weak) UIView *bottomLineView; // 底部线条

@property (nonatomic, assign) BOOL isShowBottomLine;  // 是否显示底部线条

@property (nonatomic, strong) WBNewsLayout *layout;

@end

@interface WBNewsCell : UITableViewCell

@property (nonatomic, weak) WBNewsView *newsView;
@property (nonatomic, weak) id<WBNewsCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong, setter = setLayout:) WBNewsLayout *layout;
@property (nonatomic, copy) void(^ADCloseClicked)(WBNewsLayout *newsLayout);

- (void)setLayout:(WBNewsLayout *)layout;

@end

@protocol WBNewsCellDelegate <NSObject>

@required
- (void)newsCellDidSelect:(WBNewsCell *)newsCell;

@end

NS_ASSUME_NONNULL_END

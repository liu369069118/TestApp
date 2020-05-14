//
//  WBNewsLayout.h
//  万宝股票
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

// 公共
static CGFloat const kHCNewsCellEdgeInset = 20;    // cell 外部左右边距
static CGFloat const kHCNewsCellBottomEdgeInset = 0;    // cell 外部左右边距

static CGFloat const kHCNewsSmallMargin = 8.f;
static CGFloat const kHCNewsMargin = 16.f;
static CGFloat const kHCNewsImageMargin = 4.f;  // 图片之间 间距
static CGFloat const kHCNewsHeaderToDescribeMargin = 6.f;  // 头像到描述边距

static CGFloat const kHCNewsTopMargin = 12.f;   // 顶部 留边
static CGFloat const kHCNewsBottomMargin = 12.f;    // 底部 留边

static CGFloat const kHCNewsHotImageWidth = 28.f;    //
/// >>> 标题 视图
static CGFloat const kHCTitleImageViewWidth = 113.f;    // 标题图片宽度
static CGFloat const kHCTitleImageViewHeight = 74.f;    // 标题图片高度
static CGFloat const kHCTitleToImageMargin = 8.f;  // 标题 距 图片
static CGFloat const kHCNewsTitleNumberOfLine = 3; // 标题行数

#define kHCTitleLabelFont [HCFont pingfangRegular:18] // 标题文字
#define kHCTitleLabelTextColor [HCColor articleBlack]  // 标题文字颜色

/// >>> 用户信息 视图
static CGFloat const kHCNewsUserHeaderWidthAndHeight = 44.f;    // 用户头像 宽高
#define kHCNickNameLabelFont [HCFont pingfangMedium:16] // 昵称文字
#define kHCNickNameLabelTextColor [HCColor grayColor:34]  // 昵称文字颜色

/// >>> 描述 视图
static CGFloat const kHCNewsDescribeNumberOfLine = 3; // 正文行数
#define kHCDescribeLabelFont [HCFont pingfangR_C_17] // 标题文字
#define kHCDescribeLabelTextColor [HCColor grayColor:51]  // 标题文字颜色

/// >>> 正文 图片
static CGFloat const kHCNewsContentPictureImageWidthAndHeight = 113.f;  // 正文 图片 宽高
static CGFloat const kHCSingleContentPictureImageWidth = 343.f;  // 微博 图片 宽度
static CGFloat const kHCSingleContentPictureImageHeight = 192.f;  // 微博 图片 高度

/// >>> 底部栏
static CGFloat const kHCNewsBottomBarHeight = 24.f; // 底部栏 高度
static CGFloat const kHCNewsBottomTagButtonHeight = 14.f; // tag 按钮高度

static CGFloat const kHCNewsCoinInfoTopMarginToTitle = 8.f; // 币种到title margin
static CGFloat const kHCNewsCoinInfoTopMarginToPic = 8.f; // 币种到pic group margin

#define kHCCoinInfoLabelFont [HCFont pingfangRegular:13] // 币信息 字体
#define kHCCoinInfoLabelTextColor [HCColor articleBlack_A30]  // 币信息 字体颜色

@interface WBNewsLayout : NSObject

@property (nonatomic, strong) WBNewsModel *news;

@property (nonatomic, assign) CGFloat articleImageViewWidth;    // 文章相关图片宽度
@property (nonatomic, assign) CGFloat articleImageViewHeight;    // 文章相关图片高度

@property (nonatomic, assign) CGFloat coinHeaderY;  // tag 标签位置
@property (nonatomic, assign) CGFloat coinHeaderHeight; // tag 标签高度

@property (nonatomic, assign) CGFloat coinHeaderImageHeight; // 币种图标
@property (nonatomic, assign) CGFloat coinHeaderFollowHeight; // 币种关注
@property (nonatomic, assign) CGFloat coinHeaderNameHeight; // 币种名称
@property (nonatomic, assign) CGFloat coinHeaderDescHeight; // 币种名称

@property (nonatomic, assign) CGFloat coinRelationY;    // 币种关联 Y
@property (nonatomic, assign) CGFloat coinRelationHeight;    // 币种关联 高度
@property (nonatomic, assign) CGFloat coinRelationButtonWidth;  // 币种button 宽度
@property (nonatomic, assign) CGFloat coinRelationButtonHeight; // 币种button 高度
@property (nonatomic, assign) CGFloat firstCoinX;   // 第一个 x

@property (nonatomic, assign) CGFloat titleViewY;  // 标题视图 Y
@property (nonatomic, assign) CGFloat titleLabelX;  // 标题视图 X
@property (nonatomic, assign) CGFloat titleLabelWidth;  // 标题宽度
@property (nonatomic, assign) CGFloat titleLabelHeight; // 标题高度
@property (nonatomic, assign) CGFloat titleImageViewX;  // 标题图片 X
@property (nonatomic, assign) CGFloat titleViewHeight;  // 标题视图 高度

@property (nonatomic, assign) CGFloat articlePictureViewY;  // 文章图片视图 Y
@property (nonatomic, assign) CGFloat articlePictureViewHeight; // 文章图片视图高度

@property (nonatomic, assign) CGFloat userInfoViewY;    // 用户视图 Y
@property (nonatomic, assign) CGFloat userInfoHeaderX;  // 用户头像 X
@property (nonatomic, assign) CGFloat userInfoHeaderWidthAndHeight;  // 用户头像宽、高度
@property (nonatomic, assign) CGFloat userInfoNameLabelX;   // 用户名称 X
@property (nonatomic, assign) CGFloat userInfoNameLabelWidth;   // 用户名称 宽度
@property (nonatomic, assign) CGFloat userInfoViewHeight;   // 用户信息视图高度

@property (nonatomic, assign) CGFloat describeViewY;   // 描述视图 Y
@property (nonatomic, assign) CGFloat describeLabelX;  // 描述文字 X
@property (nonatomic, assign) CGFloat describeLabelWidth;  // 描述文字 宽度
@property (nonatomic, assign) CGFloat describeLabelHeight;  // 描述文字 高度
@property (nonatomic, assign) CGFloat describeViewHeight;   // 描述视图 高度

@property (nonatomic, assign) CGFloat contentPictureViewY;  // 微博图片视图 Y
@property (nonatomic, assign) CGFloat singleContentPictureImageWidth;   // 单张 微博 图片 宽度
@property (nonatomic, assign) CGFloat singleContentPictureImageHeight;   // 单张 微博 图片 高度
@property (nonatomic, assign) CGFloat contentPictureImageWidthAndHeight;  // 微博 图片 宽高
@property (nonatomic, assign) CGFloat contentPictureViewHeight;  // 微博 图片视图 高度

@property (nonatomic, assign) CGFloat bottomBarViewY;   // 底部栏 Y
@property (nonatomic, assign) CGFloat coinButtonX;  // 币按钮 X
@property (nonatomic, assign) CGFloat coinButtonWidth;  // 币按钮 宽度
@property (nonatomic, assign) CGFloat bottomInfoLabelX; // 币信息 X
@property (nonatomic, assign) CGFloat bottomInfoLabelWidth; // 币信息 宽度
@property (nonatomic, assign) CGFloat bottomBarViewHeight;  // 底部栏 高度

// 总宽度
@property (nonatomic, assign) CGFloat contentViewWidth;
// 总高度
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic,assign) BOOL isADCard;

/// >>> 是否是阅读历史页面
@property (nonatomic,assign) BOOL isHistory;
/// >>> 是否是阅读历史页面
@property (nonatomic,assign) BOOL isTopicFeed;

@property (nonatomic, assign) NSInteger newsType; // 文章类型(推荐（0）、热门（1）、关注（2）)

- (instancetype)initWithNews:(WBNewsModel *)news;
- (instancetype)initWithNews:(WBNewsModel *)news isHistory:(BOOL)isHistory;

- (instancetype)initWithTopicDetailNews:(WBNewsModel *)news;
- (void)layout;


@end

NS_ASSUME_NONNULL_END

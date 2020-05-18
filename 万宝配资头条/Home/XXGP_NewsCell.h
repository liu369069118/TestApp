
#import <UIKit/UIKit.h>
#import "XXGP_NewsLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class XXGP_NewsCell;
@protocol XXGP_NewsCellDelegate;

@interface XXGP_TagHeaderView : UIView

@property (nonatomic, strong) XXGP_NewsLayout *layout;
@property (nonatomic, copy) void (^tagOnclickBlock)(NSString *url, NSString *tagName, XXGP_NewsModel *newsModel);

@end

@interface XXGP_CoinRelationView : UIView

@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UIButton *thirdButton;

@property (nonatomic, strong) XXGP_NewsLayout *layout;

- (void)reloadAllCoinButton:(NSArray *)dataArray;

@end

@interface XXGP_TitleView : UIView

@property (nonatomic, weak) UILabel *titleLabel;    // 标题
@property (nonatomic, weak) UIImageView *titleImageView;    // 标题右侧图片
@property (strong,nonatomic) CALayer *titleImageMaskLayer;
@property (nonatomic, strong) UIImage *placeholderImage;    // 占位图

@end

@interface XXGP_ArticlePictureView : UIView

@property (nonatomic, strong) UIImage *placeholderImage;    // 占位图

@end

@interface XXGP_UserInfoView : UIView

@property (nonatomic, weak) UIImageView *headerImageView;   // 头像
@property (nonatomic, weak) UILabel *nameLabel; // 名称

@end

@interface XXGP_DescribeView : UIView

@property (nonatomic, weak) UILabel *describeLabel; // 描述

@end

@interface XXGP_ContentPictureView : UIView

@property (nonatomic, strong) UIImage *placeholderImage;    // 占位图

@end

@interface XXGP_BottomBarView : UIView

@property (nonatomic, weak) UIButton *coinButton;   // 币种 button
@property (nonatomic, weak) UILabel *infoLabel; // 推荐|时间|平台 label

@end

@interface XXGP_NewsView : UIView

@property (nonatomic, strong) UIView *contentView;              // 容器

@property (nonatomic, weak) UIImageView *hotImageV; // 热榜图片

@property (nonatomic, weak) XXGP_TagHeaderView *coinHeaderView;   // 文章tag信息
//@property (nonatomic, weak) XXGP_CoinRelationView *coinRelationView;       // 关联币种视图
@property (nonatomic, weak) XXGP_TitleView *titleView;                     // 标题视图
@property (nonatomic, weak) XXGP_ArticlePictureView *articlePictureView;   // 文章图片
@property (nonatomic, weak) XXGP_UserInfoView *userInfoView;               // 用户信息
@property (nonatomic, weak) XXGP_DescribeView *describeView;               // 描述文字
@property (nonatomic, weak) XXGP_ContentPictureView *contentPictureView;   // 内容图片
@property (nonatomic, weak) XXGP_BottomBarView *bottomBarView;             // 底部信息栏

///  广告关闭按钮
@property (strong,nonatomic) UIButton *adCloseButton;

@property (nonatomic, weak) UIView *bottomLineView; // 底部线条

@property (nonatomic, assign) BOOL isShowBottomLine;  // 是否显示底部线条

@property (nonatomic, strong) XXGP_NewsLayout *layout;

@end

@interface XXGP_NewsCell : UITableViewCell

@property (nonatomic, weak) XXGP_NewsView *newsView;
@property (nonatomic, weak) id<XXGP_NewsCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong, setter = setLayout:) XXGP_NewsLayout *layout;
@property (nonatomic, copy) void(^ADCloseClicked)(XXGP_NewsLayout *newsLayout);

- (void)setLayout:(XXGP_NewsLayout *)layout;

@end

@protocol XXGP_NewsCellDelegate <NSObject>

@required
- (void)newsCellDidSelect:(XXGP_NewsCell *)newsCell;

@end

NS_ASSUME_NONNULL_END

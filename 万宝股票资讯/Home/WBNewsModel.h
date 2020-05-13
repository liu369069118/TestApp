//
//  WBNewsModel.h
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HCNewsCellStyle) {
    HCNewsCellStyleNone             = 4,  // 无图
    HCNewsCellStyleSingle           = 5,  // 单张图
    HCNewsCellStyleMore             = 6,  // 多图
    HCNewsCellStyleWeibo            = 7,  // 微博
};

typedef NS_ENUM(NSInteger, HCCurrencyTrendType) {
    /// >>> 持平
    HCCurrencyTrendTypeSame = 0,
    /// >>> 上涨
    HCCurrencyTrendTypeAscend,
    /// >>> 下降
    HCCurrencyTrendTypeDescend,
};

typedef NS_ENUM(NSUInteger, HCNewsLabelStyle) {
    HCNewsLabelStylePortfolio = 0,  // 持仓
    HCNewsLabelStyleWatchlist ,     // 自选
    HCNewsLabelStyleTop ,           // 置顶
    HCNewsLabelStyleChoice ,        // 精选
    HCNewsLabelStyleHot ,           // 热门
    HCNewsLabelStyleFeedAD ,
};

typedef NS_ENUM(NSUInteger, HCNewsArticleStyle) {
    HCNewsArticleStyleNone              = 1,    // 错误
    HCNewsArticleStyleArticle           = 1,    // 文章
    HCNewsArticleStyleNewsFlash         = 2,    // 快讯
    HCNewsArticleStyleTopic             = 8,    // 普通话题
    HCNewsArticleStyleCoinArticle       = 9,    // 币种带文章
    HCNewsArticleStyleCoinTopic         = 10,   // 分析宝评论
    HCNewsArticleStyleHotArticle        = 11,   // 热榜文章
    HCNewsArticleStyleCommunityPost     = 12,   // 社区帖子
    
    HCNewsArticleStyleWeibo = 99,        // 微博
    HCNewsArticleStyleFeedAD = 999,    //  首页feed流 card广告
};


@interface HCNewsArticleAuthorItem : NSObject

@property (nonatomic, copy) NSString *authorName;   // 作者名称
@property (nonatomic, copy) NSString *authorHeader; // 作者头像
@property (nonatomic, copy) NSString *authorProfile;    // 作者个人首页

+ (instancetype)newArticleAuthorItemWithDict:(NSDictionary *)dict;

@end

@interface HCNewsArticleUserItem : NSObject

@property (nonatomic, copy) NSString *identity;   // 作者名称
@property (nonatomic, copy) NSString *is_follow; // 作者头像
@property (nonatomic, copy) NSString *nickname;    // 作者个人首页
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *user_avatar;
@property (nonatomic, assign) NSInteger user_id;

+ (instancetype)newArticleUserItemWithDict:(NSDictionary *)dict;

@end


@interface HCNewsArticleCoinItem : NSObject

@property (nonatomic, copy) NSString *coin_icon;    // 图标
@property (nonatomic, copy) NSString *coin_id;      // id
@property (nonatomic, copy) NSString *coin_name;    // 币种 名称
@property (nonatomic, copy) NSString *h5_url;       // h5 地址
@property (nonatomic, copy) NSString *pair_id;      //
@property (nonatomic, copy) NSString *rf;           // 涨跌率
@property (nonatomic, copy) NSString *rf_rate;      // 涨跌幅
@property (nonatomic, copy) NSString *slug;         // 英文名

@property (nonatomic, assign) HCCurrencyTrendType trendType;

+ (instancetype)newArticleCoinItemWithDict:(NSDictionary *)dict;
+ (NSArray *)newsArticleCoinItemWithDicts:(NSArray *)dicts;

@end

@interface HCNewsTopicTagModel : NSObject

@property (nonatomic, strong) NSString *topic_tag_id;
@property (nonatomic, strong) NSString *topic_tag_name;

+ (NSArray *)newsTopicTagItemWithDicts:(NSArray *)dicts;

@end

@interface WBNewsModel : NSObject

@property (nonatomic, copy) NSString *webVersion;       // html版本
@property (nonatomic, copy) NSString *newsId;           // 文章编号,
@property (nonatomic, copy) NSString *title;            // 文章标题,
@property (nonatomic, copy) NSString *brief;            // 文章描述,
@property (nonatomic, copy) NSString *source;           // 文章来源名称,
@property (nonatomic, copy) NSString *timeStr;          // 发布时间,

@property (nonatomic, copy) NSString *tagIcon;          // 标签图标地址,
@property (nonatomic, copy) NSString *detailUrl;        // H5详情页地址,
@property (nonatomic, copy) NSString *ori_url;          // 文章原始地址,
@property (nonatomic, copy) NSString *share_summary;    // 分享描述,
@property (nonatomic, copy) NSString *share_content;    // 分享描述(html),
@property (nonatomic, copy) NSString *share_wxapp_url;    // 微信小程序分享path,
@property (nonatomic, copy) NSString *currencyName;     // 相关币种名称,
@property (nonatomic, copy) NSString *coin_icon;        // 相关币种icon地址,
@property (nonatomic, copy) NSString *coin_cht_name;    // 相关币种中文
@property (nonatomic, copy) NSString *uplift;           // 涨跌率,
@property (nonatomic, copy) NSString *price_usd;       // 币价格 - usd,
@property (nonatomic, copy) NSString *price_cny;       // 币价格 - cny,
@property (nonatomic, copy) NSString *unique_key;       // 预留字段, 文章Feed唯一标示,客户端暂时不使用,
@property (nonatomic, copy) NSString *coin_id;           // 币种ID,
@property (nonatomic, copy) NSString *pair_id;           // 对ID,
@property (nonatomic, copy) NSString *tagName;          // 标签名称
@property (nonatomic, copy) NSString *special_style;    // 特殊样式
@property (nonatomic, copy) NSString *labelTypeString;
@property (nonatomic, copy) NSString *articleStyleString;    //  文章类型字符串形式，一般用于打点： Weibo微博，快讯Express，Article文章

@property (nonatomic, assign) HCNewsLabelStyle labelStyle;   //  标签类型
@property (nonatomic, assign) NSInteger sort;                //  sort id
@property (nonatomic, assign) HCNewsArticleStyle articleStyle;  // 文章类型
@property (nonatomic, assign) HCNewsCellStyle cellStyle;      // cell 类型
@property (nonatomic, assign) HCCurrencyTrendType trendType;    // 涨跌 rise涨; fall跌; ''无涨跌,
@property (nonatomic, assign) BOOL readed;
@property (nonatomic, assign) NSInteger hotSortNumber;  // 热门排行
@property (nonatomic, assign) NSTimeInterval publish_time_stamp; //  新闻发布时间（时间戳）
@property (nonatomic, assign) BOOL is_follow;           // 是否关注币种

@property (nonatomic, strong) NSArray<NSString *> *thumbArray;  // 图片列表
@property (nonatomic, strong) HCNewsArticleAuthorItem *authorItem;  // 作者item
@property (nonatomic, strong) NSArray *showCoinArray;   // 相关币种
@property (nonatomic, strong) NSDate *loadItemTime; // 数据加载成功的时间
@property (nonatomic, strong) HCNewsArticleUserItem *user;  // 作者item
@property (nonatomic, strong) NSString *click;  // 作者item
@property (nonatomic, strong) NSArray *topic_tag_list;


+ (instancetype)newsItemWithDict:(NSDictionary *)dict;
+ (NSArray *)newsItemsWithDicts:(NSArray *)dict;

+ (NSArray *)newsItems;

@end

NS_ASSUME_NONNULL_END

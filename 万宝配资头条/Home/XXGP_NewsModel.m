

#import "XXGP_NewsModel.h"


@implementation HCNewsArticleAuthorItem

+ (instancetype)newArticleAuthorItemWithDict:(NSDictionary *)dict {
    HCNewsArticleAuthorItem *item = [[HCNewsArticleAuthorItem alloc] init];
    
    item.authorName     = [dict getNotNilString:@"name"];
    item.authorHeader   = [dict getNotNilString:@"head_img"];
    item.authorProfile  = [dict getNotNilString:@"profile_url"];
    
    return item;
}

@end

@implementation HCNewsArticleUserItem

+ (instancetype)newArticleUserItemWithDict:(NSDictionary *)dict {
    HCNewsArticleUserItem *item = [[HCNewsArticleUserItem alloc] init];
    item.identity = [dict getNotNilString:@"identity"];   // 作者名称
    item.is_follow = [dict getNotNilString:@"is_follow"]; // 作者头像
    item.nickname = [dict getNotNilString:@"nickname"];    // 作者个人首页
    item.summary = [dict getNotNilString:@"summary"];
    item.type = [[dict getNotNilString:@"type"] integerValue];
    item.user_avatar = [dict getNotNilString:@"user_avatar"];
    item.user_id = [[dict getNotNilString:@"user_id"] integerValue];
    return item;
}

@end

@implementation HCNewsArticleCoinItem

+ (instancetype)newArticleCoinItemWithDict:(NSDictionary *)dict {
    HCNewsArticleCoinItem *item = [[HCNewsArticleCoinItem alloc] init];
    
    item.coin_icon      = [dict getNotNilString:@"coin_icon"];
    item.coin_id        = [dict getNotNilString:@"coin_id"];
    item.coin_name      = [dict getNotNilString:@"coin_name"];
    item.h5_url         = [dict getNotNilString:@"h5_url"];
    item.pair_id        = [dict getNotNilString:@"pair_id"];
    item.rf             = [dict getNotNilString:@"rf"];
    item.rf_rate        = [dict getNotNilString:@"rf_rate"];
    item.slug           = [dict getNotNilString:@"slug"];
    
    if ([[dict getNotNilString:@"rf"] isEqualToString:@"rise"]) {
        item.trendType = HCCurrencyTrendTypeAscend;
    } else if ([[dict getNotNilString:@"rf"] isEqualToString:@"fall"]) {
        item.trendType = HCCurrencyTrendTypeDescend;
    } else {
        item.trendType = HCCurrencyTrendTypeSame;
    }
    
    return item;
}

+ (NSArray *)newsArticleCoinItemWithDicts:(NSArray *)dicts {
    if (![dicts isKindOfClass:[NSArray class]] || 0 == dicts.count) {
        return [NSArray array];
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:dicts.count];
    for (NSDictionary *dict in dicts) {
        HCNewsArticleCoinItem *item = [self newArticleCoinItemWithDict:dict];
        [items addObject:item];
    }
    
    return [items copy];
}

@end

@implementation HCNewsTopicTagModel

+ (instancetype)newTopicTagItemWithDict:(NSDictionary *)dict {
    HCNewsTopicTagModel *item = [[HCNewsTopicTagModel alloc] init];
    
    item.topic_tag_id      = [dict getNotNilString:@"topic_tag_id"];
    item.topic_tag_name    = [dict getNotNilString:@"topic_tag_name"];
    
    return item;
}

+ (NSArray *)newsTopicTagItemWithDicts:(NSArray *)dicts {
    if (![dicts isKindOfClass:[NSArray class]] || 0 == dicts.count) {
        return [NSArray array];
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:dicts.count];
    for (NSDictionary *dict in dicts) {
        HCNewsTopicTagModel *item = [self newTopicTagItemWithDict:dict];
        [items addObject:item];
    }
    
    return [items copy];
}

@end

@implementation XXGP_NewsModel

+ (instancetype)newsItemWithDict:(NSDictionary *)dict {
    XXGP_NewsModel *item = [[self alloc] init];
    
    item.newsId         = [dict getNotNilString:@"id"];
    item.unique_key     = [dict getNotNilString:@"unique_key"];
    item.title          = [dict getNotNilString:@"title"];
    item.brief          = [dict getNotNilString:@"summary"];
    item.source         = [dict getNotNilString:@"source"];
    item.timeStr        = [dict getNotNilString:@"publish_time"];
    item.publish_time_stamp = [[dict getNumber:@"publish_timestamp"] doubleValue];
    item.tagIcon        = [dict getNotNilString:@"label_icon"];
    item.detailUrl      = [dict getNotNilString:@"h5_url"];
    item.share_summary  = [dict getNotNilString:@"share_summary"];
    item.share_content =  [dict getNotNilString:@"share_content"];
    item.uplift         = [dict getNotNilString:@"rf_rate"];
    item.currencyName   = [dict getNotNilString:@"coin_name"];
    item.coin_icon      = [dict getNotNilString:@"coin_icon"];
    item.coin_id        = [dict getNotNilString:@"coin_id"];
    item.coin_cht_name  = [dict getNotNilString:@"cht_name"];
    item.pair_id        = [dict getNotNilString:@"pair_id"];
    item.webVersion     = [dict getNotNilString:@"h5_ver"];
    item.sort           = [[dict getNumber:@"sort"] integerValue];
    item.loadItemTime   = [NSDate new];
    item.click          = [dict getNotNilString:@"click"];
     
    item.showCoinArray  = [HCNewsArticleCoinItem newsArticleCoinItemWithDicts:[dict getArray:@"show_coin"]];
    
    NSString *labelKey = [dict getNotNilString:@"label_key"];
    item.labelTypeString = labelKey;
    if ([labelKey isEqualToString:@"recommend"]) {
        item.labelStyle = HCNewsLabelStylePortfolio;
    } else if ([labelKey isEqualToString:@"hot"]) {
        item.labelStyle = HCNewsLabelStyleHot;
    } else if ([labelKey isEqualToString:@"trend"]) {
        item.labelStyle = HCNewsLabelStyleWatchlist;
    } else if ([labelKey isEqualToString:@"essence"]) {
        item.labelStyle = HCNewsLabelStyleChoice;
    } else if ([labelKey isEqualToString:@"top"]) {
        item.labelStyle = HCNewsLabelStyleTop;
    }
    
    item.special_style  = [dict getNotNilString:@"special_style"];
    
    if ([dict getNotNilString:@"label_name"].length > 0) {
        item.tagName = [dict getNotNilString:@"label_name"];
    } else if ([dict getNotNilString:@"special_style"].length > 0){
        item.tagName = [dict getNotNilString:@"special_style"];
    } else {
        item.tagName = @"";
    }
    
    item.ori_url        = [dict getNotNilString:@"ori_url"];
    
    if ([[dict getNotNilString:@"rf"] isEqualToString:@"rise"]) {
        item.trendType = HCCurrencyTrendTypeAscend;
    } else if ([[dict getNotNilString:@"rf"] isEqualToString:@"fall"]) {
        item.trendType = HCCurrencyTrendTypeDescend;
    } else {
        item.trendType = HCCurrencyTrendTypeSame;
    }
    
    item.thumbArray = [dict getArray:@"thumb"];
//    item.thumbArray = @[[dict getNotNilString:@"thumb"]];
    item.topic_tag_list = [HCNewsTopicTagModel newsTopicTagItemWithDicts:dict[@"topic_tag_list"]];
    
    item.authorItem = [HCNewsArticleAuthorItem newArticleAuthorItemWithDict:[dict getObject:@"author"]];
    
    item.user = [HCNewsArticleUserItem newArticleUserItemWithDict:[dict getObject:@"user"]];

    item.hotSortNumber = [[dict getNotNilString:@"sort_icon"] integerValue];
    
    NSString *cellType = [dict getNotNilString:@"item_type"];
    if (cellType.length > 0) {
        item.cellStyle = [cellType integerValue];
    }
    
//    NSString *article_type = [dict getNotNilString:@"article_type"];
//    if (article_type.length > 0) {
//        item.articleStyle = [article_type integerValue];
//    }
    
    NSInteger articleType = [[dict getNotNilString:@"card"] integerValue];
    switch (articleType) {
        case 1: // 文章
            item.articleStyle = HCNewsArticleStyleArticle;
            item.articleStyleString = @"Article";
            break;
        case 2: // 快讯
            item.articleStyle = HCNewsArticleStyleNewsFlash;
            item.articleStyleString = @"Express";
            break;
        case 8: // 普通话题
            item.articleStyle = HCNewsArticleStyleTopic;
            item.articleStyleString = @"Topic";
            break;
        case 9: // 币种带文章
            item.articleStyle = HCNewsArticleStyleCoinArticle;
            break;
        case 10:    // 分析宝评论
            item.articleStyle = HCNewsArticleStyleCoinTopic;
            item.articleStyleString = @"analysis";
            break;
        case 11:    // 热榜文章
            item.articleStyle = HCNewsArticleStyleHotArticle;
            break;
        case 12:    // 社区帖子
            item.articleStyle = HCNewsArticleStyleCommunityPost;
            break;
        case 99:    // 微博
            item.articleStyle = HCNewsArticleStyleWeibo;
            item.articleStyleString = @"Weibo";
            break;
        case 999:    // 广告
            item.articleStyle = HCNewsArticleStyleFeedAD;
            item.articleStyleString = @"FeedAD";
            break;
            
        default:
            item.articleStyleString = @"FeedAD";
            break;
    }
    
    return item;
}

+ (NSArray *)newsItemsWithDicts:(NSArray *)dicts {
    if (![dicts isKindOfClass:[NSArray class]] || 0 == dicts.count) {
        return [NSArray array];
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:dicts.count];
    for (NSDictionary *dict in dicts) {
        XXGP_NewsModel *item = [self newsItemWithDict:dict];
        [items addObject:item];
    }
    
    return [items copy];
}

+ (NSArray *)newsItems {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0; i < 20; ++i) {
        XXGP_NewsModel *item = [self newsItemWithDict:nil];
        [items addObject:item];
    }
    
    return [items copy];
}

@end

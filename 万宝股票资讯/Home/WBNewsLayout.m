//
//  WBNewsLayout.m
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "WBNewsLayout.h"

@implementation WBNewsLayout

- (instancetype)initWithNews:(WBNewsModel *)news {
    return [self initWithNews:news isHistory:NO];
}

- (instancetype)initWithTopicDetailNews:(WBNewsModel *)news {
    if (!news) return nil;
    if (self = [super init]) {
        _news = news;
        _isTopicFeed = YES;
        [self layout];
    }
    return self;
}

- (instancetype)initWithNews:(WBNewsModel *)news isHistory:(BOOL)isHistory {
    if (!news) return nil;
    if (self = [super init]) {
        _news = news;
        _isHistory = isHistory;
        [self layout];
    }
    return self;
}

- (void)layout {
    _contentViewWidth = kScreenWidth - 2 * kHCNewsCellEdgeInset;
    
    if (_news.articleStyle == HCNewsArticleStyleHotArticle &&
        (_news.hotSortNumber >= 1 && _news.hotSortNumber <= 3)) {
        _contentViewWidth -= kHCNewsHotImageWidth;
    }
    
    [self layoutCoinHeader];
    [self layoutTitle];
    [self layoutArticlePictureView];
    [self layoutUserInfoView];
    [self layoutDescribeView];
    [self layoutContentPictureView];
    [self layoutBottomBarView];

    if (_news.articleStyle == HCNewsArticleStyleHotArticle) {
        _contentViewHeight = _titleViewY + _titleViewHeight + kHCNewsBottomMargin;
    } else {
        _contentViewHeight = _bottomBarViewY + _bottomBarViewHeight + kHCNewsBottomMargin;
    }
    
    _cellHeight = _contentViewHeight + kHCNewsCellBottomEdgeInset;
}

- (void)layoutCoinHeader {
    _coinHeaderY = kHCNewsTopMargin;
    
    if (!_isTopicFeed && ((_news.articleStyle == HCNewsArticleStyleCoinArticle && _news.currencyName.length > 0) || _news.topic_tag_list.count > 0)) {
        _coinHeaderHeight = 21.f;
        _coinHeaderImageHeight = 16.f;
        _coinHeaderNameHeight = 22.f;
        _coinHeaderDescHeight = 0.f;
        _coinHeaderFollowHeight = 20.f;
    } else {
        _coinHeaderHeight = 0;
        _coinHeaderImageHeight = 0;
        _coinHeaderNameHeight = 0;
        _coinHeaderDescHeight = 0;
        _coinHeaderFollowHeight = 0;
    }
}

- (void)layoutTitle {
    if (_news.title.length > 0) {
        if (_coinHeaderHeight > 0) {
            _titleViewY = _coinHeaderY + _coinHeaderHeight + kHCNewsSmallMargin;
        } else {
            _titleViewY = _coinHeaderY + _coinHeaderHeight;
        }
        _titleLabelX = 0;
        CGFloat titleWidth = _contentViewWidth;
        if (_news.cellStyle == HCNewsCellStyleSingle &&
            _news.thumbArray.count > 0) {
            NSString *imageUrlString = _news.thumbArray[0];
            
            if (imageUrlString && imageUrlString.length > 0) {
                _articleImageViewWidth = kHCAdjustIphoneSize(kHCTitleImageViewWidth);
                _articleImageViewHeight = kHCTitleImageViewHeight;
                
                titleWidth -= (_articleImageViewWidth + kHCTitleToImageMargin);
                
                _titleImageViewX = _contentViewWidth - _articleImageViewWidth;
            }
        }
        
        UIFont *font = kHCTitleLabelFont;
        CGSize strSize = [_news.title boundingRectWithSize:CGSizeMake(titleWidth, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        _titleLabelHeight   = strSize.height;
        _titleLabelWidth    = titleWidth;
        
        if (_titleLabelHeight >= _articleImageViewHeight) {
            _titleViewHeight = _titleLabelHeight;
        } else {
            _titleViewHeight = _articleImageViewHeight;
        }
    } else {
        _titleViewY = _coinHeaderY + _coinHeaderHeight;
        _titleViewHeight = 0;
    }
}

- (void)layoutArticlePictureView {
    if (_news.cellStyle == HCNewsCellStyleMore) {
        if (_news.thumbArray.count == 3) {
            _articlePictureViewY = _titleViewY + _titleViewHeight + kHCNewsSmallMargin;
            
            _articleImageViewWidth = (_contentViewWidth - kHCNewsImageMargin * 2) / 3;
            _articleImageViewHeight = _articleImageViewWidth / 3.f * 2.f;
            
            _articlePictureViewHeight = _articleImageViewHeight;
            return;
        }
    }
    
    _articlePictureViewY = _titleViewY + _titleViewHeight;
}

- (void)layoutUserInfoView {
    if (_news.cellStyle == HCNewsCellStyleWeibo) {
        if (_news.authorItem.authorHeader.length > 0 ||
            _news.authorItem.authorName.length > 0) {
            if (_articlePictureViewY == kHCNewsTopMargin) {
                _userInfoViewY = kHCNewsSmallMargin;
            } else {
                _userInfoViewY = _articlePictureViewY + _articlePictureViewHeight + kHCNewsSmallMargin;
            }
            
            _userInfoHeaderX = kHCNewsMargin;
            _userInfoHeaderWidthAndHeight = kHCAdjustIphoneSize(kHCNewsUserHeaderWidthAndHeight);
            
            _userInfoNameLabelX = _userInfoHeaderX + _userInfoHeaderWidthAndHeight + kHCNewsSmallMargin;
            _userInfoNameLabelWidth = _contentViewWidth - _userInfoNameLabelX - _userInfoHeaderWidthAndHeight;
            
            _userInfoViewHeight = kHCAdjustIphoneSize(kHCNewsUserHeaderWidthAndHeight);
            
            return;
        }
    }
    
    _userInfoViewY = _articlePictureViewY + _articlePictureViewHeight;
}

- (void)layoutDescribeView {
    if (_news.cellStyle == HCNewsCellStyleWeibo) {
        if (_news.brief.length > 0) {
            _describeViewY = _userInfoViewY + _userInfoViewHeight + kHCNewsSmallMargin;
            
            CGFloat height = [self getHeightLineWithString:_news.brief withWidth:_contentViewWidth - kHCNewsSmallMargin * 2 withFont:kHCDescribeLabelFont];
            
            if (height >= 75) {
                height = 75;
            }
            
            _describeLabelHeight = height;
            _describeLabelWidth = _contentViewWidth - kHCNewsSmallMargin * 2;
            _describeLabelX = kHCNewsSmallMargin;
            
            _describeViewHeight = _describeLabelHeight;
            
            return;
        }
    }
    _describeViewY = _userInfoViewY + _userInfoViewHeight;
}

#pragma mark - 根据字符串计算label高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}

- (void)layoutContentPictureView {
    if (_news.cellStyle == HCNewsCellStyleWeibo) {
        if (_news.thumbArray.count > 0) {
            _contentPictureViewY = _describeViewY + _describeLabelHeight + kHCNewsSmallMargin;
            _contentPictureImageWidthAndHeight = (kHCNewsContentPictureImageWidthAndHeight);
            
            if (_news.thumbArray.count == 1) {
                _singleContentPictureImageWidth = (kHCSingleContentPictureImageWidth);
                _singleContentPictureImageHeight = (kHCSingleContentPictureImageHeight);
                
                _contentPictureViewHeight = _singleContentPictureImageHeight;
            } else if (_news.thumbArray.count > 1 && _news.thumbArray.count <= 3) {
                _contentPictureViewHeight = _contentPictureImageWidthAndHeight;
            } else if (_news.thumbArray.count > 3 && _news.thumbArray.count <= 6) {
                _contentPictureViewHeight = _contentPictureImageWidthAndHeight * 2 + kHCNewsImageMargin;
            } else if (_news.thumbArray.count > 6) {
                _contentPictureViewHeight = _contentPictureImageWidthAndHeight * 3 + kHCNewsImageMargin * 2;
            }
            
            return;
        }
    }
    _contentPictureViewY = _describeViewY + _describeLabelHeight;
}

- (void)layoutBottomBarView {
    BOOL underTitle = (!_news.thumbArray.count || _news.thumbArray.count == 1);
    _bottomBarViewY = underTitle ? (_titleViewY + _titleLabelHeight + kHCNewsSmallMargin) : (_contentPictureViewY + _contentPictureViewHeight + kHCNewsSmallMargin);
    
    if ([self isHistoryJudge]) {
        _coinButtonX = 0;
        
        NSString *coinButtonTitle = [NSString stringWithFormat:@"%@",_news.tagName];
        NSDictionary *dic = @{NSFontAttributeName:[HCFont pingfangBold:12]};  //指定字号
        CGRect rect = [coinButtonTitle boundingRectWithSize:CGSizeMake(0, kHCNewsBottomBarHeight) options:NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        _coinButtonWidth = rect.size.width + 3 + 3;
        
        if (_news.tagName.length > 0) {
            _bottomInfoLabelX = _coinButtonX + _coinButtonWidth + kHCNewsSmallMargin;
        } else {
            _bottomInfoLabelX = _coinButtonX;
        }
        
        _bottomInfoLabelWidth = _contentViewWidth - _bottomInfoLabelX - kHCNewsSmallMargin;
        
        _bottomBarViewHeight = kHCNewsBottomBarHeight;
        
        if (_bottomBarViewY + _bottomBarViewHeight < _titleViewY + _titleViewHeight) {
            _bottomBarViewY = _titleViewY + _titleViewHeight - _bottomBarViewHeight;
        }
        
    } else {
        _coinButtonX = 0;
        _bottomInfoLabelX = _coinButtonX;
        _bottomInfoLabelWidth = 0;
        _bottomBarViewHeight = 0;
    }
}

- (BOOL)isHistoryJudge {
    if (_isHistory) {
        if (_news.tagName.length > 0 || _news.source.length) {
            return YES;
        }
    } else if (_news.tagName.length > 0 || _news.source.length || NotNullString(_news.timeStr)) {
        return YES;
    }
    return NO;
}

@end

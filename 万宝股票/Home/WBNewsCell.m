//
//  WBNewsCell.m
//  万宝股票
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import "WBNewsCell.h"
#import "HCNewsWeiboImageView.h"
#import "BLExpandButton.h"
#import "UIView+PBExtesion.h"
#import "CoreText/CoreText.h"
#import "UIImageView+WebCache.h"
#import "KNPhotoBrower.h"

typedef NS_ENUM(NSInteger, HCCurrencyColorMode) {
    HCCurrencyColorModeGreenRise = 1,   // 红跌绿涨
    HCCurrencyColorModeRedRise,         // 红涨绿跌
};

@interface WBNewsTagBoxView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) WBNewsModel *newsModel;
@property (nonatomic, copy) void (^tagOnclickBlock)(NSString *url, NSString *tagName, WBNewsModel *newsModel);

@end

@implementation WBNewsTagBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleButton];
    }
    return self;
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithFrame:(CGRect){0, 3, 15, 15}];
    }
    return _iconImageView;
}

- (UIButton *)titleButton {
    if (_titleButton == nil) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = (CGRect){15, 0, 100, self.height};
        [_titleButton setTitleColor:[HCColor colorWithHexString:@"#3F67FF"] forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [HCFont pingfangMedium:15];
        _titleButton.layer.cornerRadius = _titleButton.height / 2;
        _titleButton.layer.masksToBounds = YES;
        [_titleButton addTarget:self action:@selector(titleButtonOnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}

- (void)setTitle:(NSString *)title {
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    CGFloat width = [self sizeForString:title font:self.titleButton.titleLabel.font size:(CGSize){1000, self.titleButton.height} mode:NSLineBreakByWordWrapping].width;
//    CGFloat maxWidth = self.superview.width;
    // 这个判断是最小显示文本长度是3个字  如果小于
//    if (self.x + width + self.iconImageView.width + 21 > maxWidth) {
//        width = maxWidth - self.x;
//    }
    [self.titleButton setWidth:width + 8];
    [self setWidth:self.titleButton.width + self.iconImageView.width + 3];
}

- (void)titleButtonOnclick {
//    if (self.tagOnclickBlock) {
//        self.tagOnclickBlock(self.url, [self.titleButton titleForState:UIControlStateNormal], self.newsModel);
//    }
//    [HCRouterManager openURL:self.url];
}

- (CGSize)sizeForString:(NSString *)contentString font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    UIFont *uiFont = font;
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef) uiFont.fontName, uiFont.pointSize, NULL);

    // When you create an attributed string the default paragraph style has a leading
    // of 0.0. Create a paragraph style that will set the line adjustment equal to
    // the leading value of the font.
    CGFloat leading = uiFont.lineHeight - uiFont.ascender + uiFont.descender;
    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof (CGFloat), &leading };

    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
    CFRange textRange = CFRangeMake(0, contentString.length);

    // Create an empty mutable string big enough to hold our test
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, contentString.length);

    // Inject our text into it
    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) contentString);

    // Apply our font and line spacing attributes over the span
    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, ctFont);
    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CFRange fitRange;

    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, CGSizeMake(size.width, size.height + uiFont.lineHeight), &fitRange);

    CFRelease(framesetter);
    CFRelease(string);
    
    return frameSize;
}


@end


@interface WBTagHeaderView ()

@property (nonatomic, strong) WBNewsTagBoxView *coinTagBoxView;
@property (nonatomic, strong) WBNewsTagBoxView *topicLeftTagBoxView;
@property (nonatomic, strong) WBNewsTagBoxView *topicCenterTagBoxView;
@property (nonatomic, strong) WBNewsTagBoxView *topicRightTagBoxView;

@end

@implementation WBTagHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.coinTagBoxView];
    [self addSubview:self.topicLeftTagBoxView];
    [self addSubview:self.topicCenterTagBoxView];
    [self addSubview:self.topicRightTagBoxView];
}

- (WBNewsTagBoxView *)coinTagBoxView {
    if (_coinTagBoxView == nil) {
        _coinTagBoxView = [[WBNewsTagBoxView alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
    }
    return _coinTagBoxView;
}

- (WBNewsTagBoxView *)topicLeftTagBoxView {
    if (_topicLeftTagBoxView == nil) {
        _topicLeftTagBoxView = [[WBNewsTagBoxView alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
        _topicLeftTagBoxView.iconImageView.image = [UIImage imageNamed:@"topic_share_title_icon"];
        _topicLeftTagBoxView.tag = 1000;
    }
    return _topicLeftTagBoxView;
}

- (WBNewsTagBoxView *)topicCenterTagBoxView {
    if (_topicCenterTagBoxView == nil) {
        _topicCenterTagBoxView = [[WBNewsTagBoxView alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
        _topicCenterTagBoxView.iconImageView.image = [UIImage imageNamed:@"topic_share_title_icon"];
        _topicCenterTagBoxView.tag = 1001;
    }
    return _topicCenterTagBoxView;
}

- (WBNewsTagBoxView *)topicRightTagBoxView {
    if (_topicRightTagBoxView == nil) {
        _topicRightTagBoxView = [[WBNewsTagBoxView alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
        _topicRightTagBoxView.iconImageView.image = [UIImage imageNamed:@"topic_share_title_icon"];
        _topicRightTagBoxView.tag = 1002;
    }
    return _topicRightTagBoxView;
}

- (void)setLayout:(WBNewsLayout *)layout {
    _layout = layout;
    if (layout.news.currencyName.length > 0 || layout.news.topic_tag_list.count > 0) {
        self.frame = CGRectMake(0, layout.coinHeaderY, kScreenWidth - 40, layout.coinHeaderHeight);
        CGFloat offsetX = 0;
        if (layout.news.articleStyle == HCNewsArticleStyleCoinArticle && layout.news.currencyName.length > 0) {
            self.coinTagBoxView.hidden = NO;
            [self.coinTagBoxView.iconImageView sd_setImageWithURL:[NSURL URLWithString:layout.news.coin_icon]];
            self.coinTagBoxView.newsModel = layout.news;
            [self.coinTagBoxView setTitle:layout.news.currencyName];
            self.coinTagBoxView.url = [NSString stringWithFormat:@"hold://TokenDetail?coin_id=%@&pair_id=%@&is_pair_detail=0", _layout.news.coin_id, _layout.news.pair_id];
            offsetX = self.coinTagBoxView.right + 12;
        } else {
            self.coinTagBoxView.hidden = YES;
        }
        
        
        NSInteger topic_tag_list = layout.news.topic_tag_list.count;
        if (topic_tag_list > 3) {
            topic_tag_list = 3;
        }
        self.topicLeftTagBoxView.hidden = YES;
        self.topicCenterTagBoxView.hidden = YES;
        self.topicRightTagBoxView.hidden = YES;
        for (NSInteger index = 0; index < topic_tag_list; index ++) {
            WBNewsTagBoxView *tagBoxView = [self viewWithTag:1000 + index];
            tagBoxView.newsModel = layout.news;
            [tagBoxView setX:offsetX];
            HCNewsTopicTagModel *topicTagModel = [layout.news.topic_tag_list objectAtIndex:index];
            tagBoxView.url = [NSString stringWithFormat:@"hold://new_topic_detail?topic_id=%@", topicTagModel.topic_tag_id];
            [tagBoxView setTitle:topicTagModel.topic_tag_name];
            offsetX = tagBoxView.right + 12;
            if (tagBoxView.right > self.width) {
                // 如果超过了一行就不加了
                return;
            }
            tagBoxView.hidden = NO;
        }
    } else {
        self.frame = CGRectMake(0, 0, 0, 0);
    }
}

- (void)setTagOnclickBlock:(void (^)(NSString *url, NSString *tagName, WBNewsModel *newsModel))tagOnclickBlock {
    self.coinTagBoxView.tagOnclickBlock = tagOnclickBlock;
    self.topicLeftTagBoxView.tagOnclickBlock = tagOnclickBlock;
    self.topicCenterTagBoxView.tagOnclickBlock = tagOnclickBlock;
    self.topicRightTagBoxView.tagOnclickBlock = tagOnclickBlock;
}

@end

@implementation WBCoinRelationView

- (void)setLayout:(WBNewsLayout *)layout  {
    if (layout.news.articleStyle == HCNewsArticleStyleCoinArticle) {
        _firstButton.hidden = YES;
        _secondButton.hidden = YES;
        _thirdButton.hidden = YES;
        return;
    } else {
        _firstButton.hidden = NO;
        _secondButton.hidden = NO;
        _thirdButton.hidden = NO;
    }
    if (layout.news.showCoinArray.count > 0) {
        _layout = layout;
        [self clearCoinButtonContent];
        @WeakObj(self);
        for (int i = 0; i < layout.news.showCoinArray.count; i ++) {
            HCNewsArticleCoinItem *coinItem = layout.news.showCoinArray[i];
            UIButton *tempButton;
            if (i == 0) {
                tempButton = _firstButton;
            } else if (i == 1) {
                tempButton = _secondButton;
            } else if (i == 2) {
                tempButton = _thirdButton;
            }
            
            if (!tempButton) break;
            if (coinItem.coin_name.length > 0 &&
                coinItem.rf_rate.length > 0) {
                NSString *coinButtonTitle = [NSString stringWithFormat:@"%@ %@",coinItem.coin_name, coinItem.rf_rate];
                [tempButton setTitle:coinButtonTitle forState:UIControlStateNormal];
                [self setCoinNameStateWithCoinItem:coinItem button:tempButton];
            }
        }
        
        [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(layout.firstCoinX);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(12);
        }];
        
        [_secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selfWeak.firstButton.mas_right).offset(kHCNewsMargin);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(layout.coinRelationButtonHeight);
        }];
        
        [_thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selfWeak.secondButton.mas_right).offset(kHCNewsMargin);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(layout.coinRelationButtonHeight);
        }];
        
        self.frame = CGRectMake(0, layout.coinRelationY, layout.contentViewWidth, layout.coinRelationHeight);
        self.hidden = NO;
    } else {
        [self clearCoinButtonContent];
        self.hidden = YES;
    }
}

- (void)clearCoinButtonContent {
    [_firstButton setTitle:@"" forState:UIControlStateNormal];
    [_secondButton setTitle:@"" forState:UIControlStateNormal];
    [_thirdButton setTitle:@"" forState:UIControlStateNormal];
    
    [_firstButton setAttributedTitle:nil forState:(UIControlStateNormal)];
    [_secondButton setAttributedTitle:nil forState:(UIControlStateNormal)];
    [_thirdButton setAttributedTitle:nil forState:(UIControlStateNormal)];
}

- (void)setCoinNameStateWithCoinItem:(HCNewsArticleCoinItem *)coinItem button:(UIButton *)sender {
    NSString *titleText = [sender titleForState:(UIControlStateNormal)];
    NSArray *textArray = [titleText componentsSeparatedByString:@" "];
    
    NSString *nameString = @"";
    NSString *rateString = @"";
    if (textArray.count == 2) {
        nameString = textArray[0];
        rateString = textArray[1];
    }
    
    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:titleText];
    
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:[HCColor articleBlack_A70] range:NSMakeRange(0, nameString.length)];
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[HCFont pingfangMedium:13] range:NSMakeRange(0, nameString.length)];
    
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:[self colorWithTrendType:coinItem.trendType colorMode:2] range:NSMakeRange(nameString.length + 1, rateString.length)];
    
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[HCFont pingfangMedium:13] range:NSMakeRange(nameString.length + 1, rateString.length)];
    
    // 3.给label赋值
    [sender setAttributedTitle:fontAttributeNameStr forState:(UIControlStateNormal)];
    sender.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (UIColor *)colorWithTrendType:(HCCurrencyTrendType)trendType colorMode:(HCCurrencyColorMode)colorMode{
    UIColor *resColor;
    switch (trendType) {
        case HCCurrencyTrendTypeSame: {
            resColor = [HCColor appColor2_A100];
        }
            break;
        case HCCurrencyTrendTypeAscend: {
            resColor = (HCCurrencyColorModeRedRise == colorMode ? [HCColor HCRedColor] : [HCColor HCGreenColor]);
        }
            break;
        case HCCurrencyTrendTypeDescend: {
            resColor = (HCCurrencyColorModeRedRise == colorMode ? [HCColor HCGreenColor] : [HCColor HCRedColor]);
        }
            break;
        default:
            break;
    }
    
    return resColor;
}

- (void)reloadAllCoinButton:(NSArray *)dataArray {
//    [[HCRunLoopSocketManager sharedInstance] reloadViewsWithAnimation:@[self.firstButton,self.secondButton,self.thirdButton]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    _firstButton  = [self createCustomButtonWithTag:2000];
    _secondButton = [self createCustomButtonWithTag:2001];
    _thirdButton  = [self createCustomButtonWithTag:2002];
}

- (UIButton *)createCustomButtonWithTag:(NSInteger)tag {
    BLExpandButton *tempButton = [BLExpandButton buttonWithType:UIButtonTypeCustom];
    tempButton.rangeInsets = UIEdgeInsetsMake(kHCNewsMargin, kHCNewsMargin, kHCNewsMargin, kHCNewsMargin);
    tempButton.tag = tag;
    [tempButton setTitleColor:[HCColor articleBlack_A30] forState:UIControlStateNormal];
    tempButton.titleLabel.font = [HCFont pingfangMedium:13];
    [self addSubview:tempButton];
    
//    @WeakObj(self);
    [tempButton xf_addEventHandler:^(id sender) {
//        BLExpandButton *senderButton = (BLExpandButton *)sender;
//        HCNewsArticleCoinItem *coinItem;
//        if (selfWeak.layout.news.showCoinArray.count > senderButton.tag - 2000) {
//            coinItem = selfWeak.layout.news.showCoinArray[senderButton.tag - 2000];
//            [HCRouterManager openURL:[HCUtil getRouterName:@"HCTokenDetailController"] withPara:@{@"coin_id":coinItem.coin_id,@"pair_id":coinItem.pair_id}];
//        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    return tempButton;
}

@end

@implementation WBTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = kHCTitleLabelFont;
    titleLabel.textColor = kHCTitleLabelTextColor;
    titleLabel.numberOfLines = kHCNewsTitleNumberOfLine;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    // 标题右侧图片
    UIImageView *titleImageView = [[UIImageView alloc] init];
    titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    titleImageView.layer.masksToBounds = true;
    titleImageView.layer.borderWidth = 0.5f;
    titleImageView.layer.borderColor = HCColor(242, 242, 242).CGColor;
    [self addSubview:titleImageView];
    _titleImageView = titleImageView;
    
    CALayer *maskLayer = [CALayer new];
    maskLayer.backgroundColor = [[HCColor appColor1_A100] colorWithAlphaComponent:.03].CGColor;
    _titleImageMaskLayer = maskLayer;
}

- (void)setLayout:(WBNewsLayout *)layout {
    if ((layout.news.cellStyle == HCNewsCellStyleSingle ||
         layout.news.cellStyle == HCNewsCellStyleMore) &&
        layout.news.title.length > 0) {
        _titleLabel.text = layout.news.title;
        _titleLabel.frame = CGRectMake(layout.titleLabelX, 0,
                                       layout.titleLabelWidth, layout.titleLabelHeight);
        [self setLineHeight:_titleLabel.font.lineHeight
                   withText:layout.news.title
                    inLabel:_titleLabel];
    } else if (layout.news.title.length > 0) {
        _titleLabel.text = layout.news.title;
        _titleLabel.frame = CGRectMake(layout.titleLabelX, 0,
                                       layout.titleLabelWidth, layout.titleLabelHeight);
        [self setLineHeight:_titleLabel.font.lineHeight
                   withText:layout.news.title
                    inLabel:_titleLabel];
    } else {
        _titleLabel.text = @"";
        _titleLabel.frame = CGRectMake(0, 0, 0, 0);
    }

    [self resetReadedState:layout.news.readed];
    
    if (layout.news.cellStyle == HCNewsCellStyleSingle &&
        layout.news.thumbArray.count > 0) {
        
        if (layout.news.thumbArray[0].length > 0) {
            NSString *urlString = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%.0f,h_%.0f,limit_1,m_fill",layout.news.thumbArray[0],
                                   layout.articleImageViewWidth*2,
                                   layout.articleImageViewHeight*2];
            NSURL *imageUrl = [NSURL URLWithString:urlString];
            
            [_titleImageView sd_setImageWithURL:imageUrl
                               placeholderImage:_placeholderImage];
        }
        
        _titleImageView.frame = CGRectMake(layout.titleImageViewX, 0,
                                           layout.articleImageViewWidth, layout.articleImageViewHeight);
    } else {
        _titleImageView.image = nil;
        _titleImageView.frame = CGRectMake(0, 0, 0, 0);
    }
    
    _titleImageMaskLayer.frame = _titleImageView.frame;
    
    self.frame = CGRectMake(0, layout.titleViewY, layout.contentViewWidth, layout.titleViewHeight);
}

-(void)setLineHeight:(CGFloat)lineHeight withText:(NSString *)text inLabel:(UILabel *)label{
    if (!text || !label) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;

    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    CGFloat baselineOffset = (lineHeight - label.font.lineHeight) / 4;

    [attributes setObject:@(baselineOffset) forKey:NSBaselineOffsetAttributeName];
    label.attributedText = [[NSAttributedString alloc] initWithString:label.text attributes:attributes];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)resetReadedState:(BOOL)readed{
    _titleLabel.textColor = readed ? [[HCColor articleBlack] colorWithAlphaComponent:.6] : [HCColor articleBlack];
}

@end

@implementation WBArticlePictureView

- (void)setLayout:(WBNewsLayout *)layout {
    [self removeAllSubviews];
    [self removeAllSubLayers];
    
    if (layout.news.cellStyle != HCNewsCellStyleMore) {
        self.frame = CGRectMake(0, layout.articlePictureViewY, layout.contentViewWidth, 0);
        return;
    }
    
    CGFloat tempImageView_x = 0;
    NSInteger checkCount = layout.news.thumbArray.count > 3 ? 3 : layout.news.thumbArray.count;
    for (int i = 0; i < checkCount; i ++) {
        if (layout.news.thumbArray[i].length <= 0) continue;
        
        UIImageView *tempImageView = [[UIImageView alloc] init];
        tempImageView.contentMode = UIViewContentModeScaleAspectFill;
        tempImageView.layer.masksToBounds = true;
        tempImageView.layer.borderWidth = 0.5f;
        tempImageView.layer.borderColor = HCColor(242, 242, 242).CGColor;
        tempImageView.layer.cornerRadius = 2;
        
        CALayer *maskLayer = [CALayer new];
        maskLayer.backgroundColor = [[HCColor appColor1_A100] colorWithAlphaComponent:.03].CGColor;
        
        NSString *urlString = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%.0f,h_%.0f,limit_1,m_fill",layout.news.thumbArray[i],
                               layout.articleImageViewWidth*1.5,
                               layout.articleImageViewHeight*1.5];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [tempImageView sd_setImageWithURL:imageUrl
                         placeholderImage:_placeholderImage];
        tempImageView.frame = CGRectMake(tempImageView_x, 0,
                                         layout.articleImageViewWidth, layout.articleImageViewHeight);
        maskLayer.frame = tempImageView.frame;
        [self addSubview:tempImageView];
        [self.layer addSublayer:maskLayer];
        
        tempImageView_x += layout.articleImageViewWidth + kHCNewsImageMargin;
    }
    
    self.frame = CGRectMake(0, layout.articlePictureViewY, layout.contentViewWidth, layout.articlePictureViewHeight);
}

@end

@implementation WBUserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    // 头像
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.userInteractionEnabled = YES;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.borderWidth = 0.5f;
    headerImageView.layer.borderColor = HCColor(242, 242, 242).CGColor;
    [self addSubview:headerImageView];
    _headerImageView = headerImageView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kHCNickNameLabelFont;
    nameLabel.textColor = kHCNickNameLabelTextColor;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
}

- (void)setLayout:(WBNewsLayout *)layout {
    if (layout.news.cellStyle == HCNewsCellStyleWeibo &&
        layout.news.authorItem.authorHeader.length > 0) {
        
        if (layout.news.authorItem.authorHeader.length > 0) {
            NSString *urlString = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%.0f,h_%.0f,limit_1,m_fill",
                                   layout.news.authorItem.authorHeader,
                                   layout.userInfoHeaderWidthAndHeight*1.5,
                                   layout.userInfoHeaderWidthAndHeight*1.5];
            NSURL *imageUrl = [NSURL URLWithString:urlString];
            
            [_headerImageView sd_setImageWithURL:imageUrl];
        }
        
        _headerImageView.layer.cornerRadius = layout.userInfoHeaderWidthAndHeight / 2;
        _headerImageView.frame = CGRectMake(layout.userInfoHeaderX, 0, layout.userInfoHeaderWidthAndHeight, layout.userInfoHeaderWidthAndHeight);
        
//        [_headerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
//
//            [dict setValue:layout.news.authorItem.authorProfile forKey:@"url"];
//            [dict setValue:kPageIDFeed forKey:@"lastPageID"];
//
//            [HCRouterManager openURL:[HCUtil getRouterName:@"HCArticleWebController"]
//                            withPara:dict];
//        }]];
    } else {
        [_headerImageView setImage:nil];
        _headerImageView.frame = CGRectMake(0, 0, 0, 0);
    }
    
    if (layout.news.cellStyle == HCNewsCellStyleWeibo &&
        layout.news.authorItem.authorName.length > 0) {
        _nameLabel.text = layout.news.authorItem.authorName;
        _nameLabel.frame = CGRectMake(layout.userInfoNameLabelX, 0, layout.userInfoNameLabelWidth, layout.userInfoHeaderWidthAndHeight);
    } else {
        _nameLabel.text = @"";
        _nameLabel.frame = CGRectMake(0, 0, 0, 0);
    }
    
    self.frame = CGRectMake(0, layout.userInfoViewY, layout.contentViewWidth, layout.userInfoViewHeight);
}

@end

@implementation WBDescribeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    // 描述
    UILabel *describeLabel = [[UILabel alloc] init];
    describeLabel.textColor = kHCDescribeLabelTextColor;
    describeLabel.font = kHCDescribeLabelFont;
    describeLabel.numberOfLines = 3;
    [self addSubview:describeLabel];
    _describeLabel = describeLabel;
}

- (void)setLayout:(WBNewsLayout *)layout {
    if (layout.news.cellStyle == HCNewsCellStyleWeibo &&
        layout.news.brief.length > 0) {
        _describeLabel.text = layout.news.brief;
        _describeLabel.frame = CGRectMake(layout.describeLabelX, 0, layout.describeLabelWidth, layout.describeLabelHeight);
    } else {
        _describeLabel.text = @"";
        _describeLabel.frame = CGRectMake(0, 0, 0, 0);
    }
    
    self.frame = CGRectMake(0, layout.describeViewY, layout.contentViewWidth, layout.describeViewHeight);
}

@end

@interface WBContentPictureView ()

@property (nonatomic, strong) NSMutableArray *pictureViews;
@property (nonatomic, strong) WBNewsLayout *layout;

@end

@implementation WBContentPictureView

- (void)setLayout:(WBNewsLayout *)layout {
    [_pictureViews removeAllObjects];
    _pictureViews = [[NSMutableArray alloc] initWithCapacity:1];
    
    _layout = layout;
    [self removeAllSubviews];
    
    if (layout.news.cellStyle != HCNewsCellStyleWeibo) {
        return;
    }
    
    if (layout.news.thumbArray.count == 1) {
        CGRect pictureViewFrame = CGRectMake(kHCNewsSmallMargin,
                                             0,
                                             layout.singleContentPictureImageWidth,
                                             layout.singleContentPictureImageHeight);
        
        [self createNewsPictureControlWithUrlString:layout.news.thumbArray[0] frame:pictureViewFrame index:0];
        
        self.frame = CGRectMake(0, layout.contentPictureViewY, layout.contentViewWidth, layout.singleContentPictureImageHeight);
        
    } else if (layout.news.thumbArray.count > 1){
        CGFloat pictureView_X = kHCNewsSmallMargin;
        CGFloat pictureView_Y = 0;
        NSInteger checkCount = layout.news.thumbArray.count > 9 ? 9 : layout.news.thumbArray.count;
        for (int i = 0; i < checkCount; i ++) {
            
            CGRect pictureViewFrame = CGRectMake(pictureView_X, pictureView_Y, layout.contentPictureImageWidthAndHeight, layout.contentPictureImageWidthAndHeight);
            
            [self createNewsPictureControlWithUrlString:layout.news.thumbArray[i] frame:pictureViewFrame index:i];
            
            pictureView_X += layout.contentPictureImageWidthAndHeight + kHCNewsImageMargin;
            
            if (layout.news.thumbArray.count > 4) {
                if (i == 2 || i == 5) {
                    pictureView_X = kHCNewsSmallMargin;
                    pictureView_Y += layout.contentPictureImageWidthAndHeight + kHCNewsImageMargin;
                }
            } else if (layout.news.thumbArray.count == 4) {
                if (i == 1) {
                    pictureView_X = kHCNewsSmallMargin;
                    pictureView_Y += layout.contentPictureImageWidthAndHeight + kHCNewsImageMargin;
                }
            }
        }
        
        self.frame = CGRectMake(0, layout.contentPictureViewY, layout.contentViewWidth, pictureView_Y + layout.contentPictureImageWidthAndHeight);
    }
}

- (void)createNewsPictureControlWithUrlString:(NSString *)urlString frame:(CGRect)frame index:(NSInteger)index {
    NSString *newUrl = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    
    HCNewsWeiboImageView *pictureImageView = [[HCNewsWeiboImageView alloc] initWithFrame:frame];
    pictureImageView.tag = index;
    
    if (urlString.length > 0) {
        NSString *newUrlString = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%.0f,h_%.0f,m_mfit",urlString,
                                  frame.size.width*1.5,
                                  frame.size.height*1.5];
        [pictureImageView sd_setImageWithURL:[NSURL URLWithString:newUrlString] placeholderImage:_placeholderImage];
    }
    
    [self addSubview:pictureImageView];
    
    KNPhotoItems *items = [[KNPhotoItems alloc] init];
    items.url = newUrl;
    items.sourceView = pictureImageView;
    [_pictureViews addObject:items];
    
    pictureImageView.pictureViews = _pictureViews;
}

@end

@implementation WBBottomBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    // 币种 button
    UIButton *coinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [coinButton setTitleColor:[HCColor HCBlueColor] forState:UIControlStateNormal];
    coinButton.titleLabel.font = [HCFont pingfangRegular:11];
    coinButton.layer.cornerRadius = 4.f;
    coinButton.layer.masksToBounds = YES;
    coinButton.layer.borderColor = [HCColor HCBlueColor].CGColor;
    coinButton.layer.borderWidth = 0.5;
    [self addSubview:coinButton];
    _coinButton = coinButton;
    
    // 平台|时间 label
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.textColor = kHCCoinInfoLabelTextColor;
    infoLabel.font = kHCCoinInfoLabelFont;
    [self addSubview:infoLabel];
    _infoLabel = infoLabel;
}

- (void)setLayout:(WBNewsLayout *)layout {
    if (layout.news.tagName.length > 0) {
        _coinButton.frame = CGRectMake(layout.coinButtonX, 5, layout.coinButtonWidth, kHCNewsBottomTagButtonHeight);
        [_coinButton setTitle:layout.news.tagName forState:UIControlStateNormal];
    } else {
        _coinButton.frame = CGRectMake(0, 0, 0, 0);
        [_coinButton setTitle:@"" forState:UIControlStateNormal];
    }
 
    NSString *infoText = @"";
    if(layout.news.articleStyle == HCNewsArticleStyleHotArticle) {
        infoText = @"";
    } else {
        if (layout.news.timeStr.length) {
            infoText = infoText.length ? [infoText stringByAppendingFormat:@"  %@",layout.news.timeStr] : layout.news.timeStr;
        }
        
//        if (layout.news.source.length > 0 && ![HCHoldConfigManager sharedInstance].isPrivate) {
//            infoText = infoText.length ? [infoText stringByAppendingFormat:@"  %@",layout.news.source] : NotNullString(layout.news.source);
//        }
    }
    
    _infoLabel.text = infoText;
    _infoLabel.frame = CGRectMake(layout.bottomInfoLabelX, 0, layout.bottomInfoLabelWidth, kHCNewsBottomBarHeight);
    
    self.frame = CGRectMake(0, layout.bottomBarViewY, layout.contentViewWidth, layout.bottomBarViewHeight);
}

- (void)setCoinNameStateWithLayout:(WBNewsLayout *)layout {
    NSString *titleText = _coinButton.titleLabel.text;
    NSArray *textArray = [titleText componentsSeparatedByString:@" "];
    
    NSString *nameString = @"";
    NSString *rateString = @"";
    if (textArray.count == 2) {
        nameString = textArray[0];
        rateString = textArray[1];
    }

    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:titleText];
    
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:[self colorWithTrendType:layout.news.trendType colorMode:2] range:NSMakeRange(nameString.length + 1, rateString.length)];
    
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:kHCHelvetica_Bold(12) range:NSMakeRange(nameString.length + 1, rateString.length)];
    
    // 3.给label赋值
    [_coinButton setAttributedTitle:fontAttributeNameStr forState:(UIControlStateNormal)];
}

- (UIColor *)colorWithTrendType:(HCCurrencyTrendType)trendType colorMode:(HCCurrencyColorMode)colorMode{
    UIColor *resColor;
    switch (trendType) {
        case HCCurrencyTrendTypeSame: {
            resColor = [HCColor appColor2_A100];
        }
            break;
        case HCCurrencyTrendTypeAscend: {
            resColor = (HCCurrencyColorModeRedRise == colorMode ? [HCColor HCRedColor] : [HCColor HCGreenColor]);
        }
            break;
        case HCCurrencyTrendTypeDescend: {
            resColor = (HCCurrencyColorModeRedRise == colorMode ? [HCColor HCGreenColor] : [HCColor HCRedColor]);
        }
            break;
        default:
            break;
    }
    
    return resColor;
}

@end

@implementation WBNewsView

- (void)setLayout:(WBNewsLayout *)layout {
    _layout = layout;
    
    self.height = layout.contentViewHeight;
    _contentView.height = layout.contentViewHeight;
    _contentView.width = layout.contentViewWidth;
    
    if (_layout.news.articleStyle == HCNewsArticleStyleHotArticle &&
        (_layout.news.hotSortNumber >= 1 && _layout.news.hotSortNumber <= 3)) {
        _contentView.left = 28 + kHCNewsCellEdgeInset;
        _hotImageV.hidden = NO;
        _hotImageV.image = [UIImage imageNamed:[NSString stringWithFormat: @"old_img_market_exchange_rank_%ld_n", (long)_layout.news.hotSortNumber]];
    } else {
        _contentView.left = kHCNewsCellEdgeInset;
        _hotImageV.hidden = YES;
    }
    
    [_coinHeaderView        setLayout:_layout];
//    [_coinRelationView      setLayout:_layout];
    [_titleView             setLayout:_layout];
    [_articlePictureView    setLayout:_layout];
    [_userInfoView          setLayout:_layout];
    [_describeView          setLayout:_layout];
    [_contentPictureView    setLayout:_layout];
    [_bottomBarView         setLayout:_layout];
    
    if (_isShowBottomLine) {
        _bottomLineView.hidden = NO;
        _bottomLineView.frame = CGRectMake(kHCNewsCellEdgeInset, self.bottom - .5, kScreenWidth - 2 * kHCNewsCellEdgeInset, .5);
    } else {
        _bottomLineView.hidden = YES;
    }
    
    self.adCloseButton.hidden = true;
//    if (layout.adModel.is_close) {
//        if (!self.adCloseButton) {
//            self.adCloseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            [self.adCloseButton setImage:[UIImage imageNamed:@"index_feed_ad_close_n"] forState:(UIControlStateNormal)];
//            self.adCloseButton.size = CGSizeMake(20, 20);
//            [self addSubview:self.adCloseButton];
//        }
//
//        self.adCloseButton.hidden = false;
//        self.adCloseButton.centerY = self.bottomBarView.centerY;
//        self.adCloseButton.right = self.width - 20;
//    } else {
//        self.adCloseButton.hidden = true;
//    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 0.1;
    }
    
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    
    UIImage *placeholderImage = [UIImage imageNamed:@"img_home_news_placeholder_n"];
    placeholderImage = [placeholderImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    // 热榜
    UIImageView *hotImageV = [[UIImageView alloc] init];
    hotImageV.hidden = YES;
    hotImageV.frame = CGRectMake(0, 8, 48, 48);
//    hotImageV.backgroundColor = [UIColor redColor];
    [self addSubview:hotImageV];
    _hotImageV = hotImageV;
    
    // 容器
    UIView *contentView = [UIView new];
    contentView.layer.cornerRadius = 4;
    contentView.layer.masksToBounds = NO;
    contentView.top = 0;
    contentView.left = kHCNewsCellEdgeInset;
    contentView.width = kScreenWidth;
    contentView.height = 0.1;
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    _contentView = contentView;
    
    WBTagHeaderView *coinHeaderView = [WBTagHeaderView new];
    [_contentView addSubview:coinHeaderView];
    _coinHeaderView = coinHeaderView;
    
    // 关联币种视图
//    HCCoinRelationView *coinRelationView = [HCCoinRelationView new];
//    [_contentView addSubview:coinRelationView];
//    _coinRelationView = coinRelationView;
    
    // 标题视图
    WBTitleView *titleView = [WBTitleView new];
    titleView.placeholderImage = placeholderImage;
    [_contentView addSubview:titleView];
    _titleView = titleView;
    
    // 文章图片
    WBArticlePictureView *articlePictureView = [WBArticlePictureView new];
    articlePictureView.placeholderImage = placeholderImage;
    [_contentView addSubview:articlePictureView];
    _articlePictureView = articlePictureView;
    
    // 用户信息
    WBUserInfoView *userInfoView = [WBUserInfoView new];
    [_contentView addSubview:userInfoView];
    _userInfoView = userInfoView;
    
    // 描述文字
    WBDescribeView *describeView = [WBDescribeView new];
    [_contentView addSubview:describeView];
    _describeView = describeView;
    
    // 内容图片
    WBContentPictureView *contentPictureView = [WBContentPictureView new];
    contentPictureView.placeholderImage = placeholderImage;
    [_contentView addSubview:contentPictureView];
    _contentPictureView = contentPictureView;
    
    // 底部信息栏
    WBBottomBarView *bottomBarView = [WBBottomBarView new];
    [_contentView addSubview:bottomBarView];
    _bottomBarView = bottomBarView;
    
    // 底部线条
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = [[HCColor blackColor] colorWithAlphaComponent:.1];
    bottomLineView.hidden = YES;
    [self addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
}

@end

@implementation WBNewsCell

- (void)setLayout:(WBNewsLayout *)layout {
    _layout = layout;
    
    self.height = layout.cellHeight;
    self.contentView.height = layout.cellHeight;
    _newsView.layout = layout;
}

#pragma mark - Override
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WBNewsView *newsView = [[WBNewsView alloc] init];
    [newsView.bottomBarView.coinButton addTarget:self action:@selector(coinButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.contentView addSubview:newsView];
    _newsView = newsView;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layout.news.readed = YES;
    [self.newsView.titleView resetReadedState:self.layout.news.readed];
    if ([self.delegate respondsToSelector:@selector(newsCellDidSelect:)]) {
        [self.delegate newsCellDidSelect:self];
    }
}

- (void)ADCloseButtonClicked:(UIButton *)closeButton{
    self.ADCloseClicked ? self.ADCloseClicked(self.layout) : nil;
}

- (void)coinButtonClicked:(UIButton *)coinButton{
    
}

@end

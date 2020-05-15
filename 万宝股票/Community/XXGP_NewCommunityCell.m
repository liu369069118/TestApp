//
//  XXGP_NewCommunityCell.m
//  万宝股票
//
//  Created by 辛峰 on 2020/5/15.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "XXGP_NewCommunityCell.h"
#import "XXGP_CommunityButton.h"
#import "CoreText/CoreText.h"

@interface XXGP_NewCommunityCell ()

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *linkImage;
@property (nonatomic, strong) UILabel *linkLabel;

@property (nonatomic, strong) UILabel *readLabel;
@property (nonatomic, strong) XXGP_CommunityButton *likeButton;
@property (nonatomic, strong) XXGP_CommunityButton *commentButton;

@end

@implementation XXGP_NewCommunityCell

+ (CGFloat)communityCellHeight:(XXGP_newCommunityModel *)model {
    CGFloat height = [self sizeForString:model.content font:[HCFont pingfangRegular:17] size:(CGSize){kScreenWidth - 30, [HCFont pingfangRegular:17].lineHeight * 2.5} mode:NSLineBreakByWordWrapping].height;
    
    return 15 + 40 + 15 + height + 15 + 60 + 15 + 40;
}

- (void)setModel:(XXGP_newCommunityModel *)model {
    _model = model;
    
    
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _nickName.text = model.nickname;
    _timeLabel.text = [self timeStampConversionNSString:model.time];
    
    _contentLabel.text = model.content;
    if (model.img.length > 0) {
        [_linkImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
    } else {
        [_linkImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    
    _linkLabel.text = model.title;
    
    _readLabel.text = [NSString stringWithFormat:@"%@人已阅读",[model.likesModel getNotNilString:@"clicks"]];
    BOOL is_rates = [model.likesModel getBOOL:@"hasAgree"];
    NSString *likes = [model.likesModel getNotNilString:@"likes"];
    NSString *replys = [model.likesModel getNotNilString:@"replys"];
    
    if (is_rates) {
        _likeButton.imageName = @"btn_new_community_cell_like_s";
    } else {
        _likeButton.imageName = @"btn_new_community_cell_like_n";
    }
    
    if (likes.integerValue > 0) {
        _likeButton.titleText = likes;
    } else {
        _likeButton.titleText = @"赞";
    }
    
    if (replys.integerValue > 0) {
        _commentButton.titleText = replys;
    } else {
       _commentButton.titleText = @"评论";
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    _headerImage = [[UIImageView alloc] init];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 20;
    _headerImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_headerImage];
    
//    [_headerImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarAction)]];
    
    _nickName = [[UILabel alloc] init];
    _nickName.textColor = HCColor(41, 36, 32);
    _nickName.font = [HCFont pingfangRegular:15];
    [self.contentView addSubview:_nickName];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [HCColor colorWithHexString:@"#A3A7B9"];
    _timeLabel.font = [HCFont pingfangRegular:12];
    [self.contentView addSubview:_timeLabel];
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.width.height.mas_equalTo(40);
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImage.mas_right).offset(10);
        make.top.mas_equalTo(self.headerImage.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImage.mas_right).offset(10);
        make.bottom.mas_equalTo(self.headerImage.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [HCColor blackColor];
    _contentLabel.font = [HCFont pingfangRegular:17];
    _contentLabel.numberOfLines = 3;
    [self.contentView addSubview:_contentLabel];
    
    _linkImage = [[UIImageView alloc] init];
    _linkImage.contentMode = UIViewContentModeScaleAspectFill;
    _linkImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_linkImage];
    
    _linkLabel = [[UILabel alloc] init];
    _linkLabel.backgroundColor = HCColor(255, 250, 240);
    _linkLabel.textColor = [HCColor blackColor];
    _linkLabel.font = [HCFont pingfangRegular:15];
    _linkLabel.numberOfLines = 2;
    _linkLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_linkLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImage.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [_linkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(60);
    }];
    
    [_linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.linkImage.mas_top);
        make.bottom.mas_equalTo(self.linkImage.mas_bottom);
        make.left.mas_equalTo(self.linkImage.mas_right);
        make.right.mas_equalTo(-15);
    }];
    
    UILabel *readLabel = [[UILabel alloc] init];
    readLabel.textColor = HCColor(128, 128, 105);
    readLabel.font = [HCFont pingfangRegular:13];
    [self.contentView addSubview:readLabel];
    _readLabel = readLabel;
    
    XXGP_CommunityButton *likeButton = [[XXGP_CommunityButton alloc] init];
    [self setButtonNormalState:likeButton];
    [self.contentView addSubview:likeButton];
    _likeButton = likeButton;
    
    XXGP_CommunityButton *commentButton = [[XXGP_CommunityButton alloc] init];
    commentButton.imageName = @"btn_new_community_cell_comment_n";
    [self setButtonNormalState:commentButton];
    [self.contentView addSubview:commentButton];
    _commentButton = commentButton;
    
    [_readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(commentButton.mas_left).offset(-28);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    [_likeButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeButtonAction)]];
    [_commentButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentButtonAction)]];
}


- (void)setButtonNormalState:(XXGP_CommunityButton *)sender {
    sender.titleFont = [HCFont pingfangRegular:13];
    sender.titleTextColor = [HCColor colorWithHexString:@"#A3A7B9"];
}

- (void)likeButtonAction {
    BOOL is_rates = [_model.likesModel getBOOL:@"hasAgree"];
    [self changeFollowState:is_rates];
    
}

- (void)commentButtonAction {
    if (_commentActionBlock) {
        _commentActionBlock(_model);
    }
}

- (void)changeFollowState:(BOOL)isFollow {
    NSMutableDictionary *newLikesModel = [NSMutableDictionary dictionaryWithDictionary:_model.likesModel];
    [newLikesModel setValue:[NSString stringWithFormat:@"%d",!isFollow] forKey:@"hasAgree"];
    
    NSString *likes = [newLikesModel getNotNilString:@"likes"];
    BOOL is_rates = [newLikesModel getBOOL:@"hasAgree"];
    
    NSInteger viewsCount = likes.integerValue;
    if (is_rates) {
        viewsCount ++;
        _likeButton.imageName = @"btn_new_community_cell_like_s";
    } else {
        if (viewsCount > 0) {
            viewsCount --;
        }
        
        _likeButton.imageName = @"btn_new_community_cell_like_n";
    }
    
    if (viewsCount > 0) {
        [newLikesModel setValue:[NSString stringWithFormat:@"%tu",viewsCount] forKey:@"likes"];
    } else {
        [newLikesModel setValue:@"" forKey:@"likes"];
    }
    
    _likeButton.titleText = [newLikesModel getNotNilString:@"likes"];
    
    _model.likesModel = newLikesModel;
}

- (NSString *)timeStampConversionNSString:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (CGSize)sizeForString:(NSString *)contentString font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
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


- (void)avatarAction {
    if (_avatarActionBlock) {
        _avatarActionBlock(_model);
    }
}

@end

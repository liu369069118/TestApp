//
//  WBCommunityCell.m
//  万宝股票
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import "WBCommunityCell.h"
#import "HCNewsWeiboImageView.h"
#import "KNPhotoBrower.h"
#import "UIView+PBExtesion.h"
#import "UIImageView+WebCache.h"

#pragma mark -
@implementation WBCommunityCellHeaderView

- (void)setLayout:(WBCommunityLayout *)layout {
    _layout = layout;
    
    [_avatarView setAvatarWithUserModel:_layout.topicModel.userModel size:HCAvatarSizeSmall];
    _nameLabel.text = _layout.topicModel.userModel.nickname;
    _subNameLabel.text = _layout.topicModel.userModel.identity;
    
    self.frame = CGRectMake(0, _layout.headerView_y, _layout.headerView_w, _layout.headerView_h);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    HCAvatarView *avatarView = [[HCAvatarView alloc] init];
    avatarView.size = CGSizeMake(18, 18);
    avatarView.avatarCornerRadius = 6.f;
    [self addSubview:avatarView];
    _avatarView = avatarView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [HCColor colorWithHexString:@"#1A244F"];
    nameLabel.font = [HCFont pingfangMedium:13];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel *subNameLabel = [[UILabel alloc] init];
    subNameLabel.textColor = [HCColor colorWithHexString:@"#A3A7B9"];
    subNameLabel.font = [HCFont pingfangRegular:13];
    [self addSubview:subNameLabel];
    _subNameLabel = subNameLabel;
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.height.mas_equalTo(18);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(avatarView.mas_centerY);
        make.height.mas_equalTo(18);
        make.left.mas_equalTo(avatarView.mas_right).offset(4);
    }];
    
    [_subNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLabel.mas_centerY);
        make.left.mas_equalTo(nameLabel.mas_right).offset(4);
        make.right.mas_lessThanOrEqualTo(0);
        make.height.mas_equalTo(18);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
//    [WBRouterManager openURL:[WBUtil getRouterName:@"WBUserInfoController"] withPara:@{@"user_id":NotNullString(_layout.topicModel.userModel.user_id)}];
}

@end

#pragma mark -
@implementation WBCommunityCellTopicView

- (void)setLayout:(WBCommunityLayout *)layout {
    _layout = layout;
    
    if (layout.topicView_h > 0) {
        self.hidden = NO;
        NSString *newTitle = [NSString stringWithFormat:@"%@",layout.topicModel.topicTagModel.name];
        [_topicButton setTitle:newTitle forState:UIControlStateNormal];
    } else {
        self.hidden = YES;
    }
    
    self.frame = CGRectMake(0, layout.topicView_y, layout.topicView_w, layout.topicView_h);
}

- (void)setIsFromHome:(BOOL)isFromHome {
    _isFromHome = isFromHome;
    if (_isFromHome) {
        _topicImageView.hidden = NO;
        [_topicButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
        }];
    } else {
        _topicImageView.hidden = YES;
        [_topicButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    UIImageView *topicImageView = [[UIImageView alloc] init];
    topicImageView.hidden = YES;
    topicImageView.image = [UIImage imageNamed:@"topic_share_title_icon"];
    [self addSubview:topicImageView];
    _topicImageView = topicImageView;
    
    UIButton *topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topicButton setTitleColor:[HCColor colorWithHexString:@"#3F67FF"] forState:UIControlStateNormal];
    topicButton.titleLabel.font = [HCFont pingfangMedium:15];
    [topicButton addTarget:self action:@selector(topicButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:topicButton];
    _topicButton = topicButton;

    [_topicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(15);
    }];
    
    [_topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
    }];
}

- (void)topicButtonAction:(UIButton *)sender {
//    [WBRouterManager openURL:[WBUtil getRouterName:@"WBTopicDetailViewController"] withPara:@{@"topic_id" : _layout.topicModel.topicTagModel.topic_tag_id}];
}

@end

#pragma mark -
@implementation WBCommunityCellTitleView

- (void)setLayout:(WBCommunityLayout *)layout {
    if (layout.titleView_h > 0) {
        self.hidden = NO;
        _titleLabel.text = layout.topicModel.title;
    } else {
        self.hidden = YES;
    }
    
    self.frame = CGRectMake(0, layout.titleView_y, layout.titleView_w, layout.titleView_h);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [HCColor colorWithHexString:@"#191919"];
    titleLabel.font = [HCFont pingfangMedium:17];
    titleLabel.numberOfLines = 3;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end

#pragma mark -
@implementation WBCommunityCellDescribeView

- (void)setLayout:(WBCommunityLayout *)layout {
    if (layout.contentView_h > 0) {
        self.hidden = NO;
        _describeLabel.frame = CGRectMake(0, 0, layout.contentLabel_w, layout.contentLabel_h);
        _describeLabel.numberOfLines = layout.contentNumberOfLine;
        [_describeLabel setHyperLinkLabelText:layout.topicModel.content];
        
        _retractButton.hidden = !layout.showRetractButton;
        _retractButton.frame = CGRectMake(0, layout.retractButton_y, layout.retractButton_w, layout.retractButton_h);
        
    } else {
        self.hidden = YES;
    }
    
    self.frame = CGRectMake(0, layout.contentView_y, layout.contentView_w, layout.contentView_h);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    WBHyperLinkLabel *describeLabel = [[WBHyperLinkLabel alloc] init];
    describeLabel.textColor = [HCColor colorWithHexString:@"#5A5A5A"];
    describeLabel.font = kWBCommunityContentFont;
    describeLabel.linkFont = kWBCommunityContentFont;
    [self addSubview:describeLabel];
    _describeLabel = describeLabel;
    
    UIButton *retractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    retractButton.userInteractionEnabled = NO;
    retractButton.hidden = YES;
    [retractButton setTitleColor:[HCColor colorWithHexString:@"#3B5E9C"] forState:UIControlStateNormal];
    [retractButton setTitle:@"全文" forState:UIControlStateNormal];
    retractButton.titleLabel.font = [HCFont pingfangRegular:17];
    [self addSubview:retractButton];
    _retractButton = retractButton;
}

@end

#pragma mark -

@interface WBCommunityCellPictureView ()

@property (nonatomic, strong) NSMutableArray *pictureItems;

@end

@implementation WBCommunityCellPictureView

- (void)setLayout:(WBCommunityLayout *)layout {
    
    if (layout.topicModel.img_data_list.count > 0) {
        self.hidden = NO;
        
        [_pictureView removeAllSubviews];
        _pictureItems = [NSMutableArray arrayWithCapacity:1];
        
        NSInteger imageCount = layout.topicModel.img_data_list.count > 4 ? 4 : layout.topicModel.img_data_list.count;
        CGFloat view_x = 0;
        CGFloat view_y = 0;
        for (int i = 0; i < imageCount; i ++) {
            WBCommunityImageModel *imageModel = layout.topicModel.img_data_list[i];
            
            CGRect imageRect = CGRectMake(view_x, view_y, layout.communityPictureSize, layout.communityPictureSize);
            if (imageCount == 1) {
                imageRect = CGRectMake(view_x, view_y, layout.topicModel.firstImageWidth, layout.topicModel.firstImageHeight);
            }
            
            HCNewsWeiboImageView *imageView = [self createPictureViewWithUrl:imageModel.url frame:imageRect index:i];
            [_pictureView addSubview:imageView];
            
            if (imageCount == 1) {
                imageView.frame = CGRectMake(view_x, view_y, layout.topicModel.firstImageWidth, layout.topicModel.firstImageHeight);
            } else if (imageCount < 4) {
                view_x += layout.communityPictureSize + 4;
            } else {
                if (i == 1) {
                    view_x = 0;
                    view_y += layout.communityPictureSize + 4;
                } else {
                    view_x += layout.communityPictureSize + 4;
                }
            }
        }
    } else {
        self.hidden = YES;
    }
    
    self.frame = CGRectMake(0, layout.pictureView_y, layout.pictureView_w, layout.pictureView_h);
}

- (HCNewsWeiboImageView *)createPictureViewWithUrl:(NSString *)urlString frame:(CGRect)frame index:(NSInteger)index {
    NSString *newUrl = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    
    HCNewsWeiboImageView *pictureImageView = [[HCNewsWeiboImageView alloc] initWithFrame:frame];
    pictureImageView.tag = index;
    
    if (urlString.length > 0) {
        NSString *newUrlString = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%.0f,h_%.0f,m_mfit",urlString,
                                  frame.size.width*1.5,
                                  frame.size.height*1.5];
        
        UIImage *placeholderImage = [UIImage imageNamed:@"img_home_news_placeholder_n"];
        placeholderImage = [placeholderImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
        
        [pictureImageView sd_setImageWithURL:[NSURL URLWithString:newUrlString] placeholderImage:placeholderImage];
    }
    
    KNPhotoItems *items = [[KNPhotoItems alloc] init];
    items.url = newUrl;
    items.sourceView = pictureImageView;
    [_pictureItems addObject:items];
    
    pictureImageView.pictureViews = _pictureItems;
    
    return pictureImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    UIView *pictureView = [[UIView alloc] init];
    [self addSubview:pictureView];
    _pictureView = pictureView;
    
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end

#pragma mark -
@implementation WBCommunityCellFunctionView

- (void)setLayout:(WBCommunityLayout *)layout {
    if (layout.functionView_h > 0) {
        self.hidden = NO;
        _functionView.topicModel = layout.topicModel;
    } else {
        self.hidden = YES;
    }
    
    self.frame = CGRectMake(0, layout.functionView_y, layout.functionView_w, layout.functionView_h);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    WBCommunityFunctionView *functionView = [[WBCommunityFunctionView alloc] init];
    functionView.delegate = self;
    [self addSubview:functionView];
    _functionView = functionView;
    
    [_functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)likeForFunctionViewClick {
    if ([_mainCell.delegate respondsToSelector:@selector(likeClickForCummunityCell:)]) {
        [_mainCell.delegate likeClickForCummunityCell:_mainCell];
    }
}

- (void)commentForFunctionViewClick {
    if ([_mainCell.delegate respondsToSelector:@selector(commentClickForCummunityCell:)]) {
        [_mainCell.delegate commentClickForCummunityCell:_mainCell];
    }
}

@end

#pragma mark -
@implementation WBCommunityCell

- (void)setLayout:(WBCommunityLayout *)layout {
    _layout = layout;
    
    _communityContentView.frame = CGRectMake(_layout.communityContentView_x,
                                             _layout.communityContentView_y,
                                             _layout.communityContentView_w,
                                             _layout.communityContentView_h);
    
    [_headerView    setLayout:_layout];
    [_topicView     setLayout:_layout];
    [_titleView     setLayout:_layout];
    [_describeView  setLayout:_layout];
    [_pictureView   setLayout:_layout];
    [_functionView  setLayout:_layout];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    self.contentView.backgroundColor = [HCColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *communityContentView = [[UIView alloc] init];
    [self.contentView addSubview:communityContentView];
    _communityContentView = communityContentView;
    
    WBCommunityCellHeaderView *headerView = [[WBCommunityCellHeaderView alloc] init];
    headerView.layer.masksToBounds = YES;
    [_communityContentView addSubview:headerView];
    _headerView = headerView;
    
    WBCommunityCellTopicView *topicView = [[WBCommunityCellTopicView alloc] init];
    topicView.layer.masksToBounds = YES;
    [_communityContentView addSubview:topicView];
    _topicView = topicView;
    
    WBCommunityCellTitleView *titleView = [[WBCommunityCellTitleView alloc] init];
    titleView.layer.masksToBounds = YES;
    [_communityContentView addSubview:titleView];
    _titleView = titleView;
    
    WBCommunityCellDescribeView *describeView = [[WBCommunityCellDescribeView alloc] init];
    describeView.layer.masksToBounds = YES;
    [_communityContentView addSubview:describeView];
    _describeView = describeView;
    
    WBCommunityCellPictureView *pictureView = [[WBCommunityCellPictureView alloc] init];
    pictureView.layer.masksToBounds = YES;
    [_communityContentView addSubview:pictureView];
    _pictureView = pictureView;
    
    WBCommunityCellFunctionView *functionView = [[WBCommunityCellFunctionView alloc] init];
    functionView.layer.masksToBounds = YES;
    functionView.mainCell = self;
    [_communityContentView addSubview:functionView];
    _functionView = functionView;
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [HCColor grayColor:232];
    [_communityContentView addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if ([_delegate respondsToSelector:@selector(cummunityCellAction:)]) {
        [_delegate cummunityCellAction:self];
    }
}

@end

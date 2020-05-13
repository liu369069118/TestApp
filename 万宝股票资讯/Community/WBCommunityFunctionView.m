//
//  WBCommunityFunctionView.m
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "WBCommunityFunctionView.h"

#import "WBCommunityButton.h"

@interface WBCommunityFunctionView ()

@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) WBCommunityButton *likeButton;
@property (nonatomic, weak) WBCommunityButton *commentButton;

@end

@implementation WBCommunityFunctionView

- (void)setTopicModel:(WBCommunityModel *)topicModel {
    _topicModel = topicModel;
    
    _timeLabel.text = _topicModel.create_time;
    _nameLabel.text = [NSString stringWithFormat:@"%@浏览",_topicModel.views];
    
    if (_topicModel.create_time.length > 0) {
        [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLabel.mas_right).offset(10);
        }];
    } else {
        [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLabel.mas_right).offset(0);
        }];
    }
    
    if (_topicModel.is_rates) {
        _likeButton.imageName = @"btn_new_community_cell_like_s";
    } else {
        _likeButton.imageName = @"btn_new_community_cell_like_n";
    }
    
    if (_topicModel.rates.integerValue > 0) {
        _likeButton.titleText = _topicModel.rates;
    } else {
        _likeButton.titleText = @"";
    }
    
    if (_topicModel.comments.integerValue > 0) {
        _commentButton.titleText = _topicModel.comments;
    } else {
       _commentButton.titleText = @"";
    }
}

#pragma mark -
#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [HCColor colorWithHexString:@"#A3A7B9"];
    timeLabel.font = [HCFont pingfangRegular:13];
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [HCColor colorWithHexString:@"#A3A7B9"];
    nameLabel.font = [HCFont pingfangRegular:13];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    WBCommunityButton *likeButton = [[WBCommunityButton alloc] init];
    [self setButtonNormalState:likeButton];
    [self addSubview:likeButton];
    _likeButton = likeButton;
    
    WBCommunityButton *commentButton = [[WBCommunityButton alloc] init];
    commentButton.imageName = @"btn_new_community_cell_comment_n";
    [self setButtonNormalState:commentButton];
    [self addSubview:commentButton];
    _commentButton = commentButton;
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeLabel.mas_right).offset(10);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kHCAdjustSize(130));
    }];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(commentButton.mas_left).offset(-28);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
    }];

    [_likeButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeButtonAction)]];
    [_commentButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentButtonAction)]];
}

- (void)setButtonNormalState:(WBCommunityButton *)sender {
    sender.titleFont = [HCFont pingfangRegular:13];
    sender.titleTextColor = [HCColor colorWithHexString:@"#A3A7B9"];
}

- (void)likeButtonAction {
//    if (![HCAuthManager isAuthenticated]) {
//        [HCRouterManager openURL:@"hold://Login"];
//        return;
//    }
    [self changeFollowState:_topicModel.is_rates];
    
    if ([_delegate respondsToSelector:@selector(likeForFunctionViewClick)]) {
        [_delegate likeForFunctionViewClick];
    }
}

- (void)commentButtonAction {
    if ([_delegate respondsToSelector:@selector(commentForFunctionViewClick)]) {
        [_delegate commentForFunctionViewClick];
    }
}

- (void)changeFollowState:(BOOL)isFollow {
    _topicModel.is_rates = !isFollow;
    
    NSInteger viewsCount = _topicModel.rates.integerValue;
    if (_topicModel.is_rates) {
        viewsCount ++;
        _likeButton.imageName = @"btn_new_community_cell_like_s";
    } else {
        if (viewsCount > 0) {
            viewsCount --;
        }
        
        _likeButton.imageName = @"btn_new_community_cell_like_n";
    }
    
    if (viewsCount > 0) {
        _topicModel.rates = [NSString stringWithFormat:@"%tu",viewsCount];
    } else {
        _topicModel.rates = @"";
    }
    
    _likeButton.titleText = _topicModel.rates;
}


@end

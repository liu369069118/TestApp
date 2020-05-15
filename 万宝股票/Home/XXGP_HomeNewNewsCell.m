//
//  XXGP_HomeNewNewsCell.m
//  万宝股票
//
//  Created by 辛峰 on 2020/5/15.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "XXGP_HomeNewNewsCell.h"

@interface XXGP_HomeNewNewsCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *thumImageView;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation XXGP_HomeNewNewsCell

- (void)setModel:(XXGP_HomeNewNewsModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    [_thumImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
    _timeLabel.text = model.ctime;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [HCFont pingfangRegular:18];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    
    _thumImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_thumImageView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = HCColor(220, 220, 220);
    _timeLabel.font = [HCFont pingfangRegular:13];
    [self.contentView addSubview:_timeLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(-150);
    }];
    
    [_thumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(90);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(200);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HCColor(248, 248, 248);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

@end

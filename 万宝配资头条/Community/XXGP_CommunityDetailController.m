//
//  XXGP_CommunityDetailController.m
//  万宝配资头条
//
//  Created by 辛峰 on 2020/5/19.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "XXGP_CommunityDetailController.h"
#import "XXGP_ReleaPageViewController.h"

@interface XXGP_CommunityDetailController ()

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *readLabel;

@property (nonatomic, strong) UIButton *publishButton;

@property (nonatomic, strong) UILabel *noMoreLabel;

@end

@implementation XXGP_CommunityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btn_navigation_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"评论详情";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    
    UIView *titleView = [[UIView alloc] init];
    [titleView addSubview:label];
    [titleView addSubview:backButton];
    [self.view addSubview:titleView];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
        make.left.mas_equalTo(20);
        make.width.height.mas_equalTo(30);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kHCNavigationBarHeight);
    }];
    
    _headerImage = [[UIImageView alloc] init];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 20;
    _headerImage.userInteractionEnabled = YES;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    [self.view addSubview:_headerImage];
    
    _nickName = [[UILabel alloc] init];
    _nickName.textColor = HCColor(41, 36, 32);
    _nickName.font = [HCFont pingfangRegular:15];
    _nickName.text = _model.nickname;
    [self.view addSubview:_nickName];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [HCColor colorWithHexString:@"#A3A7B9"];
    _timeLabel.font = [HCFont pingfangRegular:12];
    _timeLabel.text = [self timeStampConversionNSString:_model.time];
    [self.view addSubview:_timeLabel];
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHCNavigationBarHeight + 15);
        make.left.mas_equalTo(15);
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
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = _model.content;
    [self.view addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImage.mas_bottom).offset(15);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    _readLabel = [[UILabel alloc] init];
    _readLabel.textColor = HCColor(128, 128, 105);
    _readLabel.font = [HCFont pingfangRegular:13];
    _readLabel.text = [NSString stringWithFormat:@"%@人已阅读",[_model.likesModel getNotNilString:@"clicks"]];
    [self.view addSubview:_readLabel];
    
    [_readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(15);
        make.height.mas_offset(40);
    }];
    
    _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _publishButton.backgroundColor = [UIColor whiteColor];
    [_publishButton setTitle:@"发布新评论" forState:UIControlStateNormal];
    [_publishButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _publishButton.layer.cornerRadius = 5.f;
    _publishButton.layer.borderColor = [UIColor redColor].CGColor;
    _publishButton.layer.borderWidth = 0.5f;
    [_publishButton addTarget:self action:@selector(publishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_publishButton];
    
    [_publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.readLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    
    _noMoreLabel = [[UILabel alloc] init];
    _noMoreLabel.textColor = HCColor(220, 220, 220);
    _noMoreLabel.font = [HCFont pingfangRegular:13];
    _noMoreLabel.text = @"暂时没有评论，快来抢沙发吧~";
    _noMoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_noMoreLabel];
    
    [self.view layoutIfNeeded];
    
    [_noMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenHeight - self.publishButton.bottom);
    }];
    
}

- (NSString *)timeStampConversionNSString:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)publishButtonAction {
    XXGP_ReleaPageViewController *webVC = [[XXGP_ReleaPageViewController alloc] init];
    webVC.naviTitle = @"评论";
    [self.navigationController pushViewController:webVC animated:YES];
}

@end

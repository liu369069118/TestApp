//
//  WBFunctionCell.m
//  万宝股票
//
//  Created by 刘涛 on 2020/5/9.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import "WBFunctionCell.h"

@interface WBFunctionCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation WBFunctionCell

+ (NSString *)indentifier {
    return @"WBFunctionCellKey";
}

+ (CGFloat)cellHeight {
    return 44.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupLayoutCell];
    }
    return self;
}

- (void)setupLayoutCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.textColor = [HCColor colorWithHexString:@"333333"];
    [self.contentView addSubview:_contentLabel];
    
    _switchView = [[UISwitch alloc] init];
    [_switchView setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"safeMode"] animated:NO];
    [_switchView addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_switchView];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(16);
    }];
    [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-16);
    }];
}

- (void)setContentStr:(NSString *)contentStr {
    _contentLabel.text = contentStr;
}

- (void)change:(UISwitch *)sender {
    if (sender.on) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        backView.tag = 1001;
        backView.userInteractionEnabled = NO;
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [UIApplication.sharedApplication.keyWindow addSubview:backView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"safeMode"];
    } else {
        UIView *backView = [UIApplication.sharedApplication.keyWindow viewWithTag:1001];
        if (backView) {
            [backView removeFromSuperview];
        }
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"safeMode"];
    }
}

@end

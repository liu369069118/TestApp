//
//  WBFooterView.m
//  万宝股票资讯
//
//  Created by 刘涛 on 2020/5/9.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "WBFooterView.h"

@implementation WBFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *content = [[UILabel alloc] init];
        content.textColor = [HCColor colorWithHexString:@"666666"];
        content.font  = [UIFont systemFontOfSize:12];
        content.text = @"市场有风险，投资需谨慎.";
        [self addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
    }
    return self;
}

@end

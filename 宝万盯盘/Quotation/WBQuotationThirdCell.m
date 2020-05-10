//
//  WBQuotationThirdCell.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/10.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBQuotationThirdCell.h"
#import "WBQuotationFirstModel.h"
#import <YYModel/YYModel.h>

@implementation WBQuotationThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.frame = CGRectMake(15, 0, kScreenWidth, 50);
        topLabel.text = @"热门股票";
        topLabel.font = [UIFont boldSystemFontOfSize:18];
        topLabel.textColor = [UIColor blackColor];
        topLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:topLabel];
        
        [self createContentViews];
    }
    return self;
}

- (void)createContentViews {
    NSArray *list = [self getResponceListData];
    CGFloat margin = 15;
    CGFloat view_x = margin;
    CGFloat view_y = 50;
    CGFloat btnW = kScreenWidth - 30;
    CGFloat btnH = 60;
    for (int i = 0; i < list.count; i++) {
        UIView *plateView = [self createPlateView:list[i]];
        plateView.frame = CGRectMake(view_x, view_y, btnW, btnH);
        plateView.tag = i;
        [self.contentView addSubview:plateView];
        
        view_y += btnH;
    }
}

- (UIView *)createPlateView:(WBQuotationFirstModel *)model {
    UIView *plateView = [[UIView alloc] init];
    plateView.backgroundColor = [HCColor whiteColor];
    
    UILabel *leftLabel = [self createLabel:model.block fontSizr:17];
    leftLabel.textColor = [UIColor blackColor];
    [plateView addSubview:leftLabel];
    
    UILabel *subleftLabel = [self createLabel:model.code fontSizr:15];
    subleftLabel.textColor = HCColor(220, 220, 220);
    [plateView addSubview:subleftLabel];
    
    UILabel *centerLabel = [self createLabel:model.containtopTitle fontSizr:17];
    centerLabel.textColor = [HCColor colorWithR:225 G:128 B:0];
    [plateView addSubview:centerLabel];
    
    UILabel *rightLabel = [self createLabel:model.percent fontSizr:17];
    rightLabel.textColor = [HCColor redColor];
    [plateView addSubview:rightLabel];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.mas_offset(0);
        make.height.mas_offset(20);
    }];
    
    [subleftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-5);
        make.left.mas_offset(0);
        make.height.mas_offset(20);
    }];
    
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.centerX.mas_offset(0);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.centerY.mas_offset(0);
        make.height.mas_offset(20);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [HCColor colorWithR:176 G:224 B:230];
    [plateView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
    
    return plateView;
}

- (UILabel *)createLabel:(NSString *)text fontSizr:(NSInteger)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (NSMutableArray *)getResponceListData {
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"WBThirdCellData"];
    NSMutableArray *list  = [homeDict objectForKey:@"list"];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dict in list) {
        WBQuotationFirstModel *model = [WBQuotationFirstModel yy_modelWithDictionary:dict];
        [result addObject:model];
    }
    
    return result;
}

@end

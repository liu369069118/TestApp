//
//  WBQuotationFirstCell.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/10.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBQuotationFirstCell.h"
#import "WBQuotationFirstModel.h"
#import <YYModel/YYModel.h>

@interface WBQuotationFirstCell ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation WBQuotationFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.frame = CGRectMake(15, 0, kScreenWidth, 40);
        topLabel.text = @"热门板块";
        topLabel.font = [UIFont boldSystemFontOfSize:18];
        topLabel.textColor = [UIColor blackColor];
        topLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:topLabel];
        
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 40, kScreenWidth, (kScreenWidth - 30 - 6) / 4 * 3 + 6);
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_mainScrollView];
        
        [self createContentViews];
    }
    return self;
}

- (void)createContentViews {
    NSArray *list = [self getResponceListData];
    CGFloat margin = 15;
    CGFloat submargin = 2;
    CGFloat view_x = margin;
    CGFloat view_y = 0;
    CGFloat btnW = (kScreenWidth - 30 - 6) / 4;
    
    for (int i = 0; i < list.count; i++) {
        UIView *plateView = [self createPlateView:list[i]];
        plateView.frame = CGRectMake(view_x, view_y, btnW, btnW);
        plateView.tag = i;
        
        [_mainScrollView addSubview:plateView];
        
        view_x += btnW + submargin;
        if ((i+1)%4 == 0) {
            view_y += btnW + submargin;
            view_x = margin;
        }
    }
}

- (UIView *)createPlateView:(WBQuotationFirstModel *)model {
    UIView *plateView = [[UIView alloc] init];
    plateView.backgroundColor = [HCColor colorWithR:225 G:128 B:0];
    
    UILabel *nameLabel = [self createLabel:model.block fontSizr:15];
    [plateView addSubview:nameLabel];
    
    UILabel *titleLabel = [self createLabel:model.containtopTitle fontSizr:15];
    [plateView addSubview:titleLabel];
    
    UILabel *subnameLabel = [self createLabel:model.name fontSizr:11];
    [plateView addSubview:subnameLabel];
    
    UILabel *rateLabel = [self createLabel:model.percent fontSizr:11];
    [plateView addSubview:rateLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(15);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(4);
    }];
    
    [subnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(4);
    }];
    
    [rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(subnameLabel.mas_bottom).offset(1);
    }];
    
    return plateView;
}

- (UILabel *)createLabel:(NSString *)text fontSizr:(NSInteger)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (NSMutableArray *)getResponceListData {
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"WBFirstCellData"];
    NSMutableArray *list  = [homeDict objectForKey:@"list"];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dict in list) {
        WBQuotationFirstModel *model = [WBQuotationFirstModel yy_modelWithDictionary:dict];
        [result addObject:model];
    }
    
    return result;
}

@end

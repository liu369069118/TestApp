//
//  WBQuotationSecondCell.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/10.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBQuotationSecondCell.h"
#import "WBQuotationFirstModel.h"
#import <YYModel/YYModel.h>

@interface WBQuotationSecondCell ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation WBQuotationSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 10, kScreenWidth, 100);
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
    CGFloat submargin = 10;
    CGFloat view_x = margin;
    CGFloat view_y = 0;
    CGFloat btnW = (kScreenWidth - 50) / 3;
    
    for (int i = 0; i < list.count; i++) {
        UIView *plateView = [self createPlateView:list[i]];
        plateView.frame = CGRectMake(view_x, view_y, btnW, 100);
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
    plateView.backgroundColor = [HCColor whiteColor];
    plateView.layer.cornerRadius = 4.f;
    plateView.layer.masksToBounds = YES;
    plateView.layer.borderColor = [HCColor colorWithR:225 G:128 B:0].CGColor;
    plateView.layer.borderWidth = 0.5;
    
    UILabel *nameLabel = [self createLabel:model.block fontSizr:15];
    nameLabel.textColor = [UIColor blackColor];
    [plateView addSubview:nameLabel];
    
    UILabel *titleLabel = [self createLabel:model.name fontSizr:20];
    titleLabel.textColor = [UIColor redColor];
    [plateView addSubview:titleLabel];
    
    UILabel *subnameLabel = [self createLabel:model.percent fontSizr:13];
    subnameLabel.textColor = [UIColor redColor];
    [plateView addSubview:subnameLabel];
    
    UILabel *rateLabel = [self createLabel:model.containtopTitle fontSizr:13];
    rateLabel.textColor = [UIColor redColor];
    [plateView addSubview:rateLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(15);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
    }];
    
    [subnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.bottom.mas_equalTo(-10);
        make.height.mas_offset(15);
    }];
    
    [rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.bottom.mas_equalTo(-10);
        make.height.mas_offset(15);
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


- (NSArray *)getResponceListData {
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"WBSecondCellData"];
    NSMutableArray *list  = [homeDict objectForKey:@"list"];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dict in list) {
        WBQuotationFirstModel *model = [WBQuotationFirstModel yy_modelWithDictionary:dict];
        [result addObject:model];
    }
    
    return result;
}

@end

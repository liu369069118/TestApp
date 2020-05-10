//
//  WBQuotationController.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/10.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBQuotationController.h"
#import "WBSearchListController.h"

@interface WBQuotationController ()

@end

@implementation WBQuotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"行情";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"SearchContactsBarIcon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(jumpSearchVc) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *titleView = [[UIView alloc] init];
    [titleView addSubview:label];
    [titleView addSubview:searchBtn];
    [self.view addSubview:titleView];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY).offset(0);
        make.right.mas_equalTo(-16);
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kHCNavigationBarHeight);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)jumpSearchVc {
    WBSearchListController *vc = [[WBSearchListController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

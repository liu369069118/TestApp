//
//  WBQuotationController.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/10.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBQuotationController.h"
#import "WBQuotationFirstCell.h"
#import "WBQuotationSecondCell.h"
#import "WBQuotationThirdCell.h"
#import "WBSearchListController.h"

@interface WBQuotationController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

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
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [HCColor whiteColor];
    tableView.backgroundView = [UIView new];
    tableView.backgroundView.opaque = NO;
    tableView.backgroundView.backgroundColor = [HCColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.decelerationRate = 10;
    [tableView registerClass:[WBQuotationFirstCell class] forCellReuseIdentifier:@"WBQuotationFirstCell"];
    [tableView registerClass:[WBQuotationSecondCell class] forCellReuseIdentifier:@"WBQuotationSecondCell"];
    [tableView registerClass:[WBQuotationThirdCell class] forCellReuseIdentifier:@"WBQuotationThirdCell"];
    
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHCNavigationBarHeight);
        make.left.bottom.right.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDelegate && UITAbleViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return (kScreenWidth - 30 - 6) / 4 * 3 + 4 + 40;
    } else if (indexPath.row == 1) {
        return 110;
    } else {
        return 60 * 90 + 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        WBQuotationFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBQuotationFirstCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 1){
        WBQuotationSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBQuotationSecondCell" forIndexPath:indexPath];
        return cell;
    } else {
        WBQuotationThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBQuotationThirdCell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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

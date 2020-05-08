//
//  WBUserController.m
//  宝万盯盘
//
//  Created by 刘涛 on 2020/5/8.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBUserController.h"
#import "WBContentCell.h"
#import "WBFunctionCell.h"
#import "WBUserHeader.h"
#import "WBFooterView.h"
#import "STLoadViewController.h"

@interface WBUserController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) WBUserHeader *header;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation WBUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _header = [[WBUserHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    MJWeakSelf
    _header.kClickEventBlock = ^{
        if (![STLoginTool sharedInstance].isLogin) {
            STLoadViewController *desVc = [[STLoadViewController alloc] init];
            desVc.loadStatus = ^{
                //登录成功回调
                [weakSelf.header updateUI];
            };
            [weakSelf.navigationController pushViewController:desVc animated:YES];
        }
    };
    
    WBFooterView *footer = [[WBFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.tableHeaderView = _header;
    _tableview.tableFooterView = footer;
    [self.view addSubview:_tableview];
    [_tableview registerClass:WBContentCell.class forCellReuseIdentifier:WBContentCell.indentifier];
    [_tableview registerClass:WBFunctionCell.class forCellReuseIdentifier:WBFunctionCell.indentifier];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WBContentCell.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *data = [self.dataArray objectAtIndex:section];
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *data = [self.dataArray objectAtIndex:indexPath.section];

    if (indexPath.section == 0) {
        WBFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:WBFunctionCell.indentifier forIndexPath:indexPath];
        cell.contentStr = [data objectAtIndex:indexPath.row];
        return cell;
    } else {
        WBContentCell *cell = [tableView dequeueReusableCellWithIdentifier:WBContentCell.indentifier forIndexPath:indexPath];
        cell.contentStr = [data objectAtIndex:indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            
        } else if (indexPath.row == 2) {
            if ([STLoginTool sharedInstance].isLogin) {
                MJWeakSelf
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退出当前账号吗？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [[STLoginTool sharedInstance] loginOut];
                    [weakSelf.header updateUI];
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action1];
                [alert addAction:action2];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                        @[@"护眼模式"],
                        @[@"意见反馈",@"关于我们",@"退出账号"]
                    ];
    }
    return _dataArray;
}

@end

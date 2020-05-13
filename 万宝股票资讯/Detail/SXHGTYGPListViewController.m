//
//  MQMathController.m
//  EFAnimationMenu
//
//  Created by ddd on 2019/3/28.
//  Copyright © 2019 Jueying. All rights reserved.
//

#import "SXHGTYGPListViewController.h"

#import "SXHGTYGPUTButton.h"
#import "SXHGTYGPLineTableViewCell.h"
#import "SXHGTYStockDetailViewController.h"
@interface SXHGTYGPListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *SXHG_ContetListGroups;

@end
@implementation SXHGTYGPListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = self.SXHG_NaviBackButton;

    _contentListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 34 ) style:UITableViewStylePlain];
    
    if (!iPhoneX_Series) {
        _contentListTable.height += 34 + 44;
    }
    if (_isSeg) {
        _contentListTable.height = _contentListTable.height -180 - 30;
    }
    _contentListTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _contentListTable.delegate = self;
    _contentListTable.dataSource = self;
    [_contentListTable registerNib:[UINib nibWithNibName:@"SXHGTYGPLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXHGTYGPLineTableViewCell"];
    [self.view addSubview:_contentListTable];
    _contentListTable.translatesAutoresizingMaskIntoConstraints = YES;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;

    _SXHG_ContetListGroups = [NSMutableArray new];
    [_SXHG_ContetListGroups addObjectsFromArray:_stocks];
    [_contentListTable reloadData];
    
    SXHGTYGPUTButton *hed = [[[NSBundle mainBundle] loadNibNamed:@"SXHGTYGPUTButton" owner:nil options:nil] lastObject];
    _contentListTable.tableHeaderView = hed;
    _contentListTable.tableFooterView = [UIView new];
    _contentListTable.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    if (self.isSeg) {
        self.contentListTable.scrollEnabled = 0;
    }
}

- (void)refresh:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _SXHG_ContetListGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"SXHGTYGPLineTableViewCell";

    SXHGTYGPLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if ([self.title containsString:@"跌"]) {
        cell.acd = 1;
    } else if ([self.title containsString:@"涨"]) {
        cell.acd = 0;
    } else {
        cell.acd = 2;
    }

    [cell updateListCellDataWithDict:_SXHG_ContetListGroups[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.SXHG_ContetListGroups objectAtIndex:indexPath.row];
    SXHGTYStockDetailViewController *vc = [SXHGTYStockDetailViewController new];
    vc.gpcode = dict[@"code"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

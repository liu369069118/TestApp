
#import "XXGP_UserController.h"
#import "XXGP_ContentCell.h"
#import "XXGP_FunctionCell.h"
#import "XXGP_UserHeader.h"
#import "XXGP_FooterView.h"
#import "XXGP_LoadViewController.h"
#import "HBActionSheet.h"
#import "KNToast.h"
#import "SDImageCache.h"
#import "HCRequestCache.h"
#import "XXGP_WebController.h"

@interface XXGP_UserController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) XXGP_UserHeader *header;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation XXGP_UserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户中心";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navigation_back_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goHome)];
    
    _header = [[XXGP_UserHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    MJWeakSelf
    _header.kClickEventBlock = ^{
        if (![XXGP_LoginTool sharedInstance].isLogin) {
            XXGP_LoadViewController *desVc = [[XXGP_LoadViewController alloc] init];
            desVc.loadStatus = ^{
                //登录成功回调
                [weakSelf.header updateUI];
            };
            [weakSelf.navigationController pushViewController:desVc animated:YES];
        }
    };
    
    XXGP_FooterView *footer = [[XXGP_FooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.tableHeaderView = _header;
    _tableview.tableFooterView = footer;
    [self.view addSubview:_tableview];
    [_tableview registerClass:XXGP_ContentCell.class forCellReuseIdentifier:XXGP_ContentCell.indentifier];
    [_tableview registerClass:XXGP_FunctionCell.class forCellReuseIdentifier:XXGP_FunctionCell.indentifier];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return XXGP_ContentCell.cellHeight;
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
        XXGP_FunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:XXGP_FunctionCell.indentifier forIndexPath:indexPath];
        cell.contentStr = [data objectAtIndex:indexPath.row];
        return cell;
    } else {
        XXGP_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:XXGP_ContentCell.indentifier forIndexPath:indexPath];
        cell.contentStr = [data objectAtIndex:indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            @WeakObj(self);
            NSString *cacheString = [NSString stringWithFormat:@"是否清空 %@ 缓存?",[self getCacheSize]];
            HBActionSheet *actionSheet = [[HBActionSheet alloc] initActionSheetWithTitle:@"" descriptiveText:cacheString cancelButtonTitle:@"取消" destructiveButtonTitles:@[@"清空"] otherButtonTitles:@[] itemAction:^(HBActionSheet *actionSheet, NSString *title, NSInteger index) {
                if ([title isEqualToString:@"清空"]) {
                    [selfWeak clearCache];
                } else {
                    
                }
            }];
            [actionSheet showAction];
        } else if (indexPath.row == 1) {
            XXGP_WebviewController *web = [[XXGP_WebviewController alloc] init];
            web.titleStr = @"关于我们";
            web.type = 3;
            [self.navigationController pushViewController:web animated:YES];
        } else if (indexPath.row == 2) {
            if ([XXGP_LoginTool sharedInstance].isLogin) {
                MJWeakSelf
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退出当前账号吗？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [[XXGP_LoginTool sharedInstance] loginOut];
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

- (NSString *)getCacheSize{
    CGFloat imageCacheSize = ((CGFloat)[[SDImageCache sharedImageCache] totalDiskSize])/1024.0/1024.0;
    CGFloat localCacheSize = ((CGFloat)[HCRequestCache allRequestCacheSize])/1024.0/1024.0;
    return [NSString stringWithFormat:@"%.2fM",imageCacheSize + localCacheSize];
}

- (void)clearCache{
    [HCRequestCache removeAllRequestCache];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [[KNToast shareToast] initWithText:@"清空成功"];
    }];
}

- (void)goHome {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                        @[@"护眼模式"],
                        @[@"清空缓存",@"关于我们",@"退出账号"]
                    ];
    }
    return _dataArray;
}

@end

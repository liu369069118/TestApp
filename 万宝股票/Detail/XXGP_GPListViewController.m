
#import "XXGP_GPListViewController.h"

#import "XXGP_GPUTButton.h"
#import "XXGP_GPLineTableViewCell.h"
#import "XXGP_StockDetailViewController.h"
@interface XXGP_GPListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *XXGP_ContetListGroups;

@end
@implementation XXGP_GPListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = self.XXGP_NaviBackButton;

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
    [_contentListTable registerNib:[UINib nibWithNibName:@"XXGP_GPLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"XXGP_GPLineTableViewCell"];
    [self.view addSubview:_contentListTable];
    _contentListTable.translatesAutoresizingMaskIntoConstraints = YES;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;

    _XXGP_ContetListGroups = [NSMutableArray new];
    [_XXGP_ContetListGroups addObjectsFromArray:_stocks];
    [_contentListTable reloadData];
    
    XXGP_GPUTButton *hed = [[[NSBundle mainBundle] loadNibNamed:@"XXGP_GPUTButton" owner:nil options:nil] lastObject];
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
    return _XXGP_ContetListGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"XXGP_GPLineTableViewCell";

    XXGP_GPLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if ([self.title containsString:@"跌"]) {
        cell.acd = 1;
    } else if ([self.title containsString:@"涨"]) {
        cell.acd = 0;
    } else {
        cell.acd = 2;
    }

    [cell updateListCellDataWithDict:_XXGP_ContetListGroups[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.XXGP_ContetListGroups objectAtIndex:indexPath.row];
    XXGP_StockDetailViewController *vc = [XXGP_StockDetailViewController new];
    vc.gpcode = dict[@"code"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

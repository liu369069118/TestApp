
#import "XXGP_QuotationController.h"
#import "XXGP_QuotationFirstCell.h"
#import "XXGP_QuotationSecondCell.h"
#import "XXGP_QuotationThirdCell.h"
#import "XXGP_SearchListController.h"

@interface XXGP_QuotationController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation XXGP_QuotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [HCColor whiteColor];
    tableView.backgroundView = [UIView new];
    tableView.backgroundView.opaque = NO;
    tableView.backgroundView.backgroundColor = [HCColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.decelerationRate = 10;
    [tableView registerClass:[XXGP_QuotationFirstCell class] forCellReuseIdentifier:@"XXGP_QuotationFirstCell"];
    [tableView registerClass:[XXGP_QuotationSecondCell class] forCellReuseIdentifier:@"XXGP_QuotationSecondCell"];
    [tableView registerClass:[XXGP_QuotationThirdCell class] forCellReuseIdentifier:@"XXGP_QuotationThirdCell"];
    
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(0);
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
        return 90;
    } else if (indexPath.row == 1) {
        return 40 + 422;
    } else {
        return 65 * 90 + 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        XXGP_QuotationSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XXGP_QuotationSecondCell" forIndexPath:indexPath];
               return cell;
    } else if (indexPath.row == 1){
       XXGP_QuotationFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XXGP_QuotationFirstCell" forIndexPath:indexPath];
       return cell;
    } else {
        XXGP_QuotationThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XXGP_QuotationThirdCell" forIndexPath:indexPath];
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
    XXGP_SearchListController *vc = [[XXGP_SearchListController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

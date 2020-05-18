

#import "XXGP_HomeController.h"
#import "XXGP_NewsCell.h"
#import "XXGP_NewsModel.h"
#import "XXGP_NewsLayout.h"
#import "HCBaseFetcher.h"
#import "XXGP_WebController.h"
#import "XXGP_HomeNewNewsModel.h"
#import "XXGP_HomeNewNewsCell.h"
#import <YYModel/YYModel.h>

@interface XXGP_HomeController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, assign) NSInteger pageRefer;

@end

@implementation XXGP_HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _articleList = [NSMutableArray arrayWithCapacity:1];
    _pageRefer = 1;
    
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
    [tableView registerClass:[XXGP_HomeNewNewsCell class] forCellReuseIdentifier:@"XXGP_HomeNewNewsCell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    [self addRefresh];
}

- (void)addRefresh {
    @WeakObj(self);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.pageRefer = 1;
        [selfWeak loadArticleListData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (selfWeak.pageRefer == 2) {
            [selfWeak loadArticleListData2];
        } else if (selfWeak.pageRefer == 3) {
            [selfWeak loadArticleListData3];
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[KNToast shareToast] initWithText:@"没有更多数据了~"];
                [selfWeak.tableView.mj_header endRefreshing];
                [selfWeak.tableView.mj_footer endRefreshing];
            });
        }
    }];
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
}

/// >>> 文章
- (void)loadArticleListData {
    [self loadCommunityTopicData];
    [_articleList removeAllObjects];
    
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"home"];
    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        XXGP_HomeNewNewsModel *model = [XXGP_HomeNewNewsModel yy_modelWithDictionary:tempDict];
        
        if (model) {
            [_articleList addObject:model];
        }
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 2;
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

- (void)loadArticleListData2 {
    [self loadCommunityTopicData];
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"home2"];
    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        XXGP_HomeNewNewsModel *model = [XXGP_HomeNewNewsModel yy_modelWithDictionary:tempDict];
        
        if (model) {
            [_articleList addObject:model];
        }
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 3;
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

- (void)loadArticleListData3 {
    [self loadCommunityTopicData];
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"home3"];
    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        XXGP_HomeNewNewsModel *model = [XXGP_HomeNewNewsModel yy_modelWithDictionary:tempDict];
        
        if (model) {
            [_articleList addObject:model];
        }
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 4;
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{

NSError *parseError = nil;

NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}



- (void)loadCommunityTopicData {
    HCBaseFetcher *fetcher = [[HCBaseFetcher alloc] init];
    fetcher.requestURL = @"/v1/Article/Info/recommend_list";
    fetcher.requestMethod = HCRequestMethodGet;
    fetcher.requestPolicy = HCRequestPolicyNoCache;
    
    fetcher.parameters = @{@"page_refer":@(_pageRefer)};
    
    
    [fetcher requestWithSuccess:^(id responseObject) {

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


#pragma mark - UITableViewDelegate && UITAbleViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XXGP_HomeNewNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XXGP_HomeNewNewsCell" forIndexPath:indexPath];
    cell.model = _articleList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XXGP_HomeNewNewsModel *model = _articleList[indexPath.row];
    
    XXGP_WebController *webVC = [[XXGP_WebController alloc] init];
    webVC.url = model.url;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end


#import "XXGP_CommunityController.h"
#import "XXGP_CommunityCell.h"
#import "XXGP_CommunityModel.h"
#import "XXGP_CommunityLayout.h"
#import "HCBaseFetcher.h"
#import "XXGP_ReleaPageViewController.h"
#import <YYModel/YYModel.h>
#import "XXGP_NewCommunityCell.h"
#import "XXGP_newCommunityModel.h"

static CGFloat const loadDataTime = 0.1;

@interface XXGP_CommunityController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleList;

@property (nonatomic, assign) NSInteger pageRefer;
@property (nonatomic, copy) NSString *topicTime;

@end

@implementation XXGP_CommunityController

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
    [tableView registerClass:[XXGP_NewCommunityCell class] forCellReuseIdentifier:@"XXGP_NewCommunityCell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(0);
    }];
    
    [self addRefresh];
}

- (void)addRefresh {
    @WeakObj(self);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.pageRefer = 1;
        selfWeak.topicTime = @"";
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
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"community"];
    [_articleList removeAllObjects];

    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        XXGP_newCommunityModel *model = [XXGP_newCommunityModel yy_modelWithDictionary:tempDict];
        
        if (model) {
            [_articleList addObject:model];
        }
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(loadDataTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 2;
        selfWeak.topicTime = @"";
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

/// >>> 文章
- (void)loadArticleListData2 {
    [self loadCommunityTopicData];
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"community2"];

    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        XXGP_newCommunityModel *model = [XXGP_newCommunityModel yy_modelWithDictionary:tempDict];
        
        if (model) {
            [_articleList addObject:model];
        }
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(loadDataTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 3;
        selfWeak.topicTime = @"";
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

/// >>> 文章
- (void)loadArticleListData3 {
    [self loadCommunityTopicData];
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"community3"];

    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        XXGP_newCommunityModel *model = [XXGP_newCommunityModel yy_modelWithDictionary:tempDict];
        
        if (model) {
            [_articleList addObject:model];
        }
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(loadDataTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 4;
        selfWeak.topicTime = @"";
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

- (void)loadCommunityTopicData {
    HCBaseFetcher *fetcher = [[HCBaseFetcher alloc] init];
    fetcher.requestURL = @"v1/Community/Comment/subject_list";
    fetcher.requestMethod = HCRequestMethodGet;
    fetcher.requestPolicy = HCRequestPolicyNoCache;
    
    fetcher.parameters = @{@"page_refer":@(_pageRefer), @"time":NotNullString(_topicTime)};
    
    
    [fetcher requestWithSuccess:^(id responseObject) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{

NSError *parseError = nil;

NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

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
    XXGP_newCommunityModel *model = _articleList[indexPath.row];
    return [XXGP_NewCommunityCell communityCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXGP_NewCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XXGP_NewCommunityCell" forIndexPath:indexPath];
    cell.model = _articleList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)cummunityCellAction:(XXGP_CommunityCell *)mainCell {
    XXGP_ReleaPageViewController *webVC = [[XXGP_ReleaPageViewController alloc] init];
    webVC.naviTitle = @"评论";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)commentClickForCummunityCell:(nonnull XXGP_CommunityCell *)mainCell {
    XXGP_ReleaPageViewController *webVC = [[XXGP_ReleaPageViewController alloc] init];
    webVC.naviTitle = @"评论";
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)likeClickForCummunityCell:(nonnull XXGP_CommunityCell *)mainCell {
    
}


@end

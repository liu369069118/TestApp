//
//  WBCommunityController.m
//  万宝股票
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import "WBCommunityController.h"
#import "WBCommunityCell.h"
#import "WBCommunityModel.h"
#import "WBCommunityLayout.h"
#import "HCBaseFetcher.h"
#import "SXHGTYReleaPageViewController.h"

@interface WBCommunityController () <UITableViewDelegate, UITableViewDataSource, WBCommunityCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleList;

@property (nonatomic, assign) NSInteger pageRefer;
@property (nonatomic, copy) NSString *topicTime;

@end

@implementation WBCommunityController

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
    [tableView registerClass:[WBCommunityCell class] forCellReuseIdentifier:@"WBCommunityCell"];
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
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"community"];
    [_articleList removeAllObjects];

    NSArray *newsDicts = [[homeDict getObject:@"data"] getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        WBCommunityModel *model = [WBCommunityModel createCommunityModelWithDict:tempDict];
        WBCommunityLayout *layout = [[WBCommunityLayout alloc] initWithTopicModel:model];
        
        [_articleList addObject:layout];
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 2;
        selfWeak.topicTime = @"";
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

/// >>> 文章
- (void)loadArticleListData2 {
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"community2"];

    NSArray *newsDicts = [[homeDict getObject:@"data"] getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        WBCommunityModel *model = [WBCommunityModel createCommunityModelWithDict:tempDict];
        WBCommunityLayout *layout = [[WBCommunityLayout alloc] initWithTopicModel:model];
        
        [_articleList addObject:layout];
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.pageRefer = 3;
        selfWeak.topicTime = @"";
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    });
}

/// >>> 文章
- (void)loadArticleListData3 {
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"community3"];

    NSArray *newsDicts = [[homeDict getObject:@"data"] getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        WBCommunityModel *model = [WBCommunityModel createCommunityModelWithDict:tempDict];
        WBCommunityLayout *layout = [[WBCommunityLayout alloc] initWithTopicModel:model];
        
        [_articleList addObject:layout];
    }
    
    @WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    
    @WeakObj(self);
    [fetcher requestWithSuccess:^(id responseObject) {
//        NSString *string = [self dictionaryToJson:responseObject];
        if ([[responseObject getNotNilString:@"code"] isEqualToString:@"1"]) {
            NSDictionary *data = [responseObject getObject:@"data"];
            
            if (selfWeak.pageRefer == 1) {
                [selfWeak.articleList removeAllObjects];
            }
            
            selfWeak.topicTime = [data getNotNilString:@"time"];
            selfWeak.pageRefer = [[data getNumber:@"page_refer"] integerValue];
            
            NSArray *listArray = [data getArray:@"list"];
            
            NSMutableArray *tempTopicArray = [NSMutableArray arrayWithCapacity:listArray.count];
            for (NSDictionary *dict in listArray) {
                WBCommunityModel *model = [WBCommunityModel createCommunityModelWithDict:dict];
                WBCommunityLayout *layout = [[WBCommunityLayout alloc] initWithTopicModel:model];
                
                [tempTopicArray addObject:layout];
            }
            
            [selfWeak.articleList addObjectsFromArray:tempTopicArray];
        }
        
        [selfWeak.tableView reloadData];
        
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
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
    WBCommunityLayout *newLayout = _articleList[indexPath.row];
    return newLayout.communityCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WBCommunityLayout *layout = _articleList[indexPath.row];
    WBCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBCommunityCell" forIndexPath:indexPath];
    cell.layout = layout;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)cummunityCellAction:(WBCommunityCell *)mainCell {
    SXHGTYReleaPageViewController *webVC = [[SXHGTYReleaPageViewController alloc] init];
    webVC.naviTitle = @"评论";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)commentClickForCummunityCell:(nonnull WBCommunityCell *)mainCell {
    SXHGTYReleaPageViewController *webVC = [[SXHGTYReleaPageViewController alloc] init];
    webVC.naviTitle = @"评论";
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)likeClickForCummunityCell:(nonnull WBCommunityCell *)mainCell {
    
}

@end

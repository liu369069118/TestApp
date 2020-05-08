//
//  WBCommunityController.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBCommunityController.h"
#import "WBCommunityCell.h"
#import "WBCommunityModel.h"
#import "WBCommunityLayout.h"
#import "HCBaseFetcher.h"
#import "WBWebController.h"

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
    self.navigationController.navigationBar.hidden = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"社区";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    
    UIView *titleView = [[UIView alloc] init];
    [titleView addSubview:label];
    [self.view addSubview:titleView];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
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
    [tableView registerClass:[WBCommunityCell class] forCellReuseIdentifier:@"WBCommunityCell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHCNavigationBarHeight);
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self addRefresh];
}

- (void)addRefresh {
    @WeakObj(self);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.pageRefer = 1;
        selfWeak.topicTime = @"";
        [selfWeak loadCommunityTopicData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    _tableView.mj_header = header;
    //立即输入刷新状态
    [_tableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [selfWeak loadCommunityTopicData];
    }];
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
}

- (void)loadCommunityTopicData {
    HCBaseFetcher *fetcher = [[HCBaseFetcher alloc] init];
    fetcher.requestURL = @"v1/Community/Comment/subject_list";
    fetcher.requestMethod = HCRequestMethodGet;
    fetcher.requestPolicy = HCRequestPolicyNoCache;
    
    fetcher.parameters = @{@"page_refer":@(_pageRefer), @"time":NotNullString(_topicTime)};
    
    @WeakObj(self);
    [fetcher requestWithSuccess:^(id responseObject) {
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
    WBWebController *webVC = [[WBWebController alloc] init];
    webVC.url = mainCell.layout.topicModel.h5_url;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end

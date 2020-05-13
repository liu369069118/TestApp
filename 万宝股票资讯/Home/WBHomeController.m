//
//  WBHomeController.m
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import "WBHomeController.h"
#import "WBNewsCell.h"
#import "WBNewsModel.h"
#import "WBNewsLayout.h"
#import "HCBaseFetcher.h"
#import "WBWebController.h"

@interface WBHomeController () <UITableViewDelegate, UITableViewDataSource, WBNewsCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, assign) NSInteger pageRefer;

@end

@implementation WBHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _articleList = [NSMutableArray arrayWithCapacity:1];
    _pageRefer = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"资讯";
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
    [tableView registerClass:[WBNewsCell class] forCellReuseIdentifier:@"WBNewsCell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHCNavigationBarHeight);
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self addRefresh];
}

/// >>> 文章
- (void)loadArticleListData {
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"home"];
    [_articleList removeAllObjects];

    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        NSInteger cardType = [[tempDict getNotNilString:@"card"] integerValue];
        if (cardType == 1 || cardType == 2) {
            WBNewsModel *model = [WBNewsModel newsItemWithDict:tempDict];
            WBNewsLayout *layout = [[WBNewsLayout alloc] initWithNews:model];
            [_articleList addObject:layout];
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
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"home2"];
    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        NSInteger cardType = [[tempDict getNotNilString:@"card"] integerValue];
        if (cardType == 1 || cardType == 2) {
            WBNewsModel *model = [WBNewsModel newsItemWithDict:tempDict];
            WBNewsLayout *layout = [[WBNewsLayout alloc] initWithNews:model];
            [_articleList addObject:layout];
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
    NSDictionary *homeDict = [WBUitl readLocalFileWithName:@"home3"];
    NSArray *newsDicts = [homeDict getArray:@"list"];

    for (NSDictionary *tempDict in newsDicts) {
        NSInteger cardType = [[tempDict getNotNilString:@"card"] integerValue];
        if (cardType == 1 || cardType == 2) {
            WBNewsModel *model = [WBNewsModel newsItemWithDict:tempDict];
            WBNewsLayout *layout = [[WBNewsLayout alloc] initWithNews:model];
            [_articleList addObject:layout];
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

- (void)loadCommunityTopicData {
    HCBaseFetcher *fetcher = [[HCBaseFetcher alloc] init];
    fetcher.requestURL = @"/v1/Article/Info/recommend_list";
    fetcher.requestMethod = HCRequestMethodGet;
    fetcher.requestPolicy = HCRequestPolicyNoCache;
    
    fetcher.parameters = @{@"page_refer":@(_pageRefer)};
    
    @WeakObj(self);
    [fetcher requestWithSuccess:^(id responseObject) {
//        NSString *string = [self dictionaryToJson:responseObject];
        
        NSDictionary *dataDict = [responseObject getObject:@"data"];
        
        if (selfWeak.pageRefer == 1) {
            [selfWeak.articleList removeAllObjects];
        }
        selfWeak.pageRefer = [[dataDict getNotNilString:@"page_refer"] integerValue];
        
        NSArray *newsDicts = [dataDict getArray:@"list"];
        
        for (NSDictionary *tempDict in newsDicts) {
            NSInteger cardType = [[tempDict getNotNilString:@"card"] integerValue];
            if (cardType == 1 || cardType == 2) {
                WBNewsModel *model = [WBNewsModel newsItemWithDict:tempDict];
                WBNewsLayout *layout = [[WBNewsLayout alloc] initWithNews:model];
                [selfWeak.articleList addObject:layout];
            }
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
    WBNewsLayout *newLayout = _articleList[indexPath.row];
    return newLayout.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WBNewsLayout *layout = _articleList[indexPath.row];
    WBNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBNewsCell" forIndexPath:indexPath];
    cell.layout = layout;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)newsCellDidSelect:(WBNewsCell *)newsCell {
    WBWebController *webVC = [[WBWebController alloc] init];
    webVC.url = newsCell.layout.news.detailUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end

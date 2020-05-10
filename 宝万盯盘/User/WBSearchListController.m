//
//  WBSearchListController.m
//  宝万盯盘
//
//  Created by 刘涛 on 2020/5/10.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBSearchListController.h"
#import "JKRSearchController.h"
#import "JKRSearchResultViewController.h"

#define kSafeAreaNavHeight (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO) ? 88 : 64)


@interface WBSearchListController ()<UITableViewDataSource, UITableViewDelegate, JKRSearchControllerhResultsUpdating, JKRSearchControllerDelegate, JKRSearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JKRSearchController *searchController;
@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation WBSearchListController

static NSString *const CellIdentifier = @"WEICHAT_ID";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"信息检索"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navigation_back_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    self.jkr_lightStatusBar = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Home click index: %zd", indexPath.row);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height) {
        if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height * 0.5) {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight + self.searchController.searchBar.height) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat y = scrollView.contentOffset.y;
    if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height) {
        if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height * 0.5) {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight + self.searchController.searchBar.height) animated:YES];
        }
    }
}

#pragma mark - JKRSearchControllerhResultsUpdating
- (void)updateSearchResultsForSearchController:(JKRSearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchText];
    JKRSearchResultViewController *resultController = (JKRSearchResultViewController *)searchController.searchResultsController;
    if (!(searchText.length > 0)) resultController.filterDataArray = @[];
    else resultController.filterDataArray = [self.dataArray filteredArrayUsingPredicate:predicate];
}

#pragma mark - JKRSearchControllerDelegate
- (void)willPresentSearchController:(JKRSearchController *)searchController {
    NSLog(@"willPresentSearchController, %@", searchController);
}

- (void)didPresentSearchController:(JKRSearchController *)searchController {
    NSLog(@"didPresentSearchController, %@", searchController);
}

- (void)willDismissSearchController:(JKRSearchController *)searchController {
    NSLog(@"willDismissSearchController, %@", searchController);
}

- (void)didDismissSearchController:(JKRSearchController *)searchController {
    NSLog(@"didDismissSearchController, %@", searchController);
}

#pragma mark - JKRSearchBarDelegate
- (void)searchBarTextDidBeginEditing:(JKRSearchBar *)searchBar {
    NSLog(@"searchBarTextDidBeginEditing %@", searchBar);
}

- (void)searchBarTextDidEndEditing:(JKRSearchBar *)searchBar {
    NSLog(@"searchBarTextDidEndEditing %@", searchBar);
}

- (void)searchBar:(JKRSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchBar:%@ textDidChange:%@", searchBar, searchText);
}


- (void)goback {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

- (JKRSearchController *)searchController {
    if (!_searchController) {
        JKRSearchResultViewController *resultSearchController = [[JKRSearchResultViewController alloc] init];
        _searchController = [[JKRSearchController alloc] initWithSearchResultsController:resultSearchController];
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        _searchController.delegate = self;
    }
    return _searchController;
}

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"aaa",@"bbb",@"aaa",@"bbb",@"aaa",@"bbb",@"aaa",@"bbb",@"aaa",@"bbb",@"aaa",@"bbb"];
    }
    return _dataArray;
}

- (void)dealloc {
    NSLog(@"Controller dealloc");
}

@end

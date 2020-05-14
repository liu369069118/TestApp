//
//  MYGPListViewController.h
//  YFGP
//
//  Created by tomsom on 2019/5/26.
//  Copyright © 2019 Zhang yuanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHGTYGPListViewController : UIViewController
@property(nonatomic, strong) NSMutableArray *stocks;
@property (strong, nonatomic) UITableView *contentListTable;
@property (assign, nonatomic) BOOL isSeg;
@property (assign, nonatomic) BOOL canScroll;
@property(nonatomic, strong) NSString *gpcode;

@end

NS_ASSUME_NONNULL_END

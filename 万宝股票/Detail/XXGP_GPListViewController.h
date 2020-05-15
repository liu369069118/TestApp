
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_GPListViewController : UIViewController
@property(nonatomic, strong) NSMutableArray *stocks;
@property (strong, nonatomic) UITableView *contentListTable;
@property (assign, nonatomic) BOOL isSeg;
@property (assign, nonatomic) BOOL canScroll;
@property(nonatomic, strong) NSString *gpcode;

@end

NS_ASSUME_NONNULL_END

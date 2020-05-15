
#import <UIKit/UIKit.h>
@class JQFMDB;

@interface XXGP_EditOptionalViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *XXGP_ContetListGroups;
@property (nonatomic, strong) JQFMDB *db;
@property (nonatomic, copy) NSString *listTableName;
@property (nonatomic, copy) NSString *laoda;

@end


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_GPLineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *per;
@property (weak, nonatomic) IBOutlet UILabel *gplprice;

@property(nonatomic, assign) int  acd;

-(void)updateListCellDataWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END

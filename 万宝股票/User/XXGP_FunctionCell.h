
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_FunctionCell : UITableViewCell

@property(nonatomic, copy) NSString *contentStr;

+ (NSString *)indentifier;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END

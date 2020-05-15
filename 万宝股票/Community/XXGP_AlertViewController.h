

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    XXGP_AlertViewSourceTypeReleas,
    XXGP_AlertViewSourceTypeJub
}XXGP_AlertViewSourceType;

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_AlertViewController : UIAlertController
@property(nonatomic,assign)XXGP_AlertViewSourceType source;
@end

NS_ASSUME_NONNULL_END

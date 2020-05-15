
#import <UIKit/UIKit.h>
#import "XXGP_OPtiondicorationMarketModel.h"
@interface XXGP_OPtiondicorationEditCell : UITableViewCell

@property (nonatomic, strong) XXGP_OPtiondicorationMarketModel * model;

//回调参数是自己的原因，便于外接获取对应cell的下标
@property (nonatomic, copy) void(^buttonClickBlock)(XXGP_OPtiondicorationEditCell *cell);//置顶按钮的事件回调

@end

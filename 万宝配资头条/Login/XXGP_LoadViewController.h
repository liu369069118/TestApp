

#import <UIKit/UIKit.h>

typedef void(^loadStatusBlook)(void);

@interface XXGP_LoadViewController : UIViewController

@property(copy,nonatomic)loadStatusBlook loadStatus;  //登录成功回调

@end

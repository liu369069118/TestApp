
#import <UIKit/UIKit.h>

@interface XXGP_Registration : UIView

@property(strong,nonatomic)UITextField *username;

@property(strong,nonatomic)UITextField *useremail;

@property(strong,nonatomic)UITextField *usersec;

@property(strong,nonatomic)UITextField *usersecs;

@property(strong,nonatomic)UIButton *regis_sure;

@property(strong,nonatomic)UIButton *jumpload;

@property(strong,nonatomic)UIButton *backbtn;

- (instancetype)initWithFrame:(CGRect)frame WithDelegate:(id)delegate;

@end

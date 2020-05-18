
#import "XXGP_GPUTButton.h"

@interface XXGP_GPUTButton ()
@property (weak, nonatomic) IBOutlet UIButton *left;
@property (weak, nonatomic) IBOutlet UIButton *middle;
@property (weak, nonatomic) IBOutlet UIButton *right;

@end

@implementation XXGP_GPUTButton
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.orientation = MyOrientation_Horz;
        
        for (UIView *scontentView in self.subviews) {
            scontentView.width = kScreenWidth/3;
            scontentView.myTop = 8;
        }
    }
    return self;
}

- (void)awakeFromNib {
    [_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(62);
        make.centerY.mas_equalTo(0);
    }];
    [_middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-32);
    }];
}

@end


#import "XXGP_GPUTButton.h"

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

@end

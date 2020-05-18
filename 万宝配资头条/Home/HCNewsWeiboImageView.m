
#import "HCNewsWeiboImageView.h"
#import "KNPhotoBrower.h"

@implementation HCNewsWeiboImageView

#pragma mark -
#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    self.backgroundColor = [UIColor grayColor];
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.6f;
    self.layer.borderColor = [HCColor colorWithHexString:@"#DFE0E5"].CGColor;
}

- (void)showClickPictureImageView:(UIImageView *)pictureImageView {
    KNPhotoBrower *photoBrower = [[KNPhotoBrower alloc] init];
    photoBrower.itemsArr = [_pictureViews copy];
    photoBrower.currentIndex = pictureImageView.tag;
    
    [photoBrower setIsUseCustomActionSheet:YES];    // 是否 自定义 actionsheet
    [photoBrower setIsNeedPictureLongPress:YES]; // 是否 需要 长按图片 弹出框功能 .默认:需要
    [photoBrower setIsNeedRightTopBtn:NO]; // 是否需要 右上角 操作功能按钮
    [photoBrower present];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showClickPictureImageView:self];
}

@end

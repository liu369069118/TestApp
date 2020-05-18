
#import "XXGP_CommunityButton.h"

@interface XXGP_CommunityButton ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation XXGP_CommunityButton

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    
    _titleLabel.text = _titleText;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    _titleLabel.font = _titleFont;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    
    _titleLabel.textColor = titleTextColor;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    _imageView.image = [UIImage imageNamed:_imageName];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    _imageView.image = image;
}

- (void)setTapInsetWidth:(CGFloat)tapInsetWidth {
    _tapInsetWidth = tapInsetWidth;
    
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0).offset(tapInsetWidth);
    }];
    @WeakObj(self);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(selfWeak.titleLabel.mas_right).offset(tapInsetWidth);
    }];
}

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
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    _imageView = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(4);
        make.centerY.mas_equalTo(0);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(titleLabel.mas_right);
    }];
}

@end

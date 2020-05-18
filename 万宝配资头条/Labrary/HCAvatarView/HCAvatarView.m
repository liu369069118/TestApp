
#import "HCAvatarView.h"
#import "UIImageView+WebCache.h"
#import "UIView+PBExtesion.h"

static NSString * const HCAvatarLargeComponent = @"x-oss-process=image/resize,w_135,h_135,limit_1,m_fill";
static NSString * const HCAvatarMediumComponent = @"x-oss-process=image/resize,w_120,h_120,limit_1,m_fill";
static NSString * const HCAvatarSmallComponent = @"x-oss-process=image/resize,w_66,h_66,limit_1,m_fill";
static NSDictionary<NSNumber *,NSString *> *HCAvatarURLComponents = nil;
static NSDictionary<NSNumber *,NSNumber *> *HCAvatarVipImageSize = nil;
static NSDictionary<NSNumber *,NSNumber *> *HCAvatarVipImageCornerRadius = nil;

@interface HCAvatarView ()

@property (strong,nonatomic) UIImageView *vipImageView;
@property (copy,nonatomic) NSString *avatarURL;
@property (assign,nonatomic) HCVipType userType;
@property (assign,nonatomic) HCAvatarSize avatarSize;
@property (strong,nonatomic) XXGP_UserModel *userModel;

@end

@implementation HCAvatarView

+ (void)load{
    HCAvatarURLComponents = @{
                              @(HCAvatarSizeSmall):HCAvatarSmallComponent,
                              @(HCAvatarSizeMedium):HCAvatarMediumComponent,
                              @(HCAvatarSizeLarge):HCAvatarLargeComponent,
                              };
    
    HCAvatarVipImageSize = @{
                             @(HCAvatarSizeSmall):@(8),
                             @(HCAvatarSizeMedium):@(14),
                             @(HCAvatarSizeLarge):@(16),
                             };
    
    HCAvatarVipImageCornerRadius = @{
                             @(HCAvatarSizeSmall):@(8),
                             @(HCAvatarSizeMedium):@(12),
                             @(HCAvatarSizeLarge):@(16),
                             };
}

- (void)setAvatarCornerRadius:(CGFloat)avatarCornerRadius{
    _avatarCornerRadius = avatarCornerRadius;
    
    self.avatarImageView.layer.cornerRadius = avatarCornerRadius;
}

- (void)setAvatarImage:(UIImage *)image userType:(HCVipType)userType size:(HCAvatarSize)size{
    if (!image) {
        image = [UIImage imageNamed:@"img_default_avatar_n"];
    }
    
    self.userType = userType;
    self.avatarSize = size;
    
    self.avatarImageView.image = image;
    
    self.vipImageView.hidden = !userType;
    self.vipImageView.image = [HCAvatarView vipLogoWithVipType:userType];
    
    if ((size == HCAvatarSizeMedium || size == HCAvatarSizeLarge) && !self.noBorder) {
        self.avatarImageView.layer.borderColor = (userType == HCVipPayAnalyst) ? HCColor(232, 177, 85).CGColor : [HCColor grayColor:232].CGColor;
        self.avatarImageView.layer.borderWidth = (userType == HCVipPayAnalyst) ? 1 : 0.5;
    }
    
    [self.vipImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(0);
        make.bottom.right.mas_equalTo(0);
        make.width.height.mas_equalTo(HCAvatarVipImageSize[@(size)]);
    }];
}

- (void)setAvatarURL:(NSString *)url userType:(HCVipType)userType size:(HCAvatarSize)size{
    self.avatarURL = url;
    self.userType = userType;
    self.avatarSize = size;
    
    if (url.length > 0 &&
        ![url containsString:@"x-oss-process=image/resize"] &&
        HCAvatarURLComponents[@(size)]) {
        NSString *join = [url containsString:@"?"] ? @"&" : @"?";
        url = [url stringByAppendingFormat:@"%@%@",join,HCAvatarURLComponents[@(size)]];
    }
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"img_default_avatar_n"]];
    self.vipImageView.hidden = !self.userType;
    self.vipImageView.image = [HCAvatarView vipLogoWithVipType:userType];
    
    if ((size == HCAvatarSizeMedium || size == HCAvatarSizeLarge) && !self.noBorder) {
        self.avatarImageView.layer.borderColor = (userType == HCVipPayAnalyst) ? HCColor(232, 177, 85).CGColor : [HCColor grayColor:232].CGColor;
        self.avatarImageView.layer.borderWidth = (userType == HCVipPayAnalyst) ? 1 : 0.5;
    }
    
    [self.vipImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.width.height.mas_equalTo(HCAvatarVipImageSize[@(size)]);
    }];
}

- (void)setAvatarWithUserModel:(XXGP_UserModel *)userModel size:(HCAvatarSize)size{
    self.userModel = userModel;
    [self setAvatarURL:userModel.user_avatar userType:userModel.type size:size];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.avatarCornerRadius) {
        self.avatarImageView.layer.cornerRadius = self.avatarCornerRadius;
    } else {
        self.avatarImageView.layer.cornerRadius = HCAvatarVipImageCornerRadius[@(self.avatarSize)].floatValue;
    }
    
    self.vipImageView.layer.cornerRadius = self.vipImageView.height * .5;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self hc_setupUI];
    }
    return self;
}

- (void)hc_setupUI{
    self.avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.avatarImageView.layer.borderWidth = 0.5;
    self.avatarImageView.layer.borderColor = [HCColor grayColor:232].CGColor;
    [self addSubview:self.avatarImageView];
    self.avatarImageView.layer.masksToBounds = true;
    
    self.vipImageView = [UIImageView new];
    self.vipImageView.layer.masksToBounds = true;
    [self addSubview:self.vipImageView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
        make.top.left.mas_equalTo(0);
    }];
    
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.width.height.mas_equalTo(16);
    }];
}

+ (UIImage *)vipLogoWithVipType:(HCVipType)type{
    switch (type) {
        case HCVipNone:
            return [UIImage new];
        case HCVipNormal:
            return [UIImage imageNamed:@"hold_vip_icon_n"];
        case HCVipPayAnalyst:
            return [UIImage imageNamed:@"pay_analyst_logo"];
        default:
            return [UIImage new];
    }
}

#pragma mark - getter
- (XXGP_UserModel *)currentUser{
    return self.userModel;
}

@end

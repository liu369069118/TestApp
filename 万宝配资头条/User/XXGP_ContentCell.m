
#import "XXGP_ContentCell.h"

@interface XXGP_ContentCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowIcon;

@end

@implementation XXGP_ContentCell

+ (NSString *)indentifier {
    return @"XXGP_ContentCellKey";
}

+ (CGFloat)cellHeight {
    return 44.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupLayoutCell];
    }
    return self;
}

- (void)setupLayoutCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.textColor = [HCColor colorWithHexString:@"333333"];
    [self.contentView addSubview:_contentLabel];
    
    _arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"push_setting_arrow"]];
    [self.contentView addSubview:_arrowIcon];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(16);
    }];
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-16);
    }];
}

- (void)setContentStr:(NSString *)contentStr {
    _contentStr = contentStr;
    _contentLabel.text = contentStr;
}

@end

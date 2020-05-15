
#import "XXGP_FooterView.h"

@implementation XXGP_FooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *content = [[UILabel alloc] init];
        content.textColor = [HCColor colorWithHexString:@"666666"];
        content.font  = [UIFont systemFontOfSize:12];
        content.text = @"市场有风险，投资需谨慎.";
        [self addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
    }
    return self;
}

@end

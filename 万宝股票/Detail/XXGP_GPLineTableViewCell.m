
#import "XXGP_GPLineTableViewCell.h"

@implementation XXGP_GPLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _per.layer.cornerRadius = 4.;
    _per.layer.masksToBounds = YES;
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.cornerRadius = 20;
    backView.layer.borderColor = HCColor(255, 69, 0).CGColor;
    backView.layer.borderWidth = 0.5;
    [self.contentView insertSubview:backView atIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateListCellDataWithDict:(NSDictionary *)dict {

    _name.text = dict[@"XXGP_sname"];
    _code.text = dict[@"code"];
    _per.text = dict[@"gpperate"];
    _gplprice.text = dict[@"per"];

    if (_acd == 1) {
        _per.textColor = [HCColor greenColor];
    } else if (_acd == 0) {
        _per.textColor = [HCColor redColor];

    } else if (_acd == 2) {
        NSUInteger r = arc4random_uniform(99) + 1;
        if (r % 2) {
            _per.textColor = [HCColor greenColor];
            
        } else {
            _per.textColor = [HCColor redColor];
        }
    }
    
}

@end

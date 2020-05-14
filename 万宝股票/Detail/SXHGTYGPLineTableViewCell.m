//
//  SXHGTYGPLineTableViewCell.m
//  YFGP
//
//  Created by tomsom on 2019/5/26.
//  Copyright © 2019 Zhang yuanhong. All rights reserved.
//

#import "SXHGTYGPLineTableViewCell.h"

@implementation SXHGTYGPLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _per.layer.cornerRadius = 4.;
    _per.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateListCellDataWithDict:(NSDictionary *)dict {

    _name.text = dict[@"SXHG_sname"];
    _code.text = dict[@"code"];
    _per.text = dict[@"gpperate"];
    _gplprice.text = dict[@"per"];

    if (_acd == 1) {
        _per.backgroundColor = [HCColor colorWithHexString:@"278d3b"];
    } else if (_acd == 0) {
        _per.backgroundColor = [HCColor colorWithHexString:@"d43d3d"];

    } else if (_acd == 2) {
        NSUInteger r = arc4random_uniform(99) + 1;
        if (r % 2) {
            _per.backgroundColor = [HCColor colorWithHexString:@"278d3b"];
            
        } else {
            _per.backgroundColor = [HCColor colorWithHexString:@"d43d3d"];
        }
    }
    
}

@end

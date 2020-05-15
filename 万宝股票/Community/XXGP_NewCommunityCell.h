//
//  XXGP_NewCommunityCell.h
//  万宝股票
//
//  Created by 辛峰 on 2020/5/15.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXGP_newCommunityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_NewCommunityCell : UITableViewCell

@property (nonatomic, strong) XXGP_newCommunityModel *model;

+ (CGFloat)communityCellHeight:(XXGP_newCommunityModel *)model;

@end

NS_ASSUME_NONNULL_END

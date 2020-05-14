//
//  WBContentCell.h
//  万宝股票
//
//  Created by 刘涛 on 2020/5/8.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBContentCell : UITableViewCell

@property(nonatomic, copy) NSString *contentStr;

+ (NSString *)indentifier;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END

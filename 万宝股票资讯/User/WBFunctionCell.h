//
//  WBFunctionCell.h
//  万宝股票资讯
//
//  Created by 刘涛 on 2020/5/9.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBFunctionCell : UITableViewCell

@property(nonatomic, copy) NSString *contentStr;

+ (NSString *)indentifier;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END

//
//  WBUserHeader.h
//  万宝股票
//
//  Created by 刘涛 on 2020/5/8.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBUserHeader : UIView

@property (nonatomic, copy) void(^kClickEventBlock)(void);

- (void)updateUI;

@end

NS_ASSUME_NONNULL_END

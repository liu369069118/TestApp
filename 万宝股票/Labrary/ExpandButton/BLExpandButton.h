//
//  BLExpandButton.h
//  Camp
//
//  Created by Belle on 2017/4/11.
//  Copyright © 2017年 Beijing Fitcare inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLExpandButton : UIButton

/**
 *  定制新的点击响应范围，以bounds各边界为参照，正数指向外扩展，负数向内缩小，但对向缩小最大限度不超过bounds
 *  的size。默认rangeInsets值为0
 */
@property (nonatomic, assign) UIEdgeInsets rangeInsets;

@end

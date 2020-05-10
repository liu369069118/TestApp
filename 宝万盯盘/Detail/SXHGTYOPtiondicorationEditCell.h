//
//  SXHGTYOPtiondicorationEditCell.h
//  HGStockSXHGOPtiondicorationSort
//
//  Created by Arch on 2017/6/7.
//  Copyright © 2017年 sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHGTYOPtiondicorationMarketModel.h"
@interface SXHGTYOPtiondicorationEditCell : UITableViewCell

@property (nonatomic, strong) SXHGTYOPtiondicorationMarketModel * model;

//回调参数是自己的原因，便于外接获取对应cell的下标
@property (nonatomic, copy) void(^buttonClickBlock)(SXHGTYOPtiondicorationEditCell *cell);//置顶按钮的事件回调

@end

//
//  SXHGTYOPtiondicorationMarketModel.h
//  HGStockSXHGOPtiondicorationSort
//
//  Created by Arch on 2017/6/9.
//  Copyright © 2017年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXHGTYOPtiondicorationMarketModel : NSObject

@property (nonatomic, copy) NSNumber * Open;        //开盘价
@property (nonatomic, copy) NSNumber * LastClose;   //昨收
@property (nonatomic, copy) NSNumber * High;        //最高
@property (nonatomic, copy) NSNumber * Low;         //最低
@property (nonatomic, copy) NSNumber * AppointThan; //委比
@property (nonatomic, copy) NSNumber * Swing;       //振幅
@property (nonatomic, copy) NSString * Name;        //股票名称
@property (nonatomic, copy) NSString * Label;       //股票代码
@property (nonatomic, copy) NSNumber * Newgplprice;    //最新价
@property (nonatomic, copy) NSNumber * Gains;       //涨幅
@property (nonatomic, copy) NSNumber * RiseFall;    //涨跌
@property (nonatomic, copy) NSNumber * HigherSpeed; //涨速
@property (nonatomic, copy) NSNumber * Hand;        //总手
@property (nonatomic, copy) NSNumber * VolumeRatio; //量比


@end

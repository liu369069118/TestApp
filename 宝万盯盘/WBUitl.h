//
//  WBUitl.h
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/7.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBUitl : NSObject

+ (NSDictionary *)readLocalFileWithName:(NSString *)name;
+ (BOOL)isFullScreenIPhone;

+ (NSMutableArray *)mainDataList;

@end

NS_ASSUME_NONNULL_END

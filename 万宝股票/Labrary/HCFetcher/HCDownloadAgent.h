//
//  HCDownloadAgent.h
//  hotbody
//
//  Created by Belle on 2017/2/14.
//  Copyright © 2017年 Beijing Fitcare inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDownloadAgent : NSObject

/**
 *  工厂方法
 *
 *  @param urlString   需要下载文件的URL
 *  @param destination 文件存储路径
 *  @param progress    文件下载进度
 *  @param completion  文件下载完成
 *
 *  @return 实例对象
 */
+ (instancetype)downloadWithURLString:(NSString *)urlString destination:(NSString *)destination progress:(void (^) (CGFloat progress))progress completion:(void (^) (void))completion;

/**
 *  初始化方法
 *
 *  @param urlString   需要下载文件的URL
 *  @param destination 文件存储路径
 *  @param progress    文件下载进度
 *  @param completion  文件下载完成
 *
 *  @return 实例对象
 */
- (instancetype)initWithURLString:(NSString *)urlString destination:(NSString *)destination progress:(void (^) (CGFloat progress))progress completion:(void (^) (void))completion;

/**
 *  开始下载
 */
- (void)start;

/**
 *  暂停下载
 */
- (void)suspend;

@end

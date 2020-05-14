//
//  HCResponseModel.h
//  HoldCoin
//
//  Created by 宋恒 on 2018/8/3.
//  Copyright © 2018年 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCResponseModel : NSObject

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,copy) NSString *message;
@property (strong,nonatomic) NSDictionary *data;
@property (nonatomic,assign) CGFloat exec_time;
@property (nonatomic,copy) NSString *server;
@property (nonatomic,assign) NSTimeInterval server_time;
@property (nonatomic,assign) BOOL success;

@property (strong,nonatomic) NSArray<NSDictionary *> *list;
@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,assign) NSInteger page_refer;

@property (strong,nonatomic) NSError *error;
@property (strong,nonatomic) NSURLSessionTask *task;

+ (instancetype)responseModelWithError:(NSError *)error;

@end

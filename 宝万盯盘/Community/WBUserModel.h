//
//  WBUserModel.h
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    HCUserFollowStatusUnFollow = 0,
    HCUserFollowStatusFollow = 1,
} HCUserFollowStatus;

typedef enum : NSUInteger {
    ///  普通用户
    HCVipNone,
    ///  普通认证用户
    HCVipNormal,
    ///  付费分析师
    HCVipPayAnalyst = 6,
} HCVipType;

@interface WBUserModel : NSObject

@property (nonatomic,copy) NSString *user_avatar;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *introduce;
@property (nonatomic,copy) NSString *user_id;

///  是否为认证用户
@property (nonatomic,assign) HCVipType type;
///  认证身份内容
@property (nonatomic,copy) NSString *identity;
@property (nonatomic,assign) HCUserFollowStatus is_follow;

///  点赞数
@property (nonatomic,assign) NSInteger user_up_count;
///  粉丝数
@property (nonatomic,assign) NSInteger user_fans_count;
///  关注数
@property (nonatomic,assign) NSInteger user_follow_count;
///  文章被浏览数
@property (nonatomic,assign) NSInteger user_browse_count;

@property (nonatomic,assign) BOOL isAnalyst;

@end

NS_ASSUME_NONNULL_END

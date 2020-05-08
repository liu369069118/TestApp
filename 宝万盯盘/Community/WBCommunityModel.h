//
//  WBCommunityModel.h
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBCommunityImageModel : NSObject

@property (nonatomic, copy) NSString *suffix;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;

+ (WBCommunityImageModel *)createImageModelWithDict:(NSDictionary *)dict;
+ (NSArray *)createImageModelWithArray:(NSArray *)array;

@end

@interface WBCommunityTopicTagModel : NSObject

@property (nonatomic, copy) NSString *topic_tag_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descriptionString;
@property (nonatomic, copy) NSString *openUrl;

@property (nonatomic, assign) BOOL is_follow;

+ (WBCommunityTopicTagModel *)createTopicTagModelWithDict:(NSDictionary *)dict;

@end

@interface WBCommunityTopicShareModel : NSObject

@property (nonatomic, copy) NSString *title;                // 标题
@property (nonatomic, copy) NSString *url;                  // 地址
@property (nonatomic, copy) NSString *img;                  // 图片
@property (nonatomic, copy) NSString *mini_img;             // 小程序图片
@property (nonatomic, copy) NSString *mini_program_path;    // 小程序地址
@property (nonatomic, copy) NSString *summary;              // 描述
@property (nonatomic, copy) NSString *circle_of_friends_title;

+ (WBCommunityTopicShareModel *)createTopicShareModelWithDict:(NSDictionary *)dict;

@end

@interface WBCommunityModel : NSObject

@property (nonatomic, copy) NSString *topic_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *content_str;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *share_count;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *reason_mark;
@property (nonatomic, copy) NSString *data_type;
@property (nonatomic, copy) NSString *rates;
@property (nonatomic, copy) NSString *h5_url;

@property (nonatomic, assign) BOOL is_delete;
@property (nonatomic, assign) BOOL is_rates;
@property (nonatomic, assign) BOOL is_favor;

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) CGFloat firstImageWidth;
@property (nonatomic, assign) CGFloat firstImageHeight;

@property (nonatomic, strong) NSArray *img_list;        // 1.5.21 以后使用 img_data_list 数据
@property (nonatomic, strong) NSArray *img_data_list;

@property (nonatomic, strong) WBUserModel *userModel;
@property (nonatomic, strong) WBCommunityTopicTagModel *topicTagModel;
@property (nonatomic, strong) WBCommunityTopicShareModel *shareModel;

+ (WBCommunityModel *)createCommunityModelWithDict:(NSDictionary *)dict;
+ (NSArray *)createCommunityModelWithArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END

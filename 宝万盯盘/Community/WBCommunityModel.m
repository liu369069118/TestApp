//
//  WBCommunityModel.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBCommunityModel.h"
#import "YYModel.h"

@implementation WBCommunityImageModel

+ (WBCommunityImageModel *)createImageModelWithDict:(NSDictionary *)dict {
    WBCommunityImageModel *model = [[WBCommunityImageModel alloc] init];
    
    model.suffix    = [dict getNotNilString:@"suffix"];
    model.url       = [dict getNotNilString:@"url"];
    
    model.imgWidth  = [[dict getNumber:@"width"] floatValue];
    model.imgHeight = [[dict getNumber:@"height"] floatValue];
    
    return model;
}

+ (NSArray *)createImageModelWithArray:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        if (array.count > 0) {
            NSMutableArray *models = [NSMutableArray arrayWithCapacity:1];
            for (NSDictionary * dict in array) {
                WBCommunityImageModel *model = [WBCommunityImageModel createImageModelWithDict:dict];
                
                [models addObject:model];
            }
            
            return [models mutableCopy];
        }
    }
    
    return [NSArray array];
}

@end

@implementation WBCommunityTopicTagModel

+ (WBCommunityTopicTagModel *)createTopicTagModelWithDict:(NSDictionary *)dict {
    WBCommunityTopicTagModel *model = [[WBCommunityTopicTagModel alloc] init];
    
    model.topic_tag_id      = [dict getNotNilString:@"topic_tag_id"];
    model.name              = [dict getNotNilString:@"name"];
    model.descriptionString = [dict getNotNilString:@"description"];
    model.openUrl           = [dict getNotNilString:@"url"];
    
    model.is_follow         = [[dict getNumber:@"is_follow"] integerValue] == 1;
    
    return model;
}

@end

@implementation WBCommunityTopicShareModel

+ (WBCommunityTopicShareModel *)createTopicShareModelWithDict:(NSDictionary *)dict {
    WBCommunityTopicShareModel *model = [[WBCommunityTopicShareModel alloc] init];
    
    model.title             = [dict getNotNilString:@"title"];
    model.url               = [dict getNotNilString:@"url"];
    model.img               = [dict getNotNilString:@"img"];
    model.mini_img          = [dict getNotNilString:@"mini_img"];
    model.mini_program_path = [dict getNotNilString:@"mini_program_path"];
    model.summary           = [dict getNotNilString:@"summary"];
    model.circle_of_friends_title = [dict getNotNilString:@"circle_of_friends_title"];
    
    return model;
}

@end


@implementation WBCommunityModel

+ (WBCommunityModel *)createCommunityModelWithDict:(NSDictionary *)dict {
    WBCommunityModel *model = [[WBCommunityModel alloc] init];
    
    model.topic_id      = [dict getNotNilString:@"id"];
    model.title         = [dict getNotNilString:@"title"];
    model.content       = [dict getNotNilString:@"content"];
    model.content_str   = [dict getNotNilString:@"content_str"];
    model.views         = [dict getNotNilString:@"views"];
    model.comments      = [dict getNotNilString:@"comments"];
    model.share_count   = [dict getNotNilString:@"share_count"];
    model.url           = [dict getNotNilString:@"url"];
    model.create_time   = [dict getNotNilString:@"create_time"];
    model.reason_mark   = [dict getNotNilString:@"reason_mark"];
    model.data_type     = [dict getNotNilString:@"data_type"];
    model.rates         = [dict getNotNilString:@"rates"];
    model.h5_url        = [dict getNotNilString:@"h5_url"];
    
    model.status        = [[dict getNumber:@"status"] integerValue];
    model.is_delete     = [[dict getNumber:@"is_delete"] integerValue] == 1;
    model.is_rates      = [[dict getNumber:@"is_rates"] integerValue] == 1;
    model.is_favor      = [[dict getNumber:@"is_favor"] integerValue] == 1;
    
    model.firstImageWidth = 222;
    model.firstImageHeight = 222;
    
    model.userModel     = [WBUserModel yy_modelWithDictionary:[dict getObject:@"user_data"]];
    model.topicTagModel = [WBCommunityTopicTagModel createTopicTagModelWithDict:[dict getObject:@"topic_tag_data"]];
    model.shareModel    = [WBCommunityTopicShareModel createTopicShareModelWithDict:[dict getObject:@"share_info"]];
    
    model.img_list      = [dict getArray:@"img_list"];
    model.img_data_list = [WBCommunityImageModel createImageModelWithArray:[dict getArray:@"img_data_list"]];
    if (model.img_data_list.count == 1) {
        CGFloat tempWidth = [model.img_data_list.firstObject imgWidth];
        CGFloat tempHeight = [model.img_data_list.firstObject imgHeight];
        
        if (tempWidth == 0 && tempHeight == 0) {
            return model;
        }
        
        CGFloat ratio = 0;
        if (tempWidth > tempHeight) {
            if (tempWidth >= tempHeight * 4) {
                model.firstImageWidth = 222;
                model.firstImageHeight = 125;
            } else {
                ratio = 222 / tempWidth;
                
                model.firstImageWidth = 222;
                model.firstImageHeight = tempHeight * ratio;
            }
        } else if (tempWidth == tempHeight) {
            model.firstImageWidth = 222;
            model.firstImageHeight = 222;
        } else if (tempWidth < tempHeight) {
            if (tempHeight >= tempWidth * 4) {
                model.firstImageWidth = 125;
                model.firstImageHeight = 222;
            } else {
                ratio = 222 / tempHeight;
                
                model.firstImageWidth = tempWidth * ratio;
                model.firstImageHeight = 222;
            }
        }
    }
    
    return model;
}

+ (NSArray *)createCommunityModelWithArray:(NSArray *)dataArray {
    if ([dataArray isKindOfClass:[NSArray class]]) {
        if (dataArray.count > 0) {
            NSMutableArray *models = [NSMutableArray arrayWithCapacity:1];
            for (NSDictionary * dict in dataArray) {
                WBCommunityModel *model = [WBCommunityModel createCommunityModelWithDict:dict];
                
                [models addObject:model];
            }
            
            return [models mutableCopy];
        }
    }
    
    return [NSArray array];
}

@end

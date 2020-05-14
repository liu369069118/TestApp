//
//  WBCommunityFunctionView.h
//  万宝股票
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 万宝股票. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommunityModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HCCommunityCellFunctionViewDelegate <NSObject>

- (void)likeForFunctionViewClick;
- (void)commentForFunctionViewClick;

@end

@interface WBCommunityFunctionView : UIView

@property (nonatomic, weak) id <HCCommunityCellFunctionViewDelegate> delegate;
@property (nonatomic, strong) WBCommunityModel *topicModel;

- (void)changeFollowState:(BOOL)isFollow;

@end

NS_ASSUME_NONNULL_END

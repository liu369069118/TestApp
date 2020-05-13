//
//  WBCommunityButton.h
//  万宝股票资讯
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 万宝股票资讯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBCommunityButton : UIView

@property (nonatomic, assign) CGFloat tapInsetWidth;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UIImage *image;


@end

NS_ASSUME_NONNULL_END

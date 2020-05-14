//
//  KNPhotoBrowerImageView.h
//  KNPhotoBrower
//
//  Created by LuKane on 16/8/17.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
@class KNProgressHUD;

typedef void(^SingleTapBlock)(void);
typedef void(^LongPressBlock)(void);
typedef void(^upSwipeBlock)(void);
typedef void(^downSwipeBlock)(void);

@interface KNPhotoBrowerImageView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy  ) SingleTapBlock singleTapBlock;
@property (nonatomic, copy  ) LongPressBlock longPressBlock;
@property (nonatomic, copy  ) upSwipeBlock upSwipeBlock;
@property (nonatomic, copy  ) downSwipeBlock downSwipeBlock;

- (void)sd_ImageWithUrl:(NSURL *)url progressHUD:(KNProgressHUD *)progressHUD placeHolder:(UIImage *)placeHolder;


@end

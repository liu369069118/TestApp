//
//  BLScrollView.h
//  hotbody
//
//  Created by shicuf on 16/7/6.
//  Copyright © 2016年 Beijing Fitcare inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLScrollView : UIScrollView  <UIGestureRecognizerDelegate>

/// 左滑时同时启用其他手势，比如系统左滑、sidemenu左滑。默认 NO
@property (nonatomic, assign) BOOL otherGestureRecognizerSimultaneously;

@end

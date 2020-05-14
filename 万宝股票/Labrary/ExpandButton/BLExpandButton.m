//
//  BLExpandButton.m
//  Camp
//
//  Created by Belle on 2017/4/11.
//  Copyright © 2017年 Beijing Fitcare inc. All rights reserved.
//

#import "BLExpandButton.h"

@implementation BLExpandButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGPoint leftPoint = CGPointMake(0 - _rangeInsets.left, 0 - _rangeInsets.top);
    CGPoint rightPoint = CGPointMake(self.bounds.size.width+_rangeInsets.right, self.bounds.size.height+_rangeInsets.bottom);
    
    if ((point.x > leftPoint.x)  &&
        (point.x < rightPoint.x) &&
        (point.y > leftPoint.y)  &&
        (point.y < rightPoint.y) ) {
        return YES;
    }else{
        return NO;
    }
}

- (void)setRangeInsets:(UIEdgeInsets)rangeInsets {
    if (rangeInsets.top < 0 || rangeInsets.bottom < 0) {
        if (-rangeInsets.top - rangeInsets.bottom >= self.bounds.size.height) {
            return;
        }
    }
    if (rangeInsets.left < 0 || rangeInsets.right < 0) {
        if (-rangeInsets.top - rangeInsets.bottom >= self.bounds.size.height) {
            return;
        }
    }
    
    _rangeInsets = rangeInsets;
}

@end

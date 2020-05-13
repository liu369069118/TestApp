//
//  SXHGTYGPUTButton.m
//  YFGP
//
//  Created by tomsom on 2019/5/25.
//  Copyright © 2019 Zhang yuanhong. All rights reserved.
//

#import "SXHGTYGPUTButton.h"

@implementation SXHGTYGPUTButton
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.orientation = MyOrientation_Horz;
        
        for (UIView *scontentView in self.subviews) {
            scontentView.width = kScreenWidth/3;
            scontentView.myTop = 8;
        }
    }
    return self;
}

@end

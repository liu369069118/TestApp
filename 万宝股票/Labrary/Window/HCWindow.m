//
//  HCWindow.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/6.
//  Copyright © 2018年 Beijing Bai Cheng Media Technology Co.LTD. All rights reserved.
//

#import "HCWindow.h"
#import "XXGP_LoadViewController.h"

@interface HCWindow()

@property (strong,nonatomic) UIView *unrechNetworkView;

// 右下角悬浮发布按钮
@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation HCWindow

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addNotify];
    }
    return self;
}

- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPublishButton) name:@"kHCShowWindowPublishButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePublishButton) name:@"kHCHiddenWindowPublishButton" object:nil];
}

- (void)showPublishButton {
    self.publishButton.hidden = NO;
    [self bringSubviewToFront:self.publishButton];
}

- (void)hidePublishButton {
    self.publishButton.hidden = YES;
}

#pragma mark - lazy load
- (UIView *)unrechNetworkView{
    if (!_unrechNetworkView) {
        _unrechNetworkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
        _unrechNetworkView.backgroundColor = [UIColor redColor];
    }
    return _unrechNetworkView;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishButton.frame = CGRectMake(kScreenWidth - 12 - 64, kScreenHeight - kHCTabbarHeight - 10 - 64, 64, 64);
        _publishButton.hidden = YES;
        _publishButton.backgroundColor = [HCColor redColor];
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        [_publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _publishButton.titleLabel.font = [HCFont pingfangMedium:13];
        _publishButton.layer.cornerRadius = 32;
        _publishButton.layer.masksToBounds = YES;
//        [_publishButton setImage:[UIImage imageNamed:@"btn_window_publish_n"] forState:UIControlStateNormal];
        
        [_publishButton xf_addEventHandler:^(id sender) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kHCWindowPublishButtonAction" object:nil];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_publishButton];
    }
    return _publishButton;
}

@end

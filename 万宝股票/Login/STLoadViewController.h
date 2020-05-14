//
//  STLoadViewController.h
//  LeGuang
//
//  Created by 刘涛 on 15/9/24.
//  Copyright © 2015年 ShiTu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadStatusBlook)(void);

@interface STLoadViewController : UIViewController

@property(copy,nonatomic)loadStatusBlook loadStatus;  //登录成功回调

@end

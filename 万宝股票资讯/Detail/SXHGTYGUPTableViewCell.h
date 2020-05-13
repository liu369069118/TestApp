//
//  MYGUPTableViewCell.h
//  YFGP
//
//  Created by tomsom on 2019/5/25.
//  Copyright © 2019 Zhang yuanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHGTYGUPTableViewCell : UITableViewCell
@property (assign, nonatomic)  int acd;
@property (strong, nonatomic)  NSString* gid;
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UILabel *xy;
@property (weak, nonatomic) IBOutlet UILabel *t;
@property (weak, nonatomic) IBOutlet UILabel *nb;
@property (weak, nonatomic) IBOutlet UILabel *per;


 -(void)update:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END

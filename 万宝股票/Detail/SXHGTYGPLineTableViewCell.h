//
//  SXHGTYGPLineTableViewCell.h
//  YFGP
//
//  Created by tomsom on 2019/5/26.
//  Copyright © 2019 Zhang yuanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHGTYGPLineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *per;
@property (weak, nonatomic) IBOutlet UILabel *gplprice;

@property(nonatomic, assign) int  acd;

-(void)updateListCellDataWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END

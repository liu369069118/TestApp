//
//  SXHGTYAlertViewController.h
//  SCDBYIProject
//
//  Created by jo Hebing on 2020/1/8.
//  Copyright © 2020 oyiis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    SXHGTYAlertViewSourceTypeReleas,
    SXHGTYAlertViewSourceTypeJub
}SXHGTYAlertViewSourceType;

NS_ASSUME_NONNULL_BEGIN

@interface SXHGTYAlertViewController : UIAlertController
@property(nonatomic,assign)SXHGTYAlertViewSourceType source;
@end

NS_ASSUME_NONNULL_END

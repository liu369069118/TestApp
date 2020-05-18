

#import <UIKit/UIKit.h>

@interface KNPhotoBrowerNumView : UILabel

- (void)setCurrentNum:(NSInteger)currentNum totalNum:(NSInteger)totalNum;

@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, assign) NSInteger totalNum;

@end

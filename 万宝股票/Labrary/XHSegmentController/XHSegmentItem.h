

#import <UIKit/UIKit.h>

#define Item_Padding     20

@interface XHSegmentItem : UIButton

@property(nonatomic, strong)           NSString  *title;
@property(nonatomic, strong)           UIColor  *highlightColor;
@property(nonatomic, strong)           UIColor  *titleColor;
@property(nonatomic, strong)           UIFont   *titleFont;

+ (CGFloat)caculateWidthWithtitle:(NSString *)title titleFont:(UIFont *)titleFont;
- (void)refresh;
+ (BOOL)isStringEmpty:(NSString *)text;

@end

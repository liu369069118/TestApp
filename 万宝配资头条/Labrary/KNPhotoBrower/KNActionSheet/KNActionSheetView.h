
#import <UIKit/UIKit.h>

@protocol KNActionSheetViewDelegate <NSObject>

- (void)actionSheetViewIBAction:(NSInteger)index;

@end

@interface KNActionSheetView : UIView

@property (nonatomic, weak) id<KNActionSheetViewDelegate> delegate;

/*
 * 文字
 */
@property (nonatomic, copy) NSString *title;

/*
 * 是否是 销毁
 */
@property (nonatomic, assign) BOOL isDestructive;

@end

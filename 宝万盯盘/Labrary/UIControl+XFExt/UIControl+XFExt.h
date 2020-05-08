





#import <UIKit/UIKit.h>

@interface UIControl (XFExt)

- (void)xf_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

- (void)xf_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

- (BOOL)xf_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;


@end



#import <UIKit/UIKit.h>
#import "XXGP_CommunityModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HCCommunityCellFunctionViewDelegate <NSObject>

- (void)likeForFunctionViewClick;
- (void)commentForFunctionViewClick;

@end

@interface XXGP_CommunityFunctionView : UIView

@property (nonatomic, weak) id <HCCommunityCellFunctionViewDelegate> delegate;
@property (nonatomic, strong) XXGP_CommunityModel *topicModel;

- (void)changeFollowState:(BOOL)isFollow;

@end

NS_ASSUME_NONNULL_END

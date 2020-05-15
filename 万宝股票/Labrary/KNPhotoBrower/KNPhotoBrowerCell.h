
#import <UIKit/UIKit.h>
#import "KNPhotoBrowerImageView.h"

typedef void(^SingleTap)(void);
typedef void(^LongPress)(void);
typedef void(^upSwipe)(void);
typedef void(^downSwipe)(void);

@interface KNPhotoBrowerCell : UICollectionViewCell

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder;

@property (nonatomic, copy  ) SingleTap singleTap;
@property (nonatomic, copy  ) LongPress longPress;
@property (nonatomic, copy  ) upSwipe upSwipe;
@property (nonatomic, copy  ) downSwipe downSwipe;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) KNPhotoBrowerImageView *photoBrowerImageView;

@end


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,XXGP_ProgramProgressHUDMode) {
    ///默认loading,不带文字
    XXGP_ProgramProgressHUDModeLoading,
    ///loading&文字
    XXGP_ProgramProgressHUDModeLoadingAndText,
    ///文字提示
    XXGP_ProgramProgressHUDModeText,
    ///进度条
    XXGP_ProgramProgressHUDModeProgressValue,
    ///图标
    XXGP_ProgramProgressHUDModeImage
};


/**
 遮罩的类型，有遮罩不能点击遮罩下的事件
 */
typedef NS_ENUM(NSInteger, XXGP_ProgramProgressHUDMaskType) {
    ///没有遮罩
    XXGP_ProgramProgressHUDMaskTypeNone,
    ///黑色遮罩
    XXGP_ProgramProgressHUDMaskTypeBlack,
    ///透明遮罩
    XXGP_ProgramProgressHUDMaskTypeClear
};
/**
 颜色风格
 */
typedef NS_ENUM(NSInteger, XXGP_ProgramProgressHUDColorType) {
    ///默认风格
    XXGP_ProgramProgressHUDColorTypeDefault,
    ///黑色调风格
    XXGP_ProgramProgressHUDColorTypeBlack,
} ;


NS_ASSUME_NONNULL_BEGIN

@interface XXGP_ProgramProgressHUD : UIView
///改变颜色风格
@property(nonatomic, assign) XXGP_ProgramProgressHUDColorType colorType;
///hud的中心偏移量,x:大于零向右，小于0向左  y:大于零向下，小于0向上
@property(nonatomic, assign) CGPoint viewCenterOffet;
///自定义视图的边距,top,left,bottom,right
@property(nonatomic, assign) UIEdgeInsets customViewEdgeInsets;
///改变内容的颜色
@property (nonatomic, strong) UIColor *customContentColor;
///文字
@property(nonatomic, copy) NSString *customText;
///文字颜色
@property(nonatomic, strong) UIColor *customTextColor;
///文字大小
@property(nonatomic, strong) UIFont *customTextFont;
///进度
@property(nonatomic, assign) CGFloat customProgress;
///图片
@property(nonatomic, strong) UIImage *customImage;


///初始化方法
- (instancetype)initWithMode:(XXGP_ProgramProgressHUDMode)mode;
- (instancetype)initWithCustomView:(UIView *)customView;

/**
 开始展示

 @param view 显示的父视图
 @param animated 是否动画，默认yes
 */

- (void)showOnView:(UIView *)view animated:(BOOL)animated;
- (void)showOnView:(UIView *)view animated:(BOOL)animated maskType:(XXGP_ProgramProgressHUDMaskType)maskType;

/**
 隐藏

 @param animated 是否动画，默认yes
 */
- (void)hideViewAnimated:(BOOL)animated;
- (void)hideViewAnimated:(BOOL)animated completion:(void(^__nullable)(void))completion;


/**
 设置进度

 @param progress 进度数值
 @param finished 100%的回调
 */
- (void)setCustomProgress:(CGFloat)progress finished:(void(^__nullable)(void))finished;

@end

///自定义视图
@interface SSProgressCustomView : UIView

///改变内容的颜色
@property (nonatomic, strong) UIColor *contentColor;
///文字
@property(nonatomic, copy) NSString *text;
///文字颜色
@property(nonatomic, strong) UIColor *textColor;
///文字大小
@property(nonatomic, strong) UIFont *textFont;


@end

////loading,text,loading and text
@interface SSProgressLoadTextView : SSProgressCustomView
- (instancetype)initWithMode:(XXGP_ProgramProgressHUDMode)mode;
@end


///进度条
@interface SSProgressValueView:SSProgressCustomView
///进度
@property (nonatomic, assign) CGFloat progress;
@end


@interface SSProgressImageView:SSProgressCustomView
///图片
@property (nonatomic, strong) UIImage *image;
@end


@interface NSObject (XXGP_ProgramProgressHUD)

/*
 *tag参数的说明：
 1、当tag等于-1或者大于0的时候，每个tag对应一个hud。
 2、如果展示的是文字提示的tag为0,不会缓存hud。
 3、loading的时候默认tag为-1；
 
 */


///loading,没文字
- (void)showLoading;
- (void)showLoadingWithMaskType:(XXGP_ProgramProgressHUDMaskType)maskType;

- (void)showLoadingWithTag:(NSInteger)tag;
- (void)showLoadingWithTag:(NSInteger)tag maskType:(XXGP_ProgramProgressHUDMaskType)maskType;

///loading,有文字
- (void)showLoadingText:(NSString * _Nullable )text;
- (void)showLoadingText:(NSString * _Nullable )text maskType:(XXGP_ProgramProgressHUDMaskType)maskType;

- (void)showLoadingText:(NSString * _Nullable )text tag:(NSInteger)tag;
- (void)showLoadingText:(NSString * _Nullable )text tag:(NSInteger)tag maskType:(XXGP_ProgramProgressHUDMaskType)maskType;

///文字提示
- (void)showText:(NSString *)text;
///文字提示，有消失时回调
- (void)showText:(NSString *)text finished:(void(^ __nullable)(void))finished;
- (void)showText:(NSString *)text maskType:(XXGP_ProgramProgressHUDMaskType)maskType finished:(void(^ __nullable)(void))finished;

///进度条
- (void)showProgress:(CGFloat)progress finished:(void(^ __nullable)(void))finished;
- (void)showProgress:(CGFloat)progress maskType:(XXGP_ProgramProgressHUDMaskType)maskType finished:(void(^ __nullable)(void))finished;

- (void)showProgress:(CGFloat)progress text:(NSString * _Nullable)text finished:(void(^ __nullable)(void))finished;
- (void)showProgress:(CGFloat)progress text:(NSString * _Nullable)text maskType:(XXGP_ProgramProgressHUDMaskType)maskType finished:(void(^ __nullable)(void))finished;


///图片
- (void)showHUDWithImageName:(NSString *)imageName;
- (void)showHUDWithImageName:(NSString *)imageName text:(NSString * _Nullable)text;
- (void)showHUDWithImageName:(NSString *)imageName text:(NSString * _Nullable)text finished:(void(^__nullable)(void))finished;
- (void)showHUDWithImageName:(NSString *)imageName text:(NSString * _Nullable)text maskType:(XXGP_ProgramProgressHUDMaskType)maskType finished:(void(^__nullable)(void))finished;


///隐藏
- (void)hideHUD;
- (void)hideHUDWithTag:(NSInteger)tag;

- (void)hideHUDAnimated:(BOOL)animated;
- (void)hideHUDAnimated:(BOOL)animated tag:(NSInteger)tag;

- (void)hideHUDAnimated:(BOOL)animated finished:(void(^ __nullable)(void))finished;
- (void)hideHUDAnimated:(BOOL)animated tag:(NSInteger)tag finished:(void(^ __nullable)(void))finished;

@end


NS_ASSUME_NONNULL_END

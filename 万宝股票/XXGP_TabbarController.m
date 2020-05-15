

#import "XXGP_TabbarController.h"
#import <CoreImage/CIImage.h>

@interface XXGP_TabbarController () <UITabBarControllerDelegate>

@end

@implementation XXGP_TabbarController


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBar];
    [self setupLayout];
}

- (void)setupBar {
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [self setupTopLine];
    
    [self setupBarItem];
}

- (void)setupTopLine {
    CGRect rect = CGRectMake(0, 0, kScreenWidth, .5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [HCColor colorWithR:209 G:211 B:220].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.tabBar setShadowImage:img];
    
    [self.tabBar setBackgroundImage:[self imageWithColor:[HCColor whiteColor]]];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setupBarItem {
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[HCColor appColor1_A70], NSForegroundColorAttributeName, [HCFont pingfangM_F_11], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[HCColor HCBlueColor],NSForegroundColorAttributeName, [HCFont pingfangM_F_11], NSFontAttributeName, nil]forState:UIControlStateSelected];
    
    NSArray *tabBarMenu = @[@{
                                @"title" : @"行情",
                                @"image" : @"tabbar_quotation",
                                @"class" : @"XXGP_QuotationController",
                            },
                            @{
                                @"title" : @"资讯",
                                @"image" : @"tabbar_news",
                                @"class" : @"XXGP_HomeController",
                            },
                            @{
                                @"title" : @"社区",
                                @"image" : @"tabbar_community",
                                @"class" : @"XXGP_CommunityController",
                            },
                            @{
                                @"title" : @"我的",
                                @"image" : @"tabbar_profile",
                                @"class" : @"XXGP_UserController",
                            },
    ];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSDictionary *menu in tabBarMenu) {
        UIViewController *viewController = [[NSClassFromString(menu[@"class"]) alloc] init];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:menu[@"title"] image:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_n", menu[@"image"]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_s", menu[@"image"]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [viewControllers addObject:viewController];
    }
    
    self.viewControllers = viewControllers;
}

- (void)setupLayout {
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if (tabBarController.selectedIndex == 0 &&
//        self.viewControllers[0] == viewController) {
//        
//    }
//    
//    if (tabBarController.selectedIndex == 1 &&
//        self.viewControllers[1] == viewController) {
//        
//    }
//    
//    if (tabBarController.selectedIndex == 2 &&
//        self.viewControllers[2] == viewController) {
//        
//    }
//    
//    if (self.viewControllers[3] == viewController) {
//    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

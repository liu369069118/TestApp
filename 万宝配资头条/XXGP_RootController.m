

#import "XXGP_RootController.h"
#import "XXGP_QuotationController.h"
#import "XXGP_HomeController.h"
#import "XXGP_CommunityController.h"
#import "XXGP_UserController.h"
#import "XXGP_SearchListController.h"
#import "HBActionSheet.h"

@interface XXGP_RootController ()

@property (nonatomic, strong) NSArray *vcNames;

@end

@implementation XXGP_RootController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configPage];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    UIView *navBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHCNavigationBarHeight)];
    navBackView.backgroundColor = [UIColor colorWithRed:228/255.0 green:87/255.0 blue:28/255.0 alpha:1.0];
    [self.view addSubview:navBackView];
    
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor colorWithRed:228/255.0 green:87/255.0 blue:28/255.0 alpha:1.0];
    [navBackView addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(kHCNavigationBarHeight-kHCStatusBarHeight);
    }];
    
    UIButton *userIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [userIcon setImage:[UIImage imageNamed:@"img_default_avatar_n"] forState:UIControlStateNormal];
    userIcon.layer.cornerRadius = 15;
    userIcon.layer.masksToBounds = YES;
    [userIcon addTarget:self action:@selector(jumpUser) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(16);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpSearch)];
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor colorWithRed:234/255.0 green:120/255.0 blue:63/255.0 alpha:1.0];
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    [searchView addGestureRecognizer:tap];
    [navView addSubview:searchView];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.userInteractionEnabled = YES;
    textLabel.text = @"检索股票信息,例:亚翔集成";
    textLabel.textColor = [HCColor whiteColor];
    textLabel.font = kHCBoldFont14;
    [searchView addSubview:textLabel];
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon_blue"]];
    searchIcon.userInteractionEnabled = YES;
    [searchView addSubview:searchIcon];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(15);
    }];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.equalTo(textLabel.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UIButton *emailIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailIcon setImage:[UIImage imageNamed:@"feedback"] forState:UIControlStateNormal];
    [emailIcon addTarget:self action:@selector(jumpEmail) forControlEvents:UIControlEventTouchUpInside];
    emailIcon.layer.cornerRadius = 15;
    emailIcon.layer.masksToBounds = YES;
    [navView addSubview:emailIcon];
    
    [emailIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(-16);
    }];

    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(userIcon.mas_right).offset(16);
        make.right.equalTo(emailIcon.mas_left).offset(-16);
        make.height.mas_equalTo(30);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)configPage {
    self.postNotification = YES;
    self.bounces = YES;
    self.menuViewStyle = BLMenuViewStyleLine;
    self.showOnNavigationBar = NO;
    self.progressWidth = kScreenWidth/6.0;
    self.viewFrame = CGRectMake(0, kHCNavigationBarHeight, kScreenWidth, kScreenHeight-kHCNavigationBarHeight);
    self.menuViewLayoutMode = BLMenuViewLayoutModeCenter;
    self.titleSizeNormal = 16;
    self.titleSizeSelected = 18;
}



#pragma mark - pagecontroller delegate

- (NSInteger)numbersOfChildControllersInPageController:(BLPageController *)pageController {
    return 3;
}

- (UIViewController *)pageController:(BLPageController *)pageController
               viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        XXGP_QuotationController *vc = [[XXGP_QuotationController alloc] init];
        return vc;
    } else if (index == 1) {
        XXGP_HomeController *vc = [[XXGP_HomeController alloc] init];
        return vc;
    } else {
        XXGP_CommunityController *vc = [[XXGP_CommunityController alloc] init];
        return vc;
    }
}

- (NSString *)pageController:(BLPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.vcNames objectAtIndex:index];
}

- (CGFloat)menuView:(BLMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    return kScreenWidth/3.0;
}


- (void)jumpUser {
    XXGP_UserController *vc = [[XXGP_UserController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpEmail {
    NSString *cacheString = [NSString stringWithFormat:@"如果您发现任何问题，请发送邮件联系我们，是否需要复制我们的邮箱到您的剪切板？"];
    HBActionSheet *actionSheet = [[HBActionSheet alloc] initActionSheetWithTitle:@"" descriptiveText:cacheString cancelButtonTitle:@"取消" destructiveButtonTitles:@[@"复制邮箱"] otherButtonTitles:@[] itemAction:^(HBActionSheet *actionSheet, NSString *title, NSInteger index) {
        if ([title isEqualToString:@"复制邮箱"]) {
            [UIPasteboard generalPasteboard].string = @"baowan@163.com";
            [[KNToast shareToast] initWithText:@"复制成功"];
        } else {
            
        }
    }];
    [actionSheet showAction];
}

- (void)jumpSearch {
    XXGP_SearchListController *vc = [[XXGP_SearchListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray *)vcNames {
    if (!_vcNames) {
        _vcNames = @[@"行  情",@"资  讯",@"社  区"];
    }
    return _vcNames;
}

@end

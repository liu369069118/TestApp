

#import "XXGP_LoadViewController.h"
#import "XXGP_Loading.h"
#import "XXGP_RegisViewController.h"
#import "XXGP_LoginTool.h"
#import "KNToast.h"

@interface XXGP_LoadViewController ()<UITextFieldDelegate>

@property (strong,nonatomic)XXGP_Loading *loading;

@property (strong,nonatomic)XXGP_Loading *resginView;

@end

@implementation XXGP_LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self XXGP_LayoutView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark - TextDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   return [textField resignFirstResponder];
}

#pragma -mark -events response

- (void)XXGP_Loadorregis:(UIButton *)btn{
    if (btn.tag == 1003) {
        //登陆
        BOOL loginstate = [[XXGP_LoginTool sharedInstance] XXGP_UserLoginWithAccount:_loading.username.text password:_loading.userpass.text];
        if (loginstate) {
            if (self.loadStatus) {
                self.loadStatus();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[KNToast shareToast] initWithText:@"账号密码错误"];
        }
    }else if (btn.tag == 1004){
        //注册
        XXGP_RegisViewController *regis = [[XXGP_RegisViewController alloc] init];
        regis.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:regis animated:YES completion:nil];
    }
}
- (void)XXGP_JumpBack:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)XXGP_JumpLoginWeb {
    XXGP_WebviewController *web = [[XXGP_WebviewController alloc] init];
    web.titleStr = @"隐私协议";
    web.type = 1;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)XXGP_JumpRegisWeb {
    XXGP_WebviewController *web = [[XXGP_WebviewController alloc] init];
    web.titleStr = @"注册协议";
    web.type = 2;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma -mark -LayoutView

- (void)XXGP_LayoutView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _loading = [[XXGP_Loading alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_loading];
    _loading.username.delegate =  self;
    _loading.userpass.delegate =  self;
    [_loading.log_sure addTarget:self action:@selector(XXGP_Loadorregis:) forControlEvents:UIControlEventTouchUpInside];//登录
    [_loading.regisAcc addTarget:self action:@selector(XXGP_Loadorregis:) forControlEvents:UIControlEventTouchUpInside];//注册
    [_loading.backbtn addTarget:self action:@selector(XXGP_JumpBack:) forControlEvents:UIControlEventTouchUpInside];//随便逛逛
    [_loading.loginAgreement addTarget:self action:@selector(XXGP_JumpLoginWeb) forControlEvents:UIControlEventTouchUpInside];
    [_loading.regisAgreement addTarget:self action:@selector(XXGP_JumpRegisWeb) forControlEvents:UIControlEventTouchUpInside];
}

@end

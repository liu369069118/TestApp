
#import "XXGP_ReleaPageViewController.h"
#import "PlaceholderTextView.h"
#import "XXGP_AlertViewController.h"
#import "XXGP_ProgramProgressHUD.h"

#define kTextBorderColor     RGBCOLOR(227,224,216)

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kSXHG_TextViewH 134


@interface XXGP_ReleaPageViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) PlaceholderTextView * SXHG_ConyTextV;

@property (nonatomic, strong) UIButton * SXHG_TijSaveButton;

@property (nonatomic, strong) UIView * aView;
@property (nonatomic, strong) UILabel * SXHG_tipLab;

//回收键盘
@property (nonatomic, strong)UITextField *textField;

//字数的限制
@property (nonatomic, strong)UILabel *wordLimitCountLabel;

@end

@implementation XXGP_ReleaPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = self.SXHG_NaviBackButton;
    self.view.backgroundColor = [UIColor whiteColor];

    self.aView = [[UIView alloc]init];
    _aView.backgroundColor = [UIColor whiteColor];
    _aView.frame = CGRectMake(15, kHCNavigationBarHeight + 10, kScreenWidth - 30, 180);
    [self.view addSubview:_aView];
    self.navigationItem.title = self.naviTitle;

    self.SXHG_tipLab = [[UILabel alloc]initWithFrame:CGRectMake(15 , _aView.bottom, kScreenWidth - 30, 30)];
    self.SXHG_tipLab.font = [UIFont systemFontOfSize:13];
    self.SXHG_tipLab.textColor = HCColor(255, 97, 0);
    self.SXHG_tipLab.text = @"您发表的评论我们将在8小时内完成审核";
    self.SXHG_tipLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.SXHG_tipLab];
    
    self.wordLimitCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.SXHG_ConyTextV.frame.origin.x + 20,  self.SXHG_ConyTextV.frame.size.height + kSXHG_TextViewH - 1, [UIScreen mainScreen].bounds.size.width - 40, 20)];
    self.wordLimitCountLabel.font = [UIFont systemFontOfSize:14.f];
    self.wordLimitCountLabel.textColor = [UIColor lightGrayColor];
    self.wordLimitCountLabel.text = @"0/120";
    self.wordLimitCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordLimitCountLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.wordLimitCountLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.SXHG_ConyTextV.frame.origin.x + 20,  self.SXHG_ConyTextV.frame.size.height + kSXHG_TextViewH - 1 + 23, [UIScreen mainScreen].bounds.size.width - 40, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    [_aView addSubview:self.SXHG_ConyTextV];
    
    [self.view addSubview:self.SXHG_TijSaveButton];
}

-(PlaceholderTextView *)SXHG_ConyTextV{

    if (!_SXHG_ConyTextV) {
        _SXHG_ConyTextV = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 100)];
        _SXHG_ConyTextV.backgroundColor = [UIColor whiteColor];
        _SXHG_ConyTextV.delegate = self;
        _SXHG_ConyTextV.font = [UIFont systemFontOfSize:14.f];
        _SXHG_ConyTextV.textColor = [UIColor blackColor];
        _SXHG_ConyTextV.textAlignment = NSTextAlignmentLeft;
        _SXHG_ConyTextV.editable = YES;
        _SXHG_ConyTextV.layer.cornerRadius = 4.0f;
        _SXHG_ConyTextV.layer.borderColor = kTextBorderColor.CGColor;
        _SXHG_ConyTextV.layer.borderWidth = 0.5;
        _SXHG_ConyTextV.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _SXHG_ConyTextV.placeholder = @"写下您的看法吧~~";
       
        
    }
    
    return _SXHG_ConyTextV;
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }

    return YES;
}

- (UIButton *)SXHG_TijSaveButton{

    if (!_SXHG_TijSaveButton) {
        _SXHG_TijSaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SXHG_TijSaveButton.layer.cornerRadius = 20.0f;
        _SXHG_TijSaveButton.frame = CGRectMake(50, _SXHG_tipLab.bottom + 50, kScreenWidth - 100, 40);
        _SXHG_TijSaveButton.backgroundColor = [self colorWithRGBHex:0xeb5b32];
        [_SXHG_TijSaveButton setTitle:@"发布评论" forState:UIControlStateNormal];
        [_SXHG_TijSaveButton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    }

    return _SXHG_TijSaveButton;

}

#pragma mark 提交意见反馈
- (void)sendFeedBack{
  BOOL isFirst =   [[NSUserDefaults standardUserDefaults] objectForKey:@"isLoad"];
    if (!isFirst) {
        XXGP_AlertViewController *alertVC = [XXGP_AlertViewController alertControllerWithTitle:@"发表规则" message:@"1.用户对其发表的信息负责，应尽可能提供详尽、真实、准确的材料,不得发表不真实的、有歧义的信息，绝对禁止发表误导性的、恶意的消息产品。  \n   2.用户不得在平台内发表与本应用无关的内容，我们会在8小时内对用户的内容进行审核,审核通过后才可发表到产品平台内.   \n     3.用户如发现其他用户发表的内容不当，应在内容页进行举报!收到举报后我们会在8小时内对内容进行重新审核!" preferredStyle:UIAlertControllerStyleAlert];
        alertVC.source = XXGP_AlertViewSourceTypeReleas;
         [self presentViewController:alertVC animated:YES completion:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoad"];
        return;
    }
    
    if (self.SXHG_ConyTextV.text.length == 0) {
        UIAlertController *alertLength = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入的信息为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *suer = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertLength addAction:suer];
        [self presentViewController:alertLength animated:YES completion:nil];
    } else {
        [XXGP_ProgramProgressHUD showLoadingText:@"发布中..."];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [XXGP_ProgramProgressHUD hideHUDAnimated:YES];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发表成功" message:@"内容审核通过后8小时内会显示相关内容~" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *album = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:album];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];
        });
        
    }
}


- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}



#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordLimitCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
    [self wordLimit:textView];
}
#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        NSLog(@"%ld",text.text.length);
        self.SXHG_ConyTextV.editable = YES;
        
    }
    else{
        self.SXHG_ConyTextV.editable = NO;
    
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_SXHG_ConyTextV resignFirstResponder];
    [_textField resignFirstResponder];
}




@end

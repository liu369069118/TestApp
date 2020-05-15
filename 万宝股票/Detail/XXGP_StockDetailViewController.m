
#import "AFNetworking.h"
#import "XXGP_GUPTableViewCell.h"

#import "XXGP_StockDetailViewController.h"
#import "XXGP_EditOptionalViewController.h"
#import "ZFJSegmentedControl.h"
#import "UIImageView+WebCache.h"
#import "XXGP_GPListViewController.h"




@interface XXGP_StockDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *seg;
@property (weak, nonatomic) IBOutlet UIImageView *ps;

@property (weak, nonatomic) IBOutlet UILabel *gj;
@property (weak, nonatomic) IBOutlet UILabel *zf;

@property (weak, nonatomic) IBOutlet UILabel *ltz;
@property (weak, nonatomic) IBOutlet UILabel *zf2;
@property (weak, nonatomic) IBOutlet UILabel *jm;
@property (weak, nonatomic) IBOutlet UILabel *jjm;
@property (weak, nonatomic) IBOutlet UILabel *last;
@property (weak, nonatomic) IBOutlet UILabel *jtj;
@property (weak, nonatomic) IBOutlet UILabel *ztj;
@property (weak, nonatomic) IBOutlet UILabel *cjl;
@property (weak, nonatomic) IBOutlet UILabel *hsl;
@property (weak, nonatomic) IBOutlet UILabel *zg;
@property (weak, nonatomic) IBOutlet UILabel *zd;
@property (weak, nonatomic) IBOutlet UILabel *zsz;
@property (weak, nonatomic) IBOutlet UILabel *syl;

@property (weak, nonatomic) IBOutlet UILabel *mname;

@end

@implementation XXGP_StockDetailViewController

- (void)initSCommonViews {
    self.hidesBottomBarWhenPushed = YES;
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *l = [XXGP_Uitl mainDataList];
    for (NSDictionary *d in l) {
        if ([d[@"code"] isEqualToString:self.gpcode]) {
            self.gid = [NSString stringWithFormat:@"%lu", (unsigned long)[l indexOfObject:d]];
            self.title = d[@"XXGP_sname"];
        }
    }
    if (!self.gid) {
        return;
    }
    
    NSDictionary *dict = l[self.gid.intValue];
    self.title = [NSString stringWithFormat:@"%@", dict[@"XXGP_sname"]];
    
    self.navigationItem.leftBarButtonItem = self.XXGP_NaviBackButton;
    
//    if ([self has]) {
//        [self addRightBarButtonItemWithTitle:@"删除自选" action:@selector(sc)];
//    } else {
//        [self addRightBarButtonItemWithTitle:@"添加自选" action:@selector(tj)];
//    }
}

- (BOOL)isgp {
    return 1;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:1];
}

- (void)tj {
    
    
    NSString *keyStr = [NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gpcode];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [XXGP_ProgramProgressHUD showText:@"添加股票成功"];
    
//    [self addRightBarButtonItemWithTitle:@"删除自选" action:@selector(sc)];
}
- (void)sc {
    
    
    NSString *keyStr = [NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gpcode];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [XXGP_ProgramProgressHUD showText:@"删除股票成功"];
    
//    [self addRightBarButtonItemWithTitle:@"添加自选" action:@selector(tj)];
}

- (BOOL)has {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gpcode]];;
}

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
    [self initSCommonViews];
    self.navigationItem.leftBarButtonItem = self.XXGP_NaviBackButton;
    // Do any additional setup after loading the view from its nib.
    //    self.gpcode = @"sz300066";
    UIScrollView *sc = self.view;
    sc.contentSize = CGSizeMake(kScreenWidth, 1000+100);
    
    NSArray *titleArr = @[ @"分时", @"日K", @"周K", @"月K" ];
    
    ZFJSegmentedControl *SXHGSegment = [[ZFJSegmentedControl alloc] initwithTitleArr:titleArr iconArr:nil SCType:SCType_Underline];
    SXHGSegment.frame = CGRectMake(0, 0, _seg.width - 20, 47);
    SXHGSegment.centerX = (kScreenWidth - 20) / 2;
    SXHGSegment.backgroundColor = [UIColor clearColor];
    SXHGSegment.titleColor = [UIColor lightGrayColor];
    SXHGSegment.selectBtnSpace = 15;         //设置按钮间的间距
    //    zvc.selectBtnWID = 70;//设置按钮的宽度 不设就是均分
    SXHGSegment.SCType_Underline_HEI = 2;    //设置底部横线的高度
    SXHGSegment.titleFont = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    
    
    NSString *t1 = [NSString stringWithFormat:@"https://image.sinajs.cn/newchart/min/n/%@.png", _gpcode];
    NSString *t2 = [NSString stringWithFormat:@"https://image.sinajs.cn/newchart/daily/n/%@.png", _gpcode];
    NSString *t3 = [NSString stringWithFormat:@"https://image.sinajs.cn/newchart/daily/n/%@.png", _gpcode];
    NSString *t4 = [NSString stringWithFormat:@"https://image.sinajs.cn/newchart/monthly/n/%@.png", _gpcode];
    
    
    [_ps sd_setImageWithURL:[NSURL URLWithString:t1]
                  completed:nil];
    
    WEAKSELF;
    SXHGSegment.selectType = ^(NSInteger selectIndex, NSString *selectIndexTitle) {
        if (selectIndex == 0) {
            [weakSelf.ps sd_setImageWithURL:[NSURL URLWithString:t1]];
        } else if (selectIndex == 1) {
            [weakSelf.ps sd_setImageWithURL:[NSURL URLWithString:t2]];
        } else if (selectIndex == 2) {
            [weakSelf.ps sd_setImageWithURL:[NSURL URLWithString:t3]];
        } else {
            [weakSelf.ps sd_setImageWithURL:[NSURL URLWithString:t4]];
        }
    };
    [_seg addSubview:SXHGSegment];
    
    _seg.userInteractionEnabled = 1;
    
    [self getStock];
    
    XXGP_GPListViewController *vc = [XXGP_GPListViewController new];
    NSMutableArray *l = [XXGP_Uitl mainDataList];
    NSMutableArray *ls = [NSMutableArray new];
    [ls addObjectsFromArray:@[l[60],l[70],l[71],l[75],l[30],l[32],l[39]]];
    vc.stocks = ls;
    vc.view.top = 550;
    
    [self.view addSubview:vc.view];
    
    [self addChildViewController:vc];
}
- (void)getStock

{
    //1.创建会话管理者
    NSString *t1 = [NSString stringWithFormat:@"https://hq.sinajs.cn/list=%@", _gpcode];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:t1];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress *_Nonnull downloadProgress) {
        
        NSLog(@"%f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL *_Nonnull(NSURL *_Nonnull targetPath, NSURLResponse *_Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse *_Nonnull response, NSURL *_Nullable filePath, NSError *_Nullable error) {
        
        NSString *path = filePath;
        NSError *e = nil;
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:encode error:&e];
        //取出每一行的数据
        NSArray *_allLinedStrings = [fileContents componentsSeparatedByString:@","];
        NSLog(@"%@", _allLinedStrings);
        
        if (_allLinedStrings.count < 5) {
            return;
        }
        self.title = [_allLinedStrings[0] componentsSeparatedByString:@"\""][1];
        
        _mname.text = self.title;
        
        self.jtj.text = _allLinedStrings[1];
        
        _ztj.text = _allLinedStrings[2];
        
        self.gj.text = _allLinedStrings[3];
        
        self.zg.text = _allLinedStrings[4];
        
        self.zd.text = _allLinedStrings[5];
        _cjl.text = _allLinedStrings[8];
        _hsl = _allLinedStrings[9];
        
        _zsz.text = _allLinedStrings[6];
        
        _jjm.text = _allLinedStrings[7];
        
        if ([self.title containsString:@"指"]) {
            _zsz.text = @"--";
            _jjm.text = @"--";
        }
        double a = [_allLinedStrings[4] doubleValue];
        double b = [_allLinedStrings[5] doubleValue];
        
        _last.text =  [NSString stringWithFormat:@"%.2f",(a -b)/b];
        
    }];
    
    
    [download resume];
    
}


-(void)viewDidLayoutSubviews{
    self.view.width = kScreenWidth;
    _seg.width = kScreenWidth - 20;
}



@end

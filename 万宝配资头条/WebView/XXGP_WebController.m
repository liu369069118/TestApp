
#import "XXGP_WebController.h"
#import <WebKit/WebKit.h>

@interface XXGP_WebController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation XXGP_WebController

- (instancetype)init {
    if (self = [super init]) {
        _isShowProgressView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btn_navigation_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    if (_navTitle.length > 0) {
        label.text = _navTitle;
    } else {
        label.text = @"资讯";
    }
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    
    UIView *titleView = [[UIView alloc] init];
    [titleView addSubview:label];
    [titleView addSubview:backButton];
    [self.view addSubview:titleView];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
        make.left.mas_equalTo(20);
        make.width.height.mas_equalTo(30);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kHCNavigationBarHeight);
    }];
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.backgroundColor = [UIColor clearColor];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [self.view addSubview:webView];
    _webView = webView;
    
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kHCNavigationBarHeight, kScreenWidth, 1)];
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kHCNavigationBarHeight);
    }];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;

            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    if (_isShowProgressView) {
        self.progressView.hidden = NO;
    } else {
        self.progressView.hidden = YES;
    }
    
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

/// >>> 判断链接是否允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.host containsString:@"news"] ||
        [navigationAction.request.URL.absoluteString containsString:@"/m/live"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    
    decisionHandler(WKNavigationActionPolicyCancel);
}
@end

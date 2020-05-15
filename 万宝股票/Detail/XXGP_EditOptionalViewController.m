
#import "XXGP_EditOptionalViewController.h"
#import "XXGP_OPtiondicorationEditCell.h"

static const CGFloat topViewHeight = 30;
static const CGFloat bottomViewHeight = 40;

@interface XXGP_EditOptionalViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *contentListTable;
@property (nonatomic, strong) UIButton *deleteBtn;         //最下方的删除按钮
@property (nonatomic, strong) UIView *bottomContainView;          //最下方的背景视图
@property (nonatomic, strong) NSMutableArray *deleteQueue; //删除队列，记录要删除项的下标(NSIndexPath)
@property (nonatomic, strong) NSMutableArray *original;    //删除队列，记录要删除项的下标(NSIndexPath)

@end

@implementation XXGP_EditOptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = 1;
    self.SXHG_ContetListGroups = [NSMutableArray new];
    self.original = [NSMutableArray new];
    [self getRequestMessageListDatass];
    [self initNavigationItem];
    [self initSCommonViews];
}

- (void)getRequestMessageListDatass {
    NSMutableArray *all = [XXGP_Uitl mainDataList];
    [self.SXHG_ContetListGroups removeAllObjects];
    
    for (int i = 0; i < all.count; i++) {
        NSDictionary *dict = all[i];

        NSString *str =  [NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,dict[@"code"]];
      BOOL isHad =  [[NSUserDefaults standardUserDefaults] boolForKey:str];
        
        
        if (isHad) {
            [self.SXHG_ContetListGroups addObject:all[i]];
            [self.original addObject:all[i]];
        }
    }
    if (self.SXHG_ContetListGroups.count == 0) {
        [XXGP_ProgramProgressHUD showText:@"暂未添加股票"];
    }
    
}

- (void)initNavigationItem {
    self.title = @"自选股";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = self.SXHG_NaviBackButton;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)deleteCode:(NSString*)code{
    NSMutableArray *l = [XXGP_Uitl mainDataList];
    //    self.gpcode = @"00769";
    for (NSDictionary *d in l) {
        if ([d[@"code"] isEqualToString:code]) {
            //            self.gid = [NSString stringWithFormat:@"%d",[l indexOfObject:d]];
//            [[NSUserDefaults standardUserDefaults] setObject:@"nhas" forKey:[NSString stringWithFormat:@"gp%d", [l indexOfObject:d]]];
//

            NSString *str =  [NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,d[@"code"]];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:str];
                              [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

-(NSInteger)getIndex:(NSString*)code{
    NSMutableArray *l = [XXGP_Uitl mainDataList];
    //    self.gpcode = @"00769";
    for (NSDictionary *d in l) {
        if ([d[@"code"] isEqualToString:code]) {
            return [l indexOfObject:d];
        }
    }
    return 0;
}

- (void)SXHG_NaviBackButtonClicked {
    
    for (NSDictionary* d in self.original) {
        
        if (![self.SXHG_ContetListGroups containsObject:d]) {
            [self deleteCode:d[@"code"]];
            
        }
    }
    NSMutableString *stockOrderString = [NSMutableString new];
    for (NSDictionary* d  in _SXHG_ContetListGroups) {
        if ( [d[@"code"] length]) {
            
            
            [stockOrderString appendString:[NSString stringWithFormat:@"%d-",[self getIndex:d[@"code"]]]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:stockOrderString forKey:@"stockOrderString"];
    NSLog(@"%@", stockOrderString);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initSCommonViews {
    //创建头部视图
    UIView *topContainView = [[UIView alloc] init];
    topContainView.backgroundColor = HCColor(219, 219, 219);
    [self.view addSubview:topContainView];
    [topContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(topViewHeight);
    }];
    
    //名称代码
    UILabel *nameCodeLB = [[UILabel alloc] init];
    nameCodeLB.backgroundColor = [UIColor clearColor];
    nameCodeLB.text = @"名称代码";
    nameCodeLB.textAlignment = NSTextAlignmentLeft;
    nameCodeLB.font = [UIFont systemFontOfSize:15];
    [topContainView addSubview:nameCodeLB];
    [nameCodeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topContainView).offset(0);
        make.left.equalTo(topContainView).offset(48);
        make.width.mas_equalTo(100);
    }];
    
    //置顶
    UILabel *stickLB = [[UILabel alloc] init];
    stickLB.backgroundColor = [UIColor clearColor];
    stickLB.text = @"置顶";
    stickLB.textAlignment = NSTextAlignmentRight;
    stickLB.font = [UIFont systemFontOfSize:15];
    [topContainView addSubview:stickLB];
    [stickLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topContainView).offset(0);
        make.left.equalTo(topContainView.mas_right).offset(-230);
        make.width.mas_equalTo(100);
    }];
    
    //拖动
    UILabel *dragLab = [[UILabel alloc] init];
    dragLab.backgroundColor = [UIColor clearColor];
    dragLab.text = @"拖动";
    dragLab.textAlignment = NSTextAlignmentRight;
    dragLab.font = [UIFont systemFontOfSize:15];
    [topContainView addSubview:dragLab];
    [dragLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topContainView).offset(0);
        make.right.equalTo(topContainView.mas_right).offset(-10);
        make.width.mas_equalTo(50);
    }];
    
    //创建tableView
    self.contentListTable = ({
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, kScreenWidth, kScreenHeight - topViewHeight - bottomViewHeight - kHCStatusBarHeight - 44 - kHCTabbarHeight) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 46;
        [tableView registerNib:[UINib nibWithNibName:@"XXGP_OPtiondicorationEditCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XXGP_OPtiondicorationEditCell"];
        [self.view addSubview:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView;
    });
    self.contentListTable.editing = YES; //必须在外面设置tableView的编辑状态
    
    //创建底部视图 - 删除
    self.bottomContainView = [[UIView alloc] init];
    self.bottomContainView.backgroundColor = [UIColor lightGrayColor];
    self.bottomContainView.frame = CGRectMake(0, kScreenHeight - bottomViewHeight - kHCStatusBarHeight+20 , kScreenWidth, bottomViewHeight);
    [self.view addSubview:self.bottomContainView];
    if(self.laoda.length){
//        self.bottomView.top-=44;
    }
    //删除
    UIImageView *deteleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SXHG_optional_delete"]];
    deteleImageView.backgroundColor = [UIColor clearColor];
    [self.bottomContainView addSubview:deteleImageView];
    [deteleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomContainView).offset(5);
        make.bottom.equalTo(self.bottomContainView.mas_bottom).offset(-5);
        make.center.equalTo(self.bottomContainView);
    }];
    
    //删除按钮
    self.deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteBtn.backgroundColor = [UIColor clearColor];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.deleteBtn.userInteractionEnabled = NO; //初始关闭删除按钮的交互
    [self.bottomContainView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.bottomContainView);
        make.height.equalTo(@44);
    }];
}

#pragma mark - 删除自选事件
- (void)deleteAction {
    //注意：界面上是支持多只股票删除的，同样服务器端也需要支持
    //1.删除服务器数据(删除成功后再执行下面的操作)
    NSLog(@"成功删除服务器数据");
    //2.删除数据源数据(这里也不能使用循环删除的方式，因为删除操作会引起数组容量的变化，导致数组越界等问题)
    //用下面这种方式删除多个不连续的元素
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet]; //用于记录_SXHG_ContetListGroups要删除元素的Indexes
    for (NSIndexPath *indexPath in self.deleteQueue) {
        [indexes addIndex:(NSUInteger) indexPath.row];
    }
    [self.SXHG_ContetListGroups removeObjectsAtIndexes:indexes];
    
    
    
    //3.删除界面
    [self.contentListTable reloadData];
    //4.清空删除队列
    [self.deleteQueue removeAllObjects];
    //5.改变底部视图的颜色
    self.bottomContainView.backgroundColor = [UIColor lightGrayColor];
    //6.关闭按钮的交互
    self.deleteBtn.userInteractionEnabled = NO;
}

#pragma mark - #pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.SXHG_ContetListGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXGP_OPtiondicorationEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XXGP_OPtiondicorationEditCell"];
    if (self.SXHG_ContetListGroups.count > 0) {
        cell.model = self.SXHG_ContetListGroups[indexPath.row];
    }
    //置顶事件的回调
    WEAKSELF;
    cell.buttonClickBlock = ^(XXGP_OPtiondicorationEditCell *cell) {
        //根据cell获取下标
        NSIndexPath *fromIndexPath = [self.contentListTable indexPathForCell:cell];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        id object = [self.SXHG_ContetListGroups objectAtIndex:fromIndexPath.row];
        [self.SXHG_ContetListGroups removeObjectAtIndex:fromIndexPath.row];
        [self.SXHG_ContetListGroups insertObject:object atIndex:toIndexPath.row];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XXGP_OPtiondicorationEditCell *cell = (XXGP_OPtiondicorationEditCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell layoutSubviews];
    //1.判断此时是删除队列是否为空
    if (self.deleteQueue.count == 0) {
        //2.改变底部视图的颜色
        self.bottomContainView.backgroundColor = [UIColor jkr_colorWithHexString:@"0xd43d3d"];
        //3.打开删除按钮的交互
        self.deleteBtn.userInteractionEnabled = YES;
    }
    //4.将改cell的下标加入到删除队列中
    [self.deleteQueue addObject:indexPath];
}

//取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XXGP_OPtiondicorationEditCell *cell = (XXGP_OPtiondicorationEditCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell layoutSubviews];
    //1.将改cell的下标从删除队列中移除
    [self.deleteQueue removeObject:indexPath];
    //2.判断此时是删除队列是否为空
    if (self.deleteQueue.count == 0) {
        //3.改变底部视图的颜色
        self.bottomContainView.backgroundColor = [UIColor lightGrayColor];
        //4.关闭按钮的交互
        self.deleteBtn.userInteractionEnabled = NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    id object = [self.SXHG_ContetListGroups objectAtIndex:fromIndexPath.row];
    [self.SXHG_ContetListGroups removeObjectAtIndex:fromIndexPath.row];
    [self.SXHG_ContetListGroups insertObject:object atIndex:toIndexPath.row];
}

#pragma mark - Getters
- (NSMutableArray *)deleteQueue {
    if (!_deleteQueue) {
        _deleteQueue = [NSMutableArray array];
    }
    return _deleteQueue;
}

@end

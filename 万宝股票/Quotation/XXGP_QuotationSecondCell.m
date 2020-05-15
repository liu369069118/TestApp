
#import "XXGP_QuotationSecondCell.h"
#import "XXGP_QuotationFirstModel.h"
#import <YYModel/YYModel.h>
#import "XXGP_StockDetailViewController.h"

@interface XXGP_QuotationSecondCell ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation XXGP_QuotationSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, kScreenWidth, 90);
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_mainScrollView];
        
        [self createContentViews];
    }
    return self;
}

- (void)createContentViews {
    NSArray *list = [self getResponceListData];
    CGFloat margin = 15;
    CGFloat submargin = 10;
    CGFloat view_x = margin;
    CGFloat view_y = 0;
    CGFloat btnW = (kScreenWidth - 50) / 3;
    
    for (int i = 0; i < list.count; i++) {
        UIView *plateView = [self createPlateView:list[i]];
        plateView.frame = CGRectMake(view_x, view_y, btnW, 90);
        plateView.tag = 10000+i;
        [plateView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNextVC:)]];
        
        [_mainScrollView addSubview:plateView];
        
        view_x += btnW + submargin;
        if ((i+1)%4 == 0) {
            view_y += btnW + submargin;
            view_x = margin;
        }
    }
}

- (UIView *)createPlateView:(XXGP_QuotationFirstModel *)model {
    UIView *plateView = [[UIView alloc] init];
    plateView.backgroundColor = [HCColor whiteColor];
    
    UILabel *nameLabel = [self createLabel:model.block fontSizr:14];
    nameLabel.textColor = [UIColor blackColor];
    [plateView addSubview:nameLabel];
    
    UILabel *titleLabel = [self createLabel:model.name fontSizr:18];
    titleLabel.textColor = HCColor(255, 69, 0);
    [plateView addSubview:titleLabel];
    
    UILabel *subnameLabel = [self createLabel:model.percent fontSizr:12];
    subnameLabel.textColor = HCColor(255, 69, 0);
    subnameLabel.font = kHCBoldFont12;
    [plateView addSubview:subnameLabel];
    
    UILabel *rateLabel = [self createLabel:model.containtopTitle fontSizr:12];
    rateLabel.textColor = HCColor(255, 69, 0);
    rateLabel.font = kHCBoldFont12;
    [plateView addSubview:rateLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(nameLabel.mas_bottom);
    }];
    
    [subnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
    }];
    
    [rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
    }];
    
    return plateView;
}

- (UILabel *)createLabel:(NSString *)text fontSizr:(NSInteger)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [HCFont pingfangRegular:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}


- (NSArray *)getResponceListData {
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"XXGP_SecondCellData"];
    NSMutableArray *list  = [homeDict objectForKey:@"list"];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dict in list) {
        XXGP_QuotationFirstModel *model = [XXGP_QuotationFirstModel yy_modelWithDictionary:dict];
        [result addObject:model];
    }
    
    return result;
}

- (void)goNextVC:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 10000;
    
    NSArray *list  = [self getResponceListData];
    XXGP_QuotationFirstModel *model = list[tag];
    
    XXGP_StockDetailViewController *detailvc = [XXGP_StockDetailViewController new];
    detailvc.hidesBottomBarWhenPushed = YES;
    detailvc.gpcode = model.code;
    [self.jkr_viewController.navigationController pushViewController:detailvc animated:YES];
}

@end

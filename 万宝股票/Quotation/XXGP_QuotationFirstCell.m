
#import "XXGP_QuotationFirstCell.h"
#import "XXGP_QuotationFirstModel.h"
#import <YYModel/YYModel.h>
#import "XXGP_StockDetailViewController.h"

#define kXXGP_PlateViewWidth (kScreenWidth - 20 - 15 - 15 - 20) / 3

@interface XXGP_QuotationFirstCell ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation XXGP_QuotationFirstCell

+ (CGFloat)XXGP_auotationFirstCellHeight {
    return 10 + kXXGP_PlateViewWidth * 4 - 5;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.frame = CGRectMake(15, 0, kScreenWidth - 30, 40);
        topLabel.text = @"热门板块";
        topLabel.font = [HCFont pingfangMedium:18];
        topLabel.textColor = [UIColor blackColor];
        topLabel.backgroundColor = [UIColor whiteColor];
        topLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:topLabel];
        
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 40, kScreenWidth, [XXGP_QuotationFirstCell XXGP_auotationFirstCellHeight]);
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
    CGFloat view_x = 20;
    CGFloat view_y = 10;
    CGFloat btnW = kXXGP_PlateViewWidth;
    CGFloat btnH = btnW - 15;
    
    for (int i = 0; i < list.count; i++) {
        UIView *plateView = [self createPlateView:list[i]];
        plateView.frame = CGRectMake(view_x, view_y, btnW, btnH);
        plateView.tag = 10000+i;
        [plateView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNextVC:)]];
        
        [_mainScrollView addSubview:plateView];
        
        view_x += btnW + margin;
        if ((i+1)%3 == 0) {
            view_y += btnH + margin;
            view_x = 20;
        }
    }
}

- (UIView *)createPlateView:(XXGP_QuotationFirstModel *)model {
    UIView *plateView = [[UIView alloc] init];
    plateView.backgroundColor = [HCColor whiteColor];
    plateView.layer.cornerRadius = 4.f;
    plateView.layer.shadowRadius = 4.f;
    plateView.layer.shadowColor = [UIColor blackColor].CGColor;
    plateView.layer.shadowOpacity = 0.3;
    plateView.layer.shadowOffset = CGSizeMake(0,0);
    
    UILabel *nameLabel = [self createLabel:model.block fontSize:14];
    [plateView addSubview:nameLabel];
    
    UILabel *titleLabel = [self createLabel:model.containtopTitle fontSize:13];
    [plateView addSubview:titleLabel];
    
    UILabel *subnameLabel = [self createLabel:model.name fontSize:11];
    [plateView addSubview:subnameLabel];
    
    UILabel *rateLabel = [self createLabel:model.percent fontSize:11];
    [plateView addSubview:rateLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    
    [subnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.bottom.mas_equalTo(-10);
    }];
    
    [rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(subnameLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(-10);
    }];
    
    return plateView;
}

- (UILabel *)createLabel:(NSString *)text fontSize:(NSInteger)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [HCFont pingfangRegular:fontSize];
    label.textColor = [HCColor articleBlack_A70];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (NSMutableArray *)getResponceListData {
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"XXGP_FirstCellData"];
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

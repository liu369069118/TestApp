
#import "XXGP_QuotationThirdCell.h"
#import "XXGP_QuotationFirstModel.h"
#import <YYModel/YYModel.h>
#import "XXGP_StockDetailViewController.h"

@implementation XXGP_QuotationThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.frame = CGRectMake(15, 0, kScreenWidth, 50);
        topLabel.text = @"股票列表";
        topLabel.font = [HCFont pingfangMedium:18];
        topLabel.textColor = [UIColor blackColor];
        topLabel.backgroundColor = [UIColor whiteColor];
        topLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:topLabel];
        
        [self createContentViews];
    }
    return self;
}

- (void)createContentViews {
    NSArray *list = [self getResponceListData];
    CGFloat margin = 15;
    CGFloat view_x = margin;
    CGFloat view_y = 50;
    CGFloat btnW = kScreenWidth - 30;
    CGFloat btnH = 60;
    for (int i = 0; i < list.count; i++) {
        UIView *plateView = [self createPlateView:list[i]];
        plateView.frame = CGRectMake(view_x, view_y, btnW, btnH);
        plateView.tag = 10000+i;
        [plateView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNextVC:)]];
        [self.contentView addSubview:plateView];
        
        view_y += btnH + 5;
    }
}

- (UIView *)createPlateView:(XXGP_QuotationFirstModel *)model {
    UIView *plateView = [[UIView alloc] init];
    plateView.backgroundColor = [HCColor whiteColor];
    plateView.layer.cornerRadius = 30.f;
    plateView.layer.borderColor = HCColor(255, 69, 0).CGColor;
    plateView.layer.borderWidth = 0.5;
    
    
    UILabel *centerLabel = [self createLabel:model.block fontSizr:18];
    centerLabel.textColor = [HCColor articleBlack_A70];
    [plateView addSubview:centerLabel];
    
    UILabel *subCenterLabel = [self createLabel:model.code fontSizr:12];
    subCenterLabel.textColor = [HCColor articleBlack_A30];
    [plateView addSubview:subCenterLabel];
    
    UILabel *leftLabel = [self createLabel:model.containtopTitle fontSizr:17];
    leftLabel.textColor = HCColor(255, 69, 0);
    [plateView addSubview:leftLabel];
    
    UILabel *rightLabel = [self createLabel:model.percent fontSizr:17];
    rightLabel.textColor = HCColor(255, 69, 0);
    [plateView addSubview:rightLabel];
    
    
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.centerX.mas_offset(0);
    }];
    
    [subCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-7);
        make.centerX.mas_offset(0);
    }];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.centerY.mas_offset(0);
        make.height.mas_offset(20);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-50);
        make.centerY.mas_offset(0);
        make.height.mas_offset(20);
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

- (void)goNextVC:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 10000;
    
    NSMutableArray *list  = [self getResponceListData];
    XXGP_QuotationFirstModel *model = list[tag];
    
    XXGP_StockDetailViewController *detailvc = [XXGP_StockDetailViewController new];
    detailvc.hidesBottomBarWhenPushed = YES;
    detailvc.gpcode = model.code;
    [self.jkr_viewController.navigationController pushViewController:detailvc animated:YES];
}

- (NSMutableArray *)getResponceListData {
    NSDictionary *homeDict = [XXGP_Uitl readLocalFileWithName:@"XXGP_ThirdCellData"];
    NSMutableArray *list  = [homeDict objectForKey:@"list"];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dict in list) {
        XXGP_QuotationFirstModel *model = [XXGP_QuotationFirstModel yy_modelWithDictionary:dict];
        [result addObject:model];
    }
    
    return result;
}

@end

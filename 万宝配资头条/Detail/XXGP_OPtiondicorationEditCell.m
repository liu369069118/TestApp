
#import "XXGP_OPtiondicorationEditCell.h"

@interface XXGP_OPtiondicorationEditCell ()

@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *stockCode;
@property (weak, nonatomic) IBOutlet UIButton *stickBtn;//置顶

@end

@implementation XXGP_OPtiondicorationEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutSubviews];
}


//置顶按钮的点击事件
- (IBAction)buttonClickAaction:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(self);
    }
}

- (void)setModel:(NSDictionary *)model {
     _stockName.text = model[@"XXGP_sname"];//名字去除头部空格
    _stockCode.text = model[@"code"];
}

// 修改TableViewCell在编辑模式下选中按钮的图片
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSString * ks = [NSString stringWithFormat:@"%@-----%@",@"UITableViewCell" ,@"EditControl"];
    
    for (UIControl *control in self.subviews) {
        if (![control isMemberOfClass:NSClassFromString([ks stringByReplacingOccurrencesOfString:@"-" withString:@""])]){
            continue;
        }
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            UIImageView *imageView = (UIImageView *)subView;
            imageView.size = CGSizeMake(15, 15);
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            if (self.selected) {
                imageView.image = [UIImage imageNamed:@"XXGP_selected"]; // 选中时的图片
            } else {
                imageView.image = [UIImage imageNamed:@"XXGP_normal"];   // 未选中时的图片
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end

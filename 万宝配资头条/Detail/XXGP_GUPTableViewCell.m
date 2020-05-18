
#import "XXGP_GUPTableViewCell.h"

@implementation XXGP_GUPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.contentView.width = kScreenWidth;
        MyLinearLayout *l = [self.contentView viewWithTag:2000];
        l.orientation = MyOrientation_Horz;

        for (UIView *scontentView in l.subviews) {
            if ([scontentView isKindOfClass:[UIButton class]]) {
                continue;
            }
            scontentView.width = kScreenWidth / 3;
            if (scontentView.height <= 1) {
                scontentView.width = kScreenWidth;
                //                v.left = 25;
                scontentView.left = 0;
                scontentView.height = 0.5;
                scontentView.backgroundColor = [UIColor lightGrayColor];
            } else {
                scontentView.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    return self;
}

- (void)layoutSubviews {
    _xy.left = 0;
    self.width = kScreenWidth;
}
- (void)update:(NSDictionary *)dict {
    _nb.text = dict[@"per"];
    _per.text = dict[@"gpperate"];
    _xy.text = dict[@"code"];
    _t.text = dict[@"XXGP_sname"];

    NSMutableArray *l = [XXGP_Uitl mainDataList];
    //    self.gpcode = @"00769";
    for (NSDictionary *d in l) {
        if ([d[@"code"] isEqualToString:dict[@"code"]]) {
            self.gid = [NSString stringWithFormat:@"%d",[l indexOfObject:d]];
        }
    }

    if (_acd % 2 && _acd != 3) {
        _per.textColor = [UIColor greenColor];

    } else {
        _per.textColor = [UIColor redColor];
    }
    
    if ([self has]) {
        [_bt setTitle:@"删除自选" forState:UIControlStateNormal];
        [_bt setBackgroundColor:[HCColor colorWithHexString:@"0x278d3b"]];
        
    } else {
        [_bt setTitle:@"加入自选" forState:UIControlStateNormal];
        [_bt setBackgroundColor:[UIColor redColor]];
    }
    
}
- (IBAction)jrzx:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"加入自选"]) {
        [button setTitle:@"删除自选" forState:UIControlStateNormal];
        [self jrzxTj];
        [button setBackgroundColor:[HCColor colorWithHexString:@"0x278d3b"]];

    } else {
        [button setTitle:@"加入自选" forState:UIControlStateNormal];
        [self addSelectArr];
        [button setBackgroundColor:[UIColor redColor]];
    }
}

- (void)jrzxTj {

          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gid]];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [XXGP_ProgramProgressHUD showText:@"添加股票成功"];
}
- (void)addSelectArr {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gid]];
    [XXGP_ProgramProgressHUD showText:@"删除股票成功"];
}

- (BOOL)has {
//    return [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"gp%d", self.gid.intValue ]] isEqualToString:@"has"];
//    
    
  return   [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gid]];
    
//           [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@_%@",kSXHGW_SeletCell,self.gid]];
    
}

@end

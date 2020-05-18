

#import "XXGP_AlertViewController.h"

@interface XXGP_AlertViewController ()

@end

@implementation XXGP_AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.source == XXGP_AlertViewSourceTypeJub) {
        [self addAction:[UIAlertAction actionWithTitle:@"内容包含政治敏感信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self showToastTitleWithNotice];
                  }]];
        [self addAction:[UIAlertAction actionWithTitle:@"内容包含赌博信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self showToastTitleWithNotice];
                }]];
        [self addAction:[UIAlertAction actionWithTitle:@"内容包含色情信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self showToastTitleWithNotice];
                      }]];
        [self addAction:[UIAlertAction actionWithTitle:@"内容包含政治信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                           [self showToastTitleWithNotice];
                     }]];
     
    }

        [self addAction:[UIAlertAction actionWithTitle:@"取消 " style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          }]];
}


- (void)showToastTitleWithNotice{
    [[KNToast shareToast] initWithText:@"举报成功，我们会在8小时内对这条信息进行审核"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

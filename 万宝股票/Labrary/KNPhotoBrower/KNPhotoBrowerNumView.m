
#import "KNPhotoBrowerNumView.h"

@implementation KNPhotoBrowerNumView

- (instancetype)init{
    if (self = [super init]) {
        [self setFont:[HCFont pingfangRegular:16]];
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentLeft];
    }
    return self;
}

- (void)setCurrentNum:(NSInteger)currentNum totalNum:(NSInteger)totalNum{
    _currentNum = currentNum;
    _totalNum = totalNum;
    [self changeText];
}

- (void)changeText{
    self.text = [NSString stringWithFormat:@"%zd / %zd",_currentNum,_totalNum];
}

- (void)setCurrentNum:(NSInteger)currentNum{
    _currentNum = currentNum;
    [self changeText];
}

- (void)setTotalNum:(NSInteger)totalNum{
    _totalNum = totalNum;
    [self changeText];
}

@end

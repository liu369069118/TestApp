
#import "HCResponseModel.h"

@implementation HCResponseModel

+ (instancetype)responseModelWithError:(NSError *)error{
    HCResponseModel *model = [[HCResponseModel alloc] init];
    model.error = error;
    model.message = error.localizedDescription;
    model.code = -1;
    return model;
}

- (BOOL)success {
    return (self.code == 1);
}

- (NSArray<NSDictionary *> *)list{
    return [self.data getArray:@"list"];
}

- (BOOL)isEnd{
    NSString *isEnd = [self.data getString:@"is_end"];
    if (!isEnd.length) {
        return true;
    }
    return [NotNullString(isEnd) boolValue];
}

- (NSInteger)page_refer{
    NSNumber *pageRefer = [self.data getNumber:@"page_refer"];
    return [pageRefer integerValue];
}

@end

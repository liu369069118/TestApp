
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_HomeNewNewsModel : NSObject

@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *webrsid;
@property (nonatomic, copy) NSString *uniqueid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *viewType;
@property (nonatomic, copy) NSString *stockState;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *thumbImg;
@property (nonatomic, copy) NSString *commentNum;

@property (nonatomic, strong) NSArray <NSDictionary *>*tags;

@end

NS_ASSUME_NONNULL_END

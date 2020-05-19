
#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXGP_newCommunityModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *imgList;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *commentSrc;
@property (nonatomic, copy) NSString *NewCommentSrc;
@property (nonatomic, copy) NSString *actionKey;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *NewContentUrl;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDetail;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *avatarWebrsid;
@property (nonatomic, copy) NSString *webrsid;
@property (nonatomic, copy) NSString *commentWebrsid;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *tagInfo;
@property (nonatomic, copy) NSString *topic;
@property (nonatomic, copy) NSString *topicUrl;
@property (nonatomic, copy) NSString *topicWebrsid;
@property (nonatomic, copy) NSString *isMember;
@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong) NSDictionary *likesModel;

@end

NS_ASSUME_NONNULL_END

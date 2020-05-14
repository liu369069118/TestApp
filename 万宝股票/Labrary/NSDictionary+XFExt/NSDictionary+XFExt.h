




#import <Foundation/Foundation.h>

@interface NSDictionary (XFExt)

- (NSString *)getString:(NSString *)key;
- (NSString *)getNotNilString:(NSString *)key;
- (NSNumber *)getNumber:(NSString *)key;
- (NSArray *)getArray:(NSString *)key;
- (NSDictionary *)getObject:(NSString *)key;
- (BOOL)getBOOL:(NSString *)key;

- (BOOL)hasString:(NSString *)key;
- (BOOL)hasNumber:(NSString *)key;
- (BOOL)hasArray:(NSString *)key;
- (BOOL)hasObject:(NSString *)key;

- (NSNumber *)numberValueForKey:(NSString *)key default:(NSNumber *)def;
- (NSString *)stringValueForKey:(NSString *)key default:(NSString *)def;


@end

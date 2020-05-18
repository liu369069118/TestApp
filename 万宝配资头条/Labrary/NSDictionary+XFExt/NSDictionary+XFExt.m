


#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? nil : [JSON_ objectForKey:KEY_]


#import "NSDictionary+XFExt.h"

@implementation NSDictionary (XFExt)

- (NSString *)getString:(NSString *)key {
    id value = nilOrJSONObjectForKey(self, key);
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    } else {
        return nil;
    }
}

- (NSString *)getNotNilString:(NSString *)key {
    id value = nilOrJSONObjectForKey(self, key);
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    } else {
        return @"";
    }
}

- (NSNumber *)getNumber:(NSString *)key {
    id value = nilOrJSONObjectForKey(self, key);
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        return @([(NSString *)value doubleValue]);
    } else {
        return nil;
    }
}

- (NSArray *)getArray:(NSString *)key {
    id value = nilOrJSONObjectForKey(self, key);
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    } else {
        return nil;
    }
}

- (NSDictionary *)getObject:(NSString *)key {
    id value = nilOrJSONObjectForKey(self, key);
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    } else {
        return nil;
    }
}

- (BOOL)getBOOL:(NSString *)key {
    id value = nilOrJSONObjectForKey(self, key);
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *) value boolValue];
    } else if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"true"]) {
            return YES;
        } else if ([value integerValue] == 1) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (BOOL)hasString:(NSString *)key {
    return [self getString:key] != nil;
}

- (BOOL)hasNumber:(NSString *)key {
    return [self getNumber:key] != nil;
}

- (BOOL)hasArray:(NSString *)key {
    return [self getArray:key] != nil;
}

- (BOOL)hasObject:(NSString *)key {
    return [self getObject:key] != nil;
}

/// Get a number value from 'id'.
static NSNumber *NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

- (NSNumber *)numberValueForKey:(NSString *)key default:(NSNumber *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value);
    return def;
}

- (NSString *)stringValueForKey:(NSString *)key default:(NSString *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).description;
    return def;
}

@end

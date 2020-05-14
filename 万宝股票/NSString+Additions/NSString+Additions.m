//
//  NSString+Additions.m
//  hotbody
//
//  Created by Mr.Yang on 15/10/8.
//  Copyright © 2015年 Beijing Fitcare inc. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

@end

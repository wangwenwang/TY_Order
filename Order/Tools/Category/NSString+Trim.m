//
//  NSString+Trim.m
//  YBDriver
//
//  Created by 凯东源 on 16/8/30.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isEmpty {
    if([self isEqualToString:@""]) {
        return YES;
    }else {
        return NO;
    }
}

@end

//
//  NSDictionary+MyLog.m
//  Order
//
//  Created by 凯东源 on 16/11/16.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "NSDictionary+MyLog.h"

@implementation NSDictionary (MyLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    
    return str;
}

@end

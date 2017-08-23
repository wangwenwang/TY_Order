//
//  NSString+Trim.h
//  YBDriver
//
//  Created by 凯东源 on 16/8/30.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

/// 去除首尾空字符
- (NSString *)trim;

/// 判断string是否为空
- (BOOL)isEmpty;

@end

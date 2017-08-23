//
//  LocationModel.h
//  YBDriver
//
//  Created by 凯东源 on 16/9/7.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 客户地址信息
@interface LocationModel : NSObject

@property (copy, nonatomic) NSString *ID;

@property (copy, nonatomic) NSString *userIdx;

@property (assign, nonatomic) double CORDINATEX;

@property (assign, nonatomic) double CORDINATEY;

@property (copy, nonatomic) NSString *ADDRESS;

@property (strong, nonatomic) NSDate *CREATETIME;

- (void)setDict:(NSDictionary *)dict;

@end

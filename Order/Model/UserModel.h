//
//  UserModel.h
//  Order
//
//  Created by 凯东源 on 16/9/27.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/// 用户名
@property (copy, nonatomic) NSString *USER_NAME;

/// 用户类型
@property (copy, nonatomic) NSString *USER_TYPE;

/// 用户手机号
@property (copy, nonatomic) NSString *USER_CODE;

/// 用户唯一标识符
@property (copy, nonatomic) NSString *IDX;

@end

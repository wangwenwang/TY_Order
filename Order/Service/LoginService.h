//
//  LoginService.h
//  Order
//
//  Created by 凯东源 on 16/9/26.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginServiceDelegate <NSObject>

@optional
- (void)successOfLoginSelectBusinss:(NSMutableArray *)business;

@optional
- (void)failureOfLogin:(NSString *)msg;

@end

@interface LoginService : NSObject

@property (weak, nonatomic)id <LoginServiceDelegate> delegate;

/**
 * 登陆
 *
 * userName: 用户名
 *
 * password: 用户登陆密码
 *
 */
- (void)login:(NSString *)userName andPsw:(NSString *)psw;

@end

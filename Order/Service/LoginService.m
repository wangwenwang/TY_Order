//
//  LoginService.m
//  Order
//
//  Created by 凯东源 on 16/9/26.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "LoginService.h"
#import <AFNetworking.h>
#import "AppDelegate.h"

@interface LoginService ()

@property (strong, nonatomic) AppDelegate *app;

@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *psw;

@end

@implementation LoginService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)login:(NSString *)userName andPsw:(NSString *)psw {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"strUserName" : userName,
                                 @"strPassword" : psw,
                                 @"strLicense" : @""
                                 };
    
    NSLog(@"登录参数：%@", parameters);
    
    [manager POST:API_LOGIN parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            [self saveUserModelToAppDelegate:responseObject[@"result"] andUserName:userName];
            
            _userName = userName;
            _psw = psw;
            
            [self getBusinessList];
            
        }else {
            if([_delegate respondsToSelector:@selector(failureOfLogin:)]) {
                [_delegate failureOfLogin:msg];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@", error);
        if([_delegate respondsToSelector:@selector(failureOfLogin:)]) {
            [_delegate failureOfLogin:@"登录失败"];
        }
    }];
}

- (void)saveUserModelToAppDelegate:(NSArray *)arrResult andUserName:(NSString *)userName {
    NSDictionary *dictResult = arrResult[0];
    _app.user.USER_NAME = dictResult[@"USER_NAME"];
    _app.user.USER_TYPE = dictResult[@"USER_TYPE"];
    _app.user.IDX = dictResult[@"IDX"];
    _app.user.USER_CODE = userName;
}

// 储存账号密码在本地
- (void)saveUserNameAndPassword:(NSString *)userName andPassword:(NSString *)pwd {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSUserDefaults standardUserDefaults] setValue:userName forKey:udUserName];
        [[NSUserDefaults standardUserDefaults] setValue:pwd forKey:udPassWord];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        sleep(2);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
//            NSLog(@"fds:%@", dict);
//            
//            NSLog(@"");
//        });
//    });
}

/**
 * 获取用户的业务类型集合
 */
- (void)getBusinessList {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      _app.user.IDX, @"strUserIdx",
                      @"", @"strLicense",
                      nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSLog(@"请求业务类型参数:%@", parameters);
    
    [manager POST:API_GET_BUISNESS_LIST parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        NSArray *arrResult = responseObject[@"result"];
        
        if([arrResult isKindOfClass:[NSArray class]]) {
            if(arrResult.count == 0) {
                if([_delegate respondsToSelector:@selector(failureOfLogin:)]) {
                    [_delegate failureOfLogin:@"查询业务列表失败"];
                }
            }else if(arrResult.count >= 1) {
                
                [self saveUserNameAndPassword:_userName andPassword:_psw];
                
                if([_delegate respondsToSelector:@selector(successOfLoginSelectBusinss:)]) {
                    [_delegate successOfLoginSelectBusinss:responseObject[@"result"]];
                }
            }
        }else {
            if([_delegate respondsToSelector:@selector(failureOfLogin:)]) {
                [_delegate failureOfLogin:@"查询业务列表失败"];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"查询业务列表异常");
        NSLog(@"请求失败---%@", error);
        if([_delegate respondsToSelector:@selector(failureOfLogin:)]) {
            [_delegate failureOfLogin:@"查询业务列表失败"];
        }
    }];
}

@end

//
//  AddStockService.m
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddStockService.h"
#import <AFNetworking.h>

@implementation AddStockService

#define kAPIName @"添加客户库存"

#pragma mark - 添加客户库存

- (void)AddStock:(NSString *)reuslt {
    
    reuslt = reuslt ? reuslt : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"reuslt" : reuslt,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_AddStock parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfAddStock:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfAddStock:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfAddStock:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfAddStock:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfAddStock:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfAddStock:)]) {
        
        [_delegate successOfAddStock:msg];
    }
}


- (void)failureOfAddStock:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfAddStock:)]) {
        
        [_delegate failureOfAddStock:msg];
    }
}

@end

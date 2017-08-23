//
//  Store_GetOupputInfoService.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "Store_GetOupputInfoService.h"
#import <AFNetworking.h>

@implementation Store_GetOupputInfoService


- (void)GetOupputInfo:(NSInteger)OutputIdx {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @(OutputIdx), @"OutputIdx",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"请求出库详情参数：%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GetOupputInfo parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求出库详情成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 1) {
            
            GetOupputDetailModel *getOupputDetailM = [[GetOupputDetailModel alloc] initWithDictionary:responseObject[@"result"]];
                
                [self successOfGetOupputInfo:getOupputDetailM];
        } else {
            
            [self failureOfGetOupputInfo:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求出库详情失败:%@", error);
        [self failureOfGetOupputInfo:nil];
    }];
}


// 成功
- (void)successOfGetOupputInfo:(GetOupputDetailModel *)getOupputDetailM {
    
    if([_delegate respondsToSelector:@selector(successOfGetOupputInfo:)]) {
        
        [_delegate successOfGetOupputInfo:getOupputDetailM];
    }
}


// 失败
- (void)failureOfGetOupputInfo:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetOupputInfo:)]) {
        
        [_delegate failureOfGetOupputInfo:msg];
    }
}

@end

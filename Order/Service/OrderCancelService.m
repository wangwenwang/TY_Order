//
//  OrderCancelService.m
//  Order
//
//  Created by 凯东源 on 17/6/15.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "OrderCancelService.h"
#import <AFNetworking.h>

#define kAPIName @"订单取消流程"

#pragma mark - 订单取消流程

@implementation OrderCancelService

- (void)OrderCancel:(NSString *)strOrderIdx andstrUserIdx:(NSString *)strUserIdx {
    
    strOrderIdx = strOrderIdx ? strOrderIdx : @"";
    strUserIdx = strUserIdx ? strUserIdx : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strOrderIdx" : strOrderIdx,
                                 @"strUserIdx" : strUserIdx,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_OrderCancel parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfOrderCancel:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfOrderCancel:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfOrderCancel:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfOrderCancel:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfOrderCancel:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfOrderCancel:)]) {
        
        [_delegate successOfOrderCancel:msg];
    }
}


- (void)failureOfOrderCancel:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfOrderCancel:)]) {
        
        [_delegate failureOfOrderCancel:msg];
    }
}

@end

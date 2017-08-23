//
//  CancelStockService.m
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "CancelStockService.h"
#import <AFNetworking.h>

#define kAPIName @"添加客户库存"

#pragma mark - 添加客户库存

@implementation CancelStockService
- (void)CancelStock:(NSString *)StockIdx {
    
    StockIdx = StockIdx ? StockIdx : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"StockIdx" : StockIdx,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_CancelStock parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfCancelStock:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfCancelStock:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfCancelStock:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfCancelStock:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfCancelStock:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfCancelStock:)]) {
        
        [_delegate successOfCancelStock:msg];
    }
}


- (void)failureOfCancelStock:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfCancelStock:)]) {
        
        [_delegate failureOfCancelStock:msg];
    }
}

@end

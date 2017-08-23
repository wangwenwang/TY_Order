//
//  GetAppStockListService.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppStockListService.h"
#import <AFNetworking.h>

@implementation GetAppStockListService

#define kAPIName @"客户库存详细登记"

#pragma mark - 客户库存详细登记

- (void)GetAppStockList:(NSString *)StockIdx {
    
    StockIdx = StockIdx ? StockIdx : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"StockIdx" : StockIdx,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_GetAppStockList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            NSDictionary *result = responseObject[@"result"];
            
            AppStockListModel *appStockListM = [[AppStockListModel alloc] initWithDictionary:result];
            
            [self successOfGetAppStockList:appStockListM];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -2) {
            
            [self successOfGetAppStockListNoData];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            if([responseObject[@"result"] isEqualToString:@""]) {
                
                [self successOfGetAppStockListNoData];
            } else {
                
                [self failureOfGetAppStockList:msg];
            }
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfGetAppStockList:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfGetAppStockList:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfGetAppStockList:(AppStockListModel *)appStockListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetAppStockList:)]) {
        
        [_delegate successOfGetAppStockList:appStockListM];
    }
}


- (void)successOfGetAppStockListNoData {
    
    if([_delegate respondsToSelector:@selector(successOfGetAppStockListNoData)]) {
        
        [_delegate successOfGetAppStockListNoData];
    }
}


- (void)failureOfGetAppStockList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetAppStockList:)]) {
        
        [_delegate failureOfGetAppStockList:msg];
    }
}

@end

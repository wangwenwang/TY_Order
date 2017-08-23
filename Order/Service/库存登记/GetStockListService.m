//
//  GetStockListService.m
//  Order
//
//  Created by 凯东源 on 17/6/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetStockListService.h"
#import <AFNetworking.h>

@implementation GetStockListService

#define kAPIName @"获取客户库存登记表"

#pragma mark - 获取客户库存登记表

- (void)GetStockList:(NSString *)UserName andstrPage:(NSUInteger)strPage andstrPageCount:(NSUInteger)strPageCount and:(NSString *)strUserId andstrBusinessId:(NSString *)strBusinessId {
    
    UserName = UserName ? UserName : @"";
    strUserId = strUserId ? strUserId : @"";
    strBusinessId = strBusinessId ? strBusinessId : @"";
//    strPage = strPage ? strPage : @(0);
//    strPageCount = strPageCount ? strPageCount : @0;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"UserName" : UserName,
                                 @"strPage" : @(strPage),
                                 @"strPageCount" : @(strPageCount),
                                 @"strUserId" : strUserId,
                                 @"strBusinessId" : strBusinessId,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_GetStockList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            NSDictionary *result = responseObject[@"result"];
            
            StockListModel *m = [[StockListModel alloc] initWithDictionary:result];
            
            [self successOfGetStockList:m];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -2) {
            
            [self successOfGetStockListNoData];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            if([responseObject[@"result"] isEqualToString:@""]) {
                
                [self successOfGetStockListNoData];
            } else {
                
                [self failureOfGetStockList:msg];
            }
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfGetStockList:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfGetStockList:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfGetStockList:(StockListModel *)stockListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetStockList:)]) {
        
        [_delegate successOfGetStockList:stockListM];
    }
}


- (void)successOfGetStockListNoData {
    
        if([_delegate respondsToSelector:@selector(successOfGetStockListNoData)]) {
            
            [_delegate successOfGetStockListNoData];
        }
}


- (void)failureOfGetStockList:(NSString *)msg {
    
        if([_delegate respondsToSelector:@selector(failureOfGetStockList:)]) {
            
            [_delegate failureOfGetStockList:msg];
        }
}

@end

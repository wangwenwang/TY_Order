//
//  GetAppBillFeeListService.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBillFeeListService.h"
#import <AFNetworking.h>

#define kAPIName @"账单列表"

#pragma mark - 账单列表

@implementation GetAppBillFeeListService

- (void)GetAppBillFeeList:(NSUInteger)strPage andstrPageCount:(NSUInteger)strPageCount {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strPage" : @(strPage),
                                 @"strPageCount" : @(strPageCount),
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_GetAppBillFeeList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            GetAppBillFeeListModel *m = [[GetAppBillFeeListModel alloc] initWithDictionary:responseObject[@"result"]];
            
            [self successOfGetAppBillFeeList:m];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfGetAppBillFeeList:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfGetAppBillFeeList:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfGetAppBillFeeList:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfGetAppBillFeeList:(GetAppBillFeeListModel *)GetAppBillFeeListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetAppBillFeeList:)]) {
        
        [_delegate successOfGetAppBillFeeList:GetAppBillFeeListM];
    }
}


- (void)failureOfGetAppBillFeeList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetAppBillFeeList:)]) {
        
        [_delegate failureOfGetAppBillFeeList:msg];
    }
}

@end

//
//  GetAppBusinessFeeListService.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBusinessFeeListService.h"
#import <AFNetworking.h>

#define kAPIName @"费用列表"

#pragma mark - 费用列表

@implementation GetAppBusinessFeeListService

- (void)GetAppBusinessFeeList:(NSString *)MONTH_DATE andBUSINESS_IDX:(NSString *)BUSINESS_IDX andPARTY_IDX:(NSString *)PARTY_IDX {
    
    MONTH_DATE = MONTH_DATE ? MONTH_DATE : @"";
    BUSINESS_IDX = BUSINESS_IDX ? BUSINESS_IDX : @"";
    PARTY_IDX = PARTY_IDX ? PARTY_IDX : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"MONTH_DATE" : MONTH_DATE,
                                 @"BUSINESS_IDX" : BUSINESS_IDX,
                                 @"PARTY_IDX" : PARTY_IDX,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_GetAppBusinessFeeList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            GetAppBusinessFeeListModel *m;
            @try {
                m = [[GetAppBusinessFeeListModel alloc] initWithDictionary:responseObject[@"result"]];
            } @catch (NSException *exception) {
                
                [self failureOfGetAppBusinessFeeList:@"无帐单"];
                return;
            }
            
            [self successOfGetAppBusinessFeeList:m];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfGetAppBusinessFeeList:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfGetAppBusinessFeeList:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfGetAppBusinessFeeList:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfGetAppBusinessFeeList:(GetAppBusinessFeeListModel *)GetAppBusinessFeeListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetAppBusinessFeeList:)]) {
        
        [_delegate successOfGetAppBusinessFeeList:GetAppBusinessFeeListM];
    }
}


- (void)failureOfGetAppBusinessFeeList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetAppBusinessFeeList:)]) {
        
        [_delegate failureOfGetAppBusinessFeeList:msg];
    }
}

@end

//
//  GetFeeListService.m
//  Order
//
//  Created by 凯东源 on 17/6/9.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetFeeListService.h"
#import <AFNetworking.h>

#define kAPIName @"客户费用"

#pragma mark - 客户费用

@implementation GetFeeListService

- (void)GetFeeList:(NSString *)BusinessIDX andPartyIdx:(NSString *)PartyIdx andFeeDate:(NSString *)FeeDate andstrPage:(NSUInteger)strPage andstrPageCount:(NSUInteger)strPageCount {
    
    BusinessIDX = BusinessIDX ? BusinessIDX : @"";
    PartyIdx = PartyIdx ? PartyIdx : @"";
    FeeDate = FeeDate ? FeeDate : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"BusinessIDX" : BusinessIDX,
                                 @"PartyIdx" : PartyIdx,
                                 @"FeeDate" : FeeDate,
                                 @"strPage" : @(strPage),
                                 @"strPageCount" : @(strPageCount),
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_GetFeeList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            FeeListModel *m = [[FeeListModel alloc] initWithDictionary:responseObject[@"result"]];
            [self successOfGetFeeList:m];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfGetFeeList:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfGetFeeList:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfGetFeeList:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfGetFeeList:(FeeListModel *)feeListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetFeeList:)]) {
        
        [_delegate successOfGetFeeList:feeListM];
    }
}


- (void)failureOfGetFeeList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetFeeList:)]) {
        
        [_delegate failureOfGetFeeList:msg];
    }
}

@end

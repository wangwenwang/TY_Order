//
//  DeleteAppUserPartyService.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "DeleteAppUserPartyService.h"
#import <AFNetworking.h>

#define kAPIName @"解绑客户资料"

#pragma mark - 解绑客户资料

@implementation DeleteAppUserPartyService

- (void)DeleteAppUserParty:(NSString *)strUserId andstrPartyId:(NSString *)strPartyId {
    
    strUserId = strUserId ? strUserId : @"";
    strPartyId = strPartyId ? strPartyId : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strUserId" : strUserId,
                                 @"strPartyId" : strPartyId,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_DeleteAppUserParty parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfDeleteAppUserParty:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfDeleteAppUserParty:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfDeleteAppUserParty:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfDeleteAppUserParty:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfDeleteAppUserParty:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfDeleteAppUserParty:)]) {
        
        [_delegate successOfDeleteAppUserParty:msg];
    }
}


- (void)failureOfDeleteAppUserParty:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfDeleteAppUserParty:)]) {
        
        [_delegate failureOfDeleteAppUserParty:msg];
    }
}

@end

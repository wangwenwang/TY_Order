//
//  AddPartyService.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddPartyService.h"
#import <AFNetworking.h>

#define kAPIName @"加入客户资料"

#pragma mark - 加入客户资料


@implementation AddPartyService


- (void)AddParty:(NSString *)strUserId andPARTY_NAME:(NSString *)PARTY_NAME andPARTY_CITY:(NSString *)PARTY_CITY andPARTY_REMARK:(NSString *)PARTY_REMARK {
    
    strUserId = strUserId ? strUserId : @"";
    PARTY_NAME = PARTY_NAME ? PARTY_NAME : @"";
    PARTY_CITY = PARTY_CITY ? PARTY_CITY : @"";
    PARTY_REMARK = PARTY_REMARK ? PARTY_REMARK : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strUserId" : strUserId,
                                 @"PARTY_NAME" : PARTY_NAME,
                                 @"PARTY_CITY" : PARTY_CITY,
                                 @"PARTY_REMARK" : PARTY_REMARK,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_AddParty parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        AddPartyModel *m = [[AddPartyModel alloc] initWithDictionary:responseObject[@"result"]];
        
        if(type == 1) {
            
            [self successOfAddParty:msg andAddPartyM:m];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfAddParty:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfAddParty:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfAddParty:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfAddParty:(NSString *)msg andAddPartyM:(AddPartyModel *)AddPartyM {
    
    if([_delegate respondsToSelector:@selector(successOfAddParty:andAddPartyM:)]) {
        
        [_delegate successOfAddParty:msg andAddPartyM:AddPartyM];
    }
}


- (void)failureOfAddParty:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfAddParty:)]) {
        
        [_delegate failureOfAddParty:msg];
    }
}

@end

//
//  DeleteAddressService.m
//  Order
//
//  Created by 凯东源 on 17/7/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "DeleteAddressService.h"
#import <AFNetworking.h>

#define kAPIName @"增加地址"

#pragma mark - 增加地址

@implementation DeleteAddressService

- (void)DeleteAddress:(NSString *)ADDRESS_IDX {
    
    ADDRESS_IDX = ADDRESS_IDX ? ADDRESS_IDX : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"ADDRESS_IDX" : ADDRESS_IDX,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_DeleteAddress parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfDeleteAddress:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfDeleteAddress:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfDeleteAddress:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfDeleteAddress:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfDeleteAddress:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfDeleteAddress:)]) {
        
        [_delegate successOfDeleteAddress:msg];
    }
}


- (void)failureOfDeleteAddress:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfDeleteAddress:)]) {
        
        [_delegate failureOfDeleteAddress:msg];
    }
}
@end

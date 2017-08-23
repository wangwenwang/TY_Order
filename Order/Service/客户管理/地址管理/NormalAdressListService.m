//
//  NormalAdressListService.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "NormalAdressListService.h"
#import <AFNetworking.h>

@implementation NormalAdressListService

#define kAPIName @"获取地址省"

#pragma mark - 获取地址省

- (void)NormalAdressList:(NSString *)strPrentCode {
    
    strPrentCode = strPrentCode ? strPrentCode : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strPrentCode" : strPrentCode,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_NormalAdressList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        NormalAdressListModel *m = [[NormalAdressListModel alloc] initWithDictionary:responseObject];
        
        if(type == 1) {
            
            [self successOfNormalAdressList:m];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -2) {
            
            [self successOfNormalAdressListNoData:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            if([responseObject[@"result"] isEqualToString:@""]) {
                
                [self successOfNormalAdressList:m];
            } else {
                
                [self failureOfNormalAdressList:msg];
            }
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfNormalAdressList:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfNormalAdressList:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfNormalAdressList:(NormalAdressListModel *)NormalAdressListM {
    
    if([_delegate respondsToSelector:@selector(successOfNormalAdressList:)]) {
        
        [_delegate successOfNormalAdressList:NormalAdressListM];
    }
}


- (void)successOfNormalAdressListNoData:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfNormalAdressListNoData:)]) {
        
        [_delegate successOfNormalAdressListNoData:msg];
    }
}


- (void)failureOfNormalAdressList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfNormalAdressList:)]) {
        
        [_delegate failureOfNormalAdressList:msg];
    }
}

@end

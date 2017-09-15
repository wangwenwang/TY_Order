//
//  AuditService.m
//  ZSDOrder
//
//  Created by 凯东源 on 17/4/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AuditService.h"
#import <AFNetworking.h>

@implementation AuditService

- (void)UpdateAudit:(NSString *)strOrderIdx andstrUserName:(NSString *)strUserName {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                strOrderIdx, @"strOrderIdx",
                                strUserName, @"strUserName",
                                @"", @"strLicense",
                                nil];
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_UpdateAudit parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            if([_delegate respondsToSelector:@selector(successOfAuditPass:)]) {
                
                [_delegate successOfAuditPass:msg];
            }
        } else {
            
            [self failureOfAuditPass:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败---%@", error);
        [self failureOfAuditPass:@"请求失败"];
    }];
}


- (void)failureOfAuditPass:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfAuditPass:)]) {
        
        [_delegate failureOfAuditPass:msg];
    }
}


- (void)RuturnAudit:(NSString *)strOrderIdx andstrUserName:(NSString *)strUserName andstrReason:(NSString *)strReason {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                strOrderIdx, @"strOrderIdx",
                                strUserName, @"strUserName",
                                strReason, @"strReason",
                                @"", @"strLicense",
                                nil];
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_RuturnAudit parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            if([_delegate respondsToSelector:@selector(successOfAuditRefuse:)]) {
                
                [_delegate successOfAuditRefuse:msg];
            }
        } else {
            
            [self failureOfAuditRefuse:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败---%@", error);
        [self failureOfAuditRefuse:@"请求失败"];
    }];
}


- (void)failureOfAuditRefuse:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfAuditRefuse:)]) {
        
        [_delegate failureOfAuditRefuse:msg];
    }
}

@end

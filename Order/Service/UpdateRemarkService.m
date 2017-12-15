//
//  UpdateRemarkService.m
//  Order
//
//  Created by 凯东源 on 2017/12/15.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "UpdateRemarkService.h"
#import <AFNetworking.h>

@implementation UpdateRemarkService

- (void)UpdateRemark:(NSString *)strIdx andstrRemark:(NSString *)strRemark {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                strIdx, @"strIdx",
                                strRemark, @"strRemark",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_UpdateRemark parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            NSLog(@"修改备注成功---%@", responseObject);
            [_delegate successOfUpdateRemark:msg];
            
        } else {
            
            NSLog(@"修改备注失败---%@", responseObject);
            [self failureOfUpdateRemark:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求备注失败---%@", error);
        [self failureOfUpdateRemark:@"请求备注失败"];
    }];
}


#pragma mark - 功能函数

- (void)successOfUpdateRemark:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfUpdateRemark:)]) {
        
        [_delegate successOfUpdateRemark:msg];
    }
}


- (void)failureOfUpdateRemark:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfUpdateRemark:)]) {
        
        [_delegate failureOfUpdateRemark:msg];
    }
}

@end

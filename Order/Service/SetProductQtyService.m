//
//  SetProductQtyService.m
//  Order
//
//  Created by 凯东源 on 2017/10/19.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "SetProductQtyService.h"
#import <AFNetworking.h>

@implementation SetProductQtyService


- (void)SetProductQty:(NSString *)strOrderIdx andstrQty:(NSString *)strQty {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                strOrderIdx, @"strOrderIdx",
                                strQty, @"strQty",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_SetProductQty parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            NSLog(@"修改成功---%@", responseObject);
            [_delegate successOfSetProductQty:msg];
            
        } else {
            
            NSLog(@"修改失败---%@", responseObject);
            [self failureOfSetProductQty:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败---%@", error);
        [self failureOfSetProductQty:nil];
    }];
}


#pragma mark - 功能函数

- (void)successOfSetProductQty:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfSetProductQty:)]) {
        
        [_delegate successOfSetProductQty:msg];
    }
}


- (void)failureOfSetProductQty:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfSetProductQty:)]) {
        
        [_delegate failureOfSetProductQty:msg];
    }
}

@end

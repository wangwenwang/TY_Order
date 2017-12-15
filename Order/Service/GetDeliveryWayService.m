//
//  GetDeliveryWayService.m
//  Order
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetDeliveryWayService.h"
#import <AFNetworking.h>

@implementation GetDeliveryWayService


- (void)GetDeliveryWay {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_GetDeliveryWay parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DeliveryWayListModel *deliveryWayListM = [[DeliveryWayListModel alloc] initWithDictionary:responseObject];
        
        if([deliveryWayListM.type intValue] == 1) {
            
            NSLog(@"获取配送方式成功---%@", responseObject);
            [_delegate successOfGetDeliveryWay:deliveryWayListM];
            
        } else {
            
            NSLog(@"获取配送方式失败---%@", responseObject);
            [self failureOfGetDeliveryWay:deliveryWayListM.msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"获取配送方式请求失败---%@", error);
        [self failureOfGetDeliveryWay:@"获取配送方式请求失败"];
    }];
}


#pragma mark - 功能函数

- (void)successOfGetDeliveryWay:(DeliveryWayListModel *)deliveryWayListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetDeliveryWay:)]) {
        
        [_delegate successOfGetDeliveryWay:deliveryWayListM];
    }
}


- (void)failureOfGetDeliveryWay:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetDeliveryWay:)]) {
        
        [_delegate failureOfGetDeliveryWay:msg];
    }
}

@end

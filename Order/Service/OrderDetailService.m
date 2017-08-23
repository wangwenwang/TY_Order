//
//  OrderDetailService.m
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderDetailService.h"
#import <AFNetworking.h>
#import "NSDictionary+MyLog.h"

@implementation OrderDetailService

- (void)getOrderDetailsData:(NSString *)orderID {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                orderID, @"strOrderId",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_ORDER_DETAIL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        if(_type == 1) {
            
            NSArray *arrResult = responseObject[@"result"];
            NSDictionary *dictOrder = arrResult[0][@"order"];
            OrderModel *orderM = [[OrderModel alloc] init];
            [orderM setDict:dictOrder];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count > 0) {
                    if([_delegate respondsToSelector:@selector(successOfOrderDetail:)]) {
                        [_delegate successOfOrderDetail:orderM];
                    }
                }
            }else {
                NSString *msg = responseObject[@"msg"];
                if([_delegate respondsToSelector:@selector(failureOfOrderDetail:)]) {
                    [_delegate failureOfOrderDetail:msg];
                }
            }
        }else {
            NSString *msg = responseObject[@"msg"];
            if([_delegate respondsToSelector:@selector(failureOfOrderDetail:)]) {
                [_delegate failureOfOrderDetail:msg];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取订单失败！");
        NSLog(@"请求失败---%@", error);
        if([_delegate respondsToSelector:@selector(failureOfOrderDetail:)]) {
            [_delegate failureOfOrderDetail:nil];
        }
    }];
}

@end

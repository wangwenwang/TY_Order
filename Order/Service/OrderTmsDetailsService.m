//
//  OrderTmsDetailsService.m
//  Order
//
//  Created by 凯东源 on 16/10/11.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderTmsDetailsService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "NSString+Trim.h"

@interface OrderTmsDetailsService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation OrderTmsDetailsService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getOrderTmsDetailsData:(NSString *)orderId {
    
    if([[orderId trim] isEqualToString:@""] || orderId == nil) {
        [self failureOfTmsDetails:@"获取订单物流详情失败！"];
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                orderId, @"strTmsOrderId",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_ORDER_TMS_INFORMATION parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count > 0) {
                    NSDictionary *orders = arrResult[0];
                    
                    OrderModel *tms = [[OrderModel alloc] init];
                    [tms setDict:orders[@"order"]];
                    
                    if([_delegate respondsToSelector:@selector(successOfTmsDetails:andPushVc:)]) {
                        [_delegate successOfTmsDetails:tms andPushVc:self.pushDirection];
                    }
                }
            }else {
                [self failureOfTmsDetails:msg];
            }
        }else {
            [self failureOfTmsDetails:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求订单物流信息失败:%@", error);
        [self failureOfTmsDetails:nil];
    }];
}

- (void)failureOfTmsDetails:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfTmsDetails:)]) {
        [_delegate failureOfTmsDetails:msg];
    }
}

@end




//
//  TransportInformationService.m
//  Order
//
//  Created by 凯东源 on 16/10/10.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "TransportInformationService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "NSString+Trim.h"

@interface TransportInformationService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation TransportInformationService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getTransInformationData:(NSString *)orderId {
    
    if([[orderId trim] isEqualToString:@""] || orderId == nil) {
        [self failureOfTransportInformation:@"获取订单物流信息失败！"];
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                orderId, @"strOrderId",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_ORDER_TMSLIST parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count > 0) {
                    OrderTmsModel *tms = [[OrderTmsModel alloc] init];
                    [tms setDict:arrResult[0]];
                    
                    if([_delegate respondsToSelector:@selector(successOfTransportInformation:)]) {
                        [_delegate successOfTransportInformation:tms];
                    }
                }
            }else {
                [self failureOfTransportInformation:msg];
            }
        }else {
            [self failureOfTransportInformation:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求订单物流信息失败:%@", error);
        [self failureOfTransportInformation:nil];
    }];
}

- (void)failureOfTransportInformation:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfTransportInformation:)]) {
        [_delegate failureOfTransportInformation:msg];
    }
}

@end

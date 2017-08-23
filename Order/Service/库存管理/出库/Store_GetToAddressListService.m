//
//  Store_GetToAddressListService.m
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "Store_GetToAddressListService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>


@interface Store_GetToAddressListService ()

@property (strong, nonatomic) AppDelegate *app;

@end


@implementation Store_GetToAddressListService


- (instancetype)init {
    
    if (self = [super init]) {
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)GetToAddressList:(NSInteger)ADDRESS_IDX {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.business.BUSINESS_IDX, @"BUSINESS_IDX",
                                @(ADDRESS_IDX), @"ADDRESS_IDX",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"请求收货人地址参数：%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GetToAddressList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求收货人地址成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 1) {
            
            GetToAddressListModel *getToAddressListM = [[GetToAddressListModel alloc] initWithDictionary:responseObject[@"result"]];
            
            if(getToAddressListM.getToAddressModel.count > 0) {
                
                [self successOfGetToAddressList:getToAddressListM];
            } else {
                
                [self successOfGetToAddressList_NoData];
            }
        } else {
            
            [self failureOfGetToAddressList:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求收货人地址失败:%@", error);
        [self failureOfGetToAddressList:nil];
    }];
}


// 成功
- (void)successOfGetToAddressList:(GetToAddressListModel *)getToAddressListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetToAddressList:)]) {
        
        [_delegate successOfGetToAddressList:getToAddressListM];
    }
}


// 没有数据
- (void)successOfGetToAddressList_NoData {
    
    if([_delegate respondsToSelector:@selector(successOfGetToAddressList_NoData)]) {
        
        [_delegate successOfGetToAddressList_NoData];
    }
}


// 失败
- (void)failureOfGetToAddressList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetToAddressList:)]) {
        
        [_delegate failureOfGetToAddressList:msg];
    }
}

@end

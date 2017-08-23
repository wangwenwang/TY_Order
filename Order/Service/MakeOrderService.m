//
//  MakeOrderService.m
//  Order
//
//  Created by 凯东源 on 16/10/12.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "MakeOrderService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "PartyModel.h"
#import "AddressModel.h"

@interface MakeOrderService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation MakeOrderService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


#pragma mark - 获取客户列表

- (void)getCustomerData {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.user.IDX, @"strUserId",
                                _app.business.BUSINESS_IDX, @"strBusinessId",
                                @"", @"strLicense",
                                nil];
    
    LMLog(@"请求参数:%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_PARTY_LIST parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求客户资料成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            NSMutableArray *partys = [[NSMutableArray alloc] init];
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                for(int i = 0; i < arrResult.count; i++) {
                    NSDictionary *dict = arrResult[i];
                    PartyModel *m = [[PartyModel alloc] init];
                    [m setDict:dict];
                    [partys addObject:m];
                }
                if([_delegate respondsToSelector:@selector(successOfMakeOrder:)]) {
                    [_delegate successOfMakeOrder:partys];
                }
            }else {
                [self failureOfMakeOrder:msg];
            }
        }else {
            [self failureOfMakeOrder:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求订单物流信息失败:%@", error);
        [self failureOfMakeOrder:nil];
    }];
}


- (void)failureOfMakeOrder:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfMakeOrder:)]) {
        
        [_delegate failureOfMakeOrder:msg];
    }
}


#pragma mark - 获取客户地址

- (void)getPartygetAddressInfo:(NSString *)partyIdx {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.user.IDX, @"strUserId",
                                partyIdx, @"strPartyId",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_GET_ADDRESS parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"请求客户地址成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            
            NSMutableArray *address = [[NSMutableArray alloc] init];
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count < 1) {
                    
                    [self failureOfGetPartygetAddressInfo:@"没有获取到客户有效地址，请联系供应商！"];
                } else {
                    
                    for(int i = 0; i < arrResult.count; i++) {
                        
                        NSDictionary *dict = arrResult[i];
                        AddressModel *m = [[AddressModel alloc] init];
                        [m setDict:dict];
                        [address addObject:m];
                    }
                    if([_delegate respondsToSelector:@selector(successOfGetPartygetAddressInfo:)]) {
                        
                        [_delegate successOfGetPartygetAddressInfo:address];
                    }
                }
            } else {
                
                [self failureOfGetPartygetAddressInfo:msg];
            }
        } else if(_type == -2) {
            
            [self successOfGetPartygetAddressInfoNoData];
        } else {
            
            [self failureOfGetPartygetAddressInfo:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求客户地址失败:%@", error);
        [self failureOfGetPartygetAddressInfo:nil];
    }];
}


- (void)successOfGetPartygetAddressInfoNoData {
    
    if([_delegate respondsToSelector:@selector(successOfGetPartygetAddressInfoNoData)]) {
        
        [_delegate successOfGetPartygetAddressInfoNoData];
    }
}


- (void)failureOfGetPartygetAddressInfo:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetPartygetAddressInfo:)]) {
        
        [_delegate failureOfGetPartygetAddressInfo:msg];
    }
}

@end

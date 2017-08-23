//
//  CheckOrderService.m
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "CheckOrderService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "OrderModel.h"

@interface CheckOrderService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation CheckOrderService

- (instancetype)init {
    if(self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getOrderData:(NSString *)status andPage:(int)page {
    NSDictionary *parameters = nil;
    NSString *pageStr = [NSString stringWithFormat:@"%d", page];
    if(_app.user) {
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      _app.user.IDX, @"strUserId",
                      @"", @"strPartyType",
                      _app.business.BUSINESS_IDX, @"strBusinessId",
                      @"", @"strPartyId",
                      @"", @"strStartDate",
                      @"", @"strEndDate",
                      status, @"strState",
                      pageStr, @"strPage",
                      @"20", @"strPageCount",
                      @"", @"strLicense",
                      nil];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [manager POST:API_GET_ORDER_LIST parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        if(_type == 1) {
            
            NSArray *arrResult = responseObject[@"result"];
            NSMutableArray *orders = [[NSMutableArray alloc] init];
            for (int i = 0; i < arrResult.count; i++) {
                NSDictionary *dictResult = arrResult[i];
                OrderModel *orderM = [[OrderModel alloc] init];
                [orderM setDict:dictResult];
                [orders addObject:orderM];
            }
            
            if([_delegate respondsToSelector:@selector(successOfCheckOrder:)]) {
                [_delegate successOfCheckOrder:orders];
            }
        } else if(_type == -2) {
            
            if([_delegate respondsToSelector:@selector(successOfCheckOrderNoData)]) {
                [_delegate successOfCheckOrderNoData];
            }
        } else {
            
            NSString *msg = responseObject[@"msg"];
            if([_delegate respondsToSelector:@selector(failureOfCheckOrder:)]) {
                [_delegate failureOfCheckOrder:msg];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取订单失败！");
        NSLog(@"请求失败---%@", error);
        if([_delegate respondsToSelector:@selector(failureOfCheckOrder:)]) {
            [_delegate failureOfCheckOrder:nil];
        }
    }];
}

@end

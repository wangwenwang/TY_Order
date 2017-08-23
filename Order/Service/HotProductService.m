//
//  HotProductService.m
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "HotProductService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>

@interface HotProductService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation HotProductService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getHotProductData {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.business.BUSINESS_IDX, @"strBusinessId",
                                @"2254", @"strPartyIdx",
                                @"2254", @"strPartyAddressIdx",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_HOT_SELL_PRODUCT parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count > 0) {
                    if([_delegate respondsToSelector:@selector(successOfHotProduct:)]) {
                        [_delegate successOfHotProduct:arrResult];
                    }
                }
            }else {
                [self failureOfHotProduct:msg];
            }
        }else {
            [self failureOfHotProduct:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求热销产品失败:%@", error);
        [self failureOfHotProduct:nil];
    }];
}

- (void)failureOfHotProduct:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfHotProduct:)]) {
        [_delegate failureOfHotProduct:msg];
    }
}

@end

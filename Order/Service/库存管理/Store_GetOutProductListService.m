//
//  Store_GetOutProductListService.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "Store_GetOutProductListService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>

@interface Store_GetOutProductListService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation Store_GetOutProductListService



- (instancetype)init {
    
    if (self = [super init]) {
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)GetOutProductList:(NSInteger)strPartyidx andstrOutputIdx:(NSInteger)strOutputIdx andstrPartyAddressIdx:(NSInteger)strPartyAddressIdx andstrPage:(NSInteger)strPage andstrPageCount:(NSInteger)strPageCount {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.business.BUSINESS_IDX, @"Business_idx",
                                @(strPartyidx), @"strPartyidx",
                                @(strOutputIdx), @"strOutputIdx",
                                @(strPartyAddressIdx), @"strPartyAddressIdx",
                                @(strPage), @"strPage",
                                @(strPageCount), @"strPageCount",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"请求产品参数：%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GetOutProductList parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求产品数据成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 1) {
            
            StoreProductListModel *storeProductListM = [[StoreProductListModel alloc] initWithDictionary:responseObject];
            
            if(storeProductListM.storeProductModel.count > 0) {
                
                [self successOfGetOutProductList:storeProductListM];
            } else {
                
                [self successOfGetOutProductList_NoData];
            }
        } else {
            
            [self failureOfGetOutProductList:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求产品类型失败:%@", error);
        [self failureOfGetOutProductList:nil];
    }];
}


// 成功
- (void)successOfGetOutProductList:(StoreProductListModel *)storeProductListM {
    
    if([_delegate respondsToSelector:@selector(successOfGetOutProductList:)]) {
        
        [_delegate successOfGetOutProductList:storeProductListM];
    }
}


// 没有数据
- (void)successOfGetOutProductList_NoData {
    
    if([_delegate respondsToSelector:@selector(successOfGetOutProductList_NoData)]) {
        
        [_delegate successOfGetOutProductList_NoData];
    }
}


// 失败
- (void)failureOfGetOutProductList:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfGetOutProductList:)]) {
        
        [_delegate failureOfGetOutProductList:msg];
    }
}

@end

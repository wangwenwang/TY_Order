//
//  SelectGoodsService.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SelectGoodsService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "PayTypeModel.h"
#import "ProductTbModel.h"
#import "ProductModel.h"
#import "NSString+Trim.h"

@interface SelectGoodsService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation SelectGoodsService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getPayTypeData {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_PAYMENT_TYPE parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求支付方式成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 0) {
            
            NSMutableArray *payTypes = [[NSMutableArray alloc] init];
        
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count < 1) {
                    [self failureOfGetPayTypeData:@"获取支付类型失败，数据为空！"];
                }else {
                    for(int i = 0; i < arrResult.count; i++) {
                        PayTypeModel *m = [[PayTypeModel alloc] init];
                        [m setDict:arrResult[i]];
                        
                        //默认使用第一种支付方式
                        if(i == 0) {
                            m.selected = YES;
                        }
                        [payTypes addObject:m];
                    }
                    
                    if([_delegate respondsToSelector:@selector(successOfGetPayTypeData:)]) {
                        
                        [_delegate successOfGetPayTypeData:payTypes];
                    }
                }
            }else {
                [self failureOfGetPayTypeData:msg];
            }
        }else {
            [self failureOfGetPayTypeData:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求客户地址失败:%@", error);
        [self failureOfGetPayTypeData:nil];
    }];
}

- (void)failureOfGetPayTypeData:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfGetPayTypeData:)]) {
        [_delegate failureOfGetPayTypeData:msg];
    }
}

- (void)getProductTypesData {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.business.BUSINESS_IDX, @"strBusinessId",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_PRODUCT_TYPE parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求产品类型成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 1) {
            
            NSMutableArray *productTypes = [[NSMutableArray alloc] init];
            ProductTbModel *model = [[ProductTbModel alloc] init];
            model.PRODUCT_TYPE = @"全部";
            model.PRODUCT_CLASS = @"全部";
            model.IDX = 100000086;
            [productTypes addObject:model];
            
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count < 1) {
                    [self failureOfGetProductTypeData:@"获取产品类型失败，数据为空！"];
                } else {
                    for(int i = 0; i < arrResult.count; i++) {
                        ProductTbModel *m = [[ProductTbModel alloc] init];
                        [m setDict:arrResult[i]];
                        
                        
                        //剔除重复的类型，添加到productTypes
                        int k = 0;
                        int j;
                        for(j = 0; j < productTypes.count; j++) {
                            ProductTbModel *mOfArr = productTypes[j];
                            if([[m.PRODUCT_TYPE trim] isEqualToString:@""] || [m.PRODUCT_TYPE isEqualToString:mOfArr.PRODUCT_TYPE]) {
                                break;
                            }else {
                                k++;
                            }
                        }
                        if(k == productTypes.count) {
                            [productTypes addObject:m];
                        }
                        
                        
                    }
                    
                    if([_delegate respondsToSelector:@selector(successOfGetProductTypeData:)]) {
                        
                        [_delegate successOfGetProductTypeData:productTypes];
                    }
                }
            }else {
                [self failureOfGetProductTypeData:msg];
            }
        }else {
            [self failureOfGetProductTypeData:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求产品类型失败:%@", error);
        [self failureOfGetProductTypeData:nil];
    }];
}

- (void)failureOfGetProductTypeData:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfGetProductTypeData:)]) {
        [_delegate failureOfGetProductTypeData:msg];
    }
}


- (void)getProductsData:(NSString *)orderPartyId andOrderAddressIdx:(NSString *)orderAddressIdx andProductTypeIndex:(int)index andProductType:(NSString *)productType andOrderBrand:(NSString *)orderBrand {
    
    orderPartyId = orderPartyId ? orderPartyId : @"";
    orderAddressIdx = orderAddressIdx ? orderAddressIdx : @"";
    index = index ? index : 0;
    productType = productType ? productType : @"";
    orderBrand = orderBrand ? orderBrand : @"";
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.business.BUSINESS_IDX, @"strBusinessId",
                                orderPartyId, @"strPartyIdx",
                                orderAddressIdx, @"strPartyAddressIdx",
                                @"", @"strLicense",
                                productType, @"strProductType",
                                orderBrand, @"strProductClass",
                                nil];
    
    NSLog(@"请求产品参数：%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GET_PRDUCT_LIST_TYPE parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求产品数据成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 1) {
            
            NSMutableArray *products = [[NSMutableArray alloc] init];
            
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count < 1) {
                    [self failureOfGetProductData:@"获取产品数据失败，数据为空！"];
                }else {
                    for(int i = 0; i < arrResult.count; i++) {
                        ProductModel *m = [[ProductModel alloc] init];
                        [m setDict:arrResult[i]];
                        
                        [products addObject:m];
                    }
                    
                    if([_delegate respondsToSelector:@selector(successOfGetProductData:)]) {
                        
                        [_delegate successOfGetProductData:products];
                    }
                }
            }else {
                [self failureOfGetProductData:msg];
            }
        }else {
            [self failureOfGetProductData:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求产品类型失败:%@", error);
        [self failureOfGetProductData:nil];
    }];
}

- (void)failureOfGetProductData:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfGetProductData:)]) {
        [_delegate failureOfGetProductData:msg];
    }
}

@end

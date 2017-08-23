//
//  AddGiftsService.m
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "AddGiftsService.h"
#import <AFNetworking.h>
#import "ProductModel.h"
#import "PromotionDetailModel.h"
#import "Tools.h"

@implementation AddGiftsService


- (void)getAddGiftsData:(NSString *)businessId andPartyIdx:(NSString *)partyIdx andPartyAddressIdx:(NSString *)partyAddressIdx andProductName:(NSString *)productName {
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    businessId, @"strBusinessId",
                                    partyIdx, @"strPartyIdx",
                                    partyAddressIdx, @"strPartyAddressIdx",
                                    @"", @"strLicense",
                                    productName, @"strProductType",
                                    @"", @"strProductClass",
                                    nil];
        NSLog(@"%@", parameters);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager POST:API_GET_COMMODITY_DATA parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            nil;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求策略成功---%@", responseObject);
            int type = [responseObject[@"type"] intValue];
            
            if(type == 1) {
                NSArray *arrResult = responseObject[@"result"];
                
                if([arrResult isKindOfClass:[NSArray class]]) {
                    
                    if([_delegate respondsToSelector:@selector(successOfAddGifts:)]) {
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        for (int i = 0; i < arrResult.count; i++) {
                            ProductModel *m = [[ProductModel alloc] init];
                            [m setDict:arrResult[i]];
                            [array addObject:m];
                        }
                        NSMutableArray *promotionDetails = [Tools ChangeProductToPromotionDetailUtil:array];
                        [_delegate successOfAddGifts:promotionDetails];
                    }
                }else {
                    
                    NSString *msg = responseObject[@"msg"];
                    [self failureOfAddGifts:msg];
                }
            } else {
                [self failureOfAddGifts:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败---%@", error);
            [self failureOfAddGifts:nil];
        }];
}

- (void)failureOfAddGifts:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfAddGifts:)]) {
        [_delegate failureOfAddGifts:msg];
    }
}

@end

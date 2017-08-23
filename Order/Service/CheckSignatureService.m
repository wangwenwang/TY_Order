//
//  CheckSignatureService.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "CheckSignatureService.h"
#import <AFNetworking.h>
#import "SignatureAndPictureModel.h"

@implementation CheckSignatureService

- (void)getAutographAndPictureData:(NSString *)orderIdx {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                orderIdx, @"strOrderIdx",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_GETAUTOGRAPH parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求产品类型成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(_type == 1) {
            
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                if(arrResult.count < 1) {
                    [self failureOfCheckSignature:@"获取签名失败，数据为空！"];
                }else {
                    
                    if([_delegate respondsToSelector:@selector(successOfCheckSignature:)]) {
                        
                        NSMutableArray *arrM = [[NSMutableArray alloc] init];
                        for(int i = 0; i < arrResult.count; i++) {
                            SignatureAndPictureModel *m = [[SignatureAndPictureModel alloc] init];
                            [m setDict:arrResult[i]];
                            [arrM addObject:m];
                        }
                        
                        [_delegate successOfCheckSignature:arrM];
                    }
                }
            }else {
                [self failureOfCheckSignature:msg];
            }
        }else {
            [self failureOfCheckSignature:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求产品类型失败:%@", error);
        [self failureOfCheckSignature:nil];
    }];
}

- (void)failureOfCheckSignature:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfCheckSignature:)]) {
        [_delegate failureOfCheckSignature:msg];
    }
}

@end

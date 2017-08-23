//
//  UpdateAddressService.m
//  Order
//
//  Created by 凯东源 on 17/7/17.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "UpdateAddressService.h"
#import <AFNetworking.h>

#define kAPIName @"修改地址"

#pragma mark - 修改地址

@implementation UpdateAddressService

- (void)UpdateAddress:(NSString *)strUserId andADDRESS_IDX:(NSString *)ADDRESS_IDX andADDRESS_INFO:(NSString *)ADDRESS_INFO andADDRESS_PROVINCE:(NSString *)ADDRESS_PROVINCE andADDRESS_CITY:(NSString *)ADDRESS_CITY andADDRESS_AREA:(NSString *)ADDRESS_AREA andADDRESS_RURAL:(NSString *)ADDRESS_RURAL andADDRESS_ADDRESS:(NSString *)ADDRESS_ADDRESS andCONTACT_PERSON:(NSString *)CONTACT_PERSON andCONTACT_TEL:(NSString *)CONTACT_TEL {
    
    strUserId = strUserId ? strUserId : @"";
    ADDRESS_IDX = ADDRESS_IDX ? ADDRESS_IDX : @"";
    ADDRESS_INFO = ADDRESS_INFO ? ADDRESS_INFO : @"";
    ADDRESS_PROVINCE = ADDRESS_PROVINCE ? ADDRESS_PROVINCE : @"";
    ADDRESS_CITY = ADDRESS_CITY ? ADDRESS_CITY : @"";
    ADDRESS_AREA = ADDRESS_AREA ? ADDRESS_AREA : @"";
    ADDRESS_RURAL = ADDRESS_RURAL ? ADDRESS_RURAL : @"";
    ADDRESS_ADDRESS = ADDRESS_ADDRESS ? ADDRESS_ADDRESS : @"";
    CONTACT_PERSON = CONTACT_PERSON ? CONTACT_PERSON : @"";
    CONTACT_TEL = CONTACT_TEL ? CONTACT_TEL : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strUserId" : strUserId,
                                 @"ADDRESS_IDX" : ADDRESS_IDX,
                                 @"ADDRESS_INFO" : ADDRESS_INFO,
                                 @"ADDRESS_PROVINCE" : ADDRESS_PROVINCE,
                                 @"ADDRESS_CITY" : ADDRESS_CITY,
                                 @"ADDRESS_AREA" : ADDRESS_AREA,
                                 @"ADDRESS_RURAL" : ADDRESS_RURAL,
                                 @"ADDRESS_ADDRESS" : ADDRESS_ADDRESS,
                                 @"CONTACT_PERSON" : CONTACT_PERSON,
                                 @"CONTACT_TEL" : CONTACT_TEL,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_UpdateAddress parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfUpdateAddress:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfUpdateAddress:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfUpdateAddress:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfUpdateAddress:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfUpdateAddress:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfUpdateAddress:)]) {
        
        [_delegate successOfUpdateAddress:msg];
    }
}


- (void)failureOfUpdateAddress:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfUpdateAddress:)]) {
        
        [_delegate failureOfUpdateAddress:msg];
    }
}

@end

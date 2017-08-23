//
//  AddAddressService.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddAddressService.h"
#import <AFNetworking.h>

#define kAPIName @"增加地址"

#pragma mark - 增加地址

@implementation AddAddressService

- (void)AddAddress:(NSString *)strUserId andPARTY_IDX:(NSString *)PARTY_IDX andADDRESS_CODE:(NSString *)ADDRESS_CODE andADDRESS_PROVINCE:(NSString *)ADDRESS_PROVINCE andADDRESS_CITY:(NSString *)ADDRESS_CITY andADDRESS_AREA:(NSString *)ADDRESS_AREA andADDRESS_RURAL:(NSString *)ADDRESS_RURAL andADDRESS_ADDRESS:(NSString *)ADDRESS_ADDRESS andCONTACT_PERSON:(NSString *)CONTACT_PERSON andCONTACT_TEL:(NSString *)CONTACT_TEL andADDRESS_INFO:(NSString *)ADDRESS_INFO {
    
    strUserId = strUserId ? strUserId : @"";
    PARTY_IDX = PARTY_IDX ? PARTY_IDX : @"";
    ADDRESS_CODE = ADDRESS_CODE ? ADDRESS_CODE : @"";
    ADDRESS_PROVINCE = ADDRESS_PROVINCE ? ADDRESS_PROVINCE : @"";
    ADDRESS_CITY = ADDRESS_CITY ? ADDRESS_CITY : @"";
    ADDRESS_AREA = ADDRESS_AREA ? ADDRESS_AREA : @"";
    ADDRESS_RURAL = ADDRESS_RURAL ? ADDRESS_RURAL : @"";
    ADDRESS_ADDRESS = ADDRESS_ADDRESS ? ADDRESS_ADDRESS : @"";
    CONTACT_PERSON = CONTACT_PERSON ? CONTACT_PERSON : @"";
    CONTACT_TEL = CONTACT_TEL ? CONTACT_TEL : @"";
    ADDRESS_INFO = ADDRESS_INFO ? ADDRESS_INFO : @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{
                                 @"strUserId" : strUserId,
                                 @"PARTY_IDX" : PARTY_IDX,
                                 @"ADDRESS_CODE" : ADDRESS_CODE,
                                 @"ADDRESS_PROVINCE" : ADDRESS_PROVINCE,
                                 @"ADDRESS_CITY" : ADDRESS_CITY,
                                 @"ADDRESS_AREA" : ADDRESS_AREA,
                                 @"ADDRESS_RURAL" : ADDRESS_RURAL,
                                 @"ADDRESS_ADDRESS" : ADDRESS_ADDRESS,
                                 @"CONTACT_PERSON" : CONTACT_PERSON,
                                 @"CONTACT_TEL" : CONTACT_TEL,
                                 @"ADDRESS_INFO" : ADDRESS_INFO,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_AddAddress parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
        NSInteger type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 1) {
            
            [self successOfAddAddress:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        } else if(type == -1){
            
            [self failureOfAddAddress:msg];
            LMLog(@"%@失败，msg:%@", kAPIName, msg);
        } else {
            
            [self failureOfAddAddress:msg];
            LMLog(@"%@成功，msg:%@", kAPIName, msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfAddAddress:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
    
}


#pragma mark - 功能函数

- (void)successOfAddAddress:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(successOfAddAddress:)]) {
        
        [_delegate successOfAddAddress:msg];
    }
}


- (void)failureOfAddAddress:(NSString *)msg {
    
    if([_delegate respondsToSelector:@selector(failureOfAddAddress:)]) {
        
        [_delegate failureOfAddAddress:msg];
    }
}

@end

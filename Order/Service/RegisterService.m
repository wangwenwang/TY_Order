//
//  RegisterService.m
//  CMClient
//
//  Created by 凯东源 on 17/1/14.
//  Copyright © 2017年 城马联盟. All rights reserved.
//

#import "RegisterService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>

@interface RegisterService ()


@property (strong, nonatomic) AppDelegate *app;

@end

@implementation RegisterService


#define kAPIName @"注册"


#pragma mark - 注册

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)registerX:(NSString *)strUserName andstrPwd:(NSString *)strPwd andstrUserCode:(NSString *)strUserCode andPARTY_NAME:(NSString *)PARTY_NAME andPARTY_CITY:(NSString *)PARTY_CITY andCONTACT_PERSON:(NSString *)CONTACT_PERSON andCONTACT_TEL:(NSString *)CONTACT_TEL andPARTY_REMARK:(NSString *)PARTY_REMARK andADDRESS_PROVINCE:(NSString *)ADDRESS_PROVINCE and:(NSString *)ADDRESS_CITY andADDRESS_AREA:(NSString *)ADDRESS_AREA andADDRESS_RURAL:(NSString *)ADDRESS_RURAL andADDRESS_ADDRESS:(NSString *)ADDRESS_ADDRESS andADDRESS_INFO:(NSString *)ADDRESS_INFO {
    
    
    strUserName = strUserName ? strUserName : @"";
    strPwd = strPwd ? strPwd : @"";
    strUserCode = strUserCode ? strUserCode : @"";
    PARTY_NAME = PARTY_NAME ? PARTY_NAME : @"";
    PARTY_CITY = PARTY_CITY ? PARTY_CITY : @"";
    CONTACT_PERSON = CONTACT_PERSON ? CONTACT_PERSON : @"";
    CONTACT_TEL = CONTACT_TEL ? CONTACT_TEL : @"";
    PARTY_REMARK = PARTY_REMARK ? PARTY_REMARK : @"";
    ADDRESS_PROVINCE = ADDRESS_PROVINCE ? ADDRESS_PROVINCE : @"";
    ADDRESS_CITY = ADDRESS_CITY ? ADDRESS_CITY : @"";
    ADDRESS_AREA = ADDRESS_AREA ? ADDRESS_AREA : @"";
    ADDRESS_RURAL = ADDRESS_RURAL ? ADDRESS_RURAL : @"";
    ADDRESS_ADDRESS = ADDRESS_ADDRESS ? ADDRESS_ADDRESS : @"";
    ADDRESS_INFO = ADDRESS_INFO ? ADDRESS_INFO : @"";
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"strUserName" : strUserName,
                                 @"strPwd" : strPwd,
                                 @"strUserCode" : strUserCode,
                                 @"PARTY_NAME" : PARTY_NAME,
                                 @"PARTY_CITY" : PARTY_CITY,
                                 @"CONTACT_PERSON" : CONTACT_PERSON,
                                 @"CONTACT_TEL" : CONTACT_TEL,
                                 @"PARTY_REMARK" : PARTY_REMARK,
                                 @"ADDRESS_PROVINCE" : ADDRESS_PROVINCE,
                                 @"ADDRESS_CITY" : ADDRESS_CITY,
                                 @"ADDRESS_AREA" : ADDRESS_AREA,
                                 @"ADDRESS_RURAL" : ADDRESS_RURAL,
                                 @"ADDRESS_ADDRESS" : ADDRESS_ADDRESS,
                                 @"ADDRESS_INFO" : ADDRESS_INFO,
                                 @"strLicense" : @""
                                 };
    
    LMLog(@"请求%@参数:%@", kAPIName, parameters);
    
    [manager POST:API_register parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        @try {
            LMLog(@"%@,请求成功,返回值:%@", kAPIName, responseObject);
            
            int _type = [responseObject[@"type"] intValue];
            NSString *msg = responseObject[@"msg"];
            
            if(_type == 1) {
                
                [self successOfRegister];
                LMLog(@"%@成功，msg:%@", kAPIName, msg);
                
            } else {
                
                [self failureOfRegister:msg];
                LMLog(@"%@失败，msg:%@", kAPIName, msg);
            }
        } @catch (NSException *exception) {
            
            LMLog(@"%@失败，carsh", kAPIName);
            [self failureOfRegister:@"请求失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failureOfRegister:@"请求失败"];
        LMLog(@"%@时，请求失败，error:%@", kAPIName, error);
    }];
}


#pragma mark - 功能函数

- (void)successOfRegister {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_delegate respondsToSelector:@selector(successOfRegister)]) {
            
            [_delegate successOfRegister];
        }
    });
}


- (void)failureOfRegister:(NSString *)msg {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_delegate respondsToSelector:@selector(failureOfRegister:)]) {
            
            [_delegate failureOfRegister:msg];
        }
    });
}

@end

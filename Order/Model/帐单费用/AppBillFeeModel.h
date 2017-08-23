//
//  AppBillFeeModel.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppBillFeeModel : NSObject

@property (nonatomic, strong) NSString * bILLDATE;
@property (nonatomic, strong) NSString * bILLNAME;
@property (nonatomic, strong) NSString * bILLSTATE;
@property (nonatomic, strong) NSString * bILLWORKFLOW;
@property (nonatomic, strong) NSString * eNTIDX;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * uSERNAME;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

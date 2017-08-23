//
//  GetToAddressModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetToAddressModel.h"


NSString *const kGetToAddressModelADDRESSINFO = @"ADDRESS_INFO";
NSString *const kGetToAddressModelIDX = @"IDX";
NSString *const kGetToAddressModelITEMCODE = @"ITEM_CODE";
NSString *const kGetToAddressModelPARTYNAME = @"PARTY_NAME";


@implementation GetToAddressModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetToAddressModelADDRESSINFO] isKindOfClass:[NSNull class]]){
        self.aDDRESSINFO = dictionary[kGetToAddressModelADDRESSINFO];
    }
    if(![dictionary[kGetToAddressModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kGetToAddressModelIDX];
    }
    if(![dictionary[kGetToAddressModelITEMCODE] isKindOfClass:[NSNull class]]){
        self.iTEMCODE = dictionary[kGetToAddressModelITEMCODE];
    }
    if(![dictionary[kGetToAddressModelPARTYNAME] isKindOfClass:[NSNull class]]){
        self.pARTYNAME = dictionary[kGetToAddressModelPARTYNAME];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.aDDRESSINFO != nil){
        dictionary[kGetToAddressModelADDRESSINFO] = self.aDDRESSINFO;
    }
    if(self.iDX != nil){
        dictionary[kGetToAddressModelIDX] = self.iDX;
    }
    if(self.iTEMCODE != nil){
        dictionary[kGetToAddressModelITEMCODE] = self.iTEMCODE;
    }
    if(self.pARTYNAME != nil){
        dictionary[kGetToAddressModelPARTYNAME] = self.pARTYNAME;
    }
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.aDDRESSINFO != nil){
        [aCoder encodeObject:self.aDDRESSINFO forKey:kGetToAddressModelADDRESSINFO];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kGetToAddressModelIDX];
    }
    if(self.iTEMCODE != nil){
        [aCoder encodeObject:self.iTEMCODE forKey:kGetToAddressModelITEMCODE];
    }
    if(self.pARTYNAME != nil){
        [aCoder encodeObject:self.pARTYNAME forKey:kGetToAddressModelPARTYNAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aDDRESSINFO = [aDecoder decodeObjectForKey:kGetToAddressModelADDRESSINFO];
    self.iDX = [aDecoder decodeObjectForKey:kGetToAddressModelIDX];
    self.iTEMCODE = [aDecoder decodeObjectForKey:kGetToAddressModelITEMCODE];
    self.pARTYNAME = [aDecoder decodeObjectForKey:kGetToAddressModelPARTYNAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetToAddressModel *copy = [GetToAddressModel new];
    
    copy.aDDRESSINFO = [self.aDDRESSINFO copy];
    copy.iDX = [self.iDX copy];
    copy.iTEMCODE = [self.iTEMCODE copy];
    copy.pARTYNAME = [self.pARTYNAME copy];
    
    return copy;
}

@end

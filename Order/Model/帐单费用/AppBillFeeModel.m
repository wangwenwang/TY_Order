//
//  AppBillFeeModel.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AppBillFeeModel.h"


NSString *const kAppBillFeeModelBILLDATE = @"BILL_DATE";
NSString *const kAppBillFeeModelBILLNAME = @"BILL_NAME";
NSString *const kAppBillFeeModelBILLSTATE = @"BILL_STATE";
NSString *const kAppBillFeeModelBILLWORKFLOW = @"BILL_WORKFLOW";
NSString *const kAppBillFeeModelENTIDX = @"ENT_IDX";
NSString *const kAppBillFeeModelIDX = @"IDX";
NSString *const kAppBillFeeModelUSERNAME = @"USER_NAME";


@implementation AppBillFeeModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAppBillFeeModelBILLDATE] isKindOfClass:[NSNull class]]){
        self.bILLDATE = dictionary[kAppBillFeeModelBILLDATE];
    }
    if(![dictionary[kAppBillFeeModelBILLNAME] isKindOfClass:[NSNull class]]){
        self.bILLNAME = dictionary[kAppBillFeeModelBILLNAME];
    }
    if(![dictionary[kAppBillFeeModelBILLSTATE] isKindOfClass:[NSNull class]]){
        self.bILLSTATE = dictionary[kAppBillFeeModelBILLSTATE];
    }
    if(![dictionary[kAppBillFeeModelBILLWORKFLOW] isKindOfClass:[NSNull class]]){
        self.bILLWORKFLOW = dictionary[kAppBillFeeModelBILLWORKFLOW];
    }
    if(![dictionary[kAppBillFeeModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kAppBillFeeModelENTIDX];
    }
    if(![dictionary[kAppBillFeeModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kAppBillFeeModelIDX];
    }
    if(![dictionary[kAppBillFeeModelUSERNAME] isKindOfClass:[NSNull class]]){
        self.uSERNAME = dictionary[kAppBillFeeModelUSERNAME];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.bILLDATE != nil){
        dictionary[kAppBillFeeModelBILLDATE] = self.bILLDATE;
    }
    if(self.bILLNAME != nil){
        dictionary[kAppBillFeeModelBILLNAME] = self.bILLNAME;
    }
    if(self.bILLSTATE != nil){
        dictionary[kAppBillFeeModelBILLSTATE] = self.bILLSTATE;
    }
    if(self.bILLWORKFLOW != nil){
        dictionary[kAppBillFeeModelBILLWORKFLOW] = self.bILLWORKFLOW;
    }
    if(self.eNTIDX != nil){
        dictionary[kAppBillFeeModelENTIDX] = self.eNTIDX;
    }
    if(self.iDX != nil){
        dictionary[kAppBillFeeModelIDX] = self.iDX;
    }
    if(self.uSERNAME != nil){
        dictionary[kAppBillFeeModelUSERNAME] = self.uSERNAME;
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
    if(self.bILLDATE != nil){
        [aCoder encodeObject:self.bILLDATE forKey:kAppBillFeeModelBILLDATE];
    }
    if(self.bILLNAME != nil){
        [aCoder encodeObject:self.bILLNAME forKey:kAppBillFeeModelBILLNAME];
    }
    if(self.bILLSTATE != nil){
        [aCoder encodeObject:self.bILLSTATE forKey:kAppBillFeeModelBILLSTATE];
    }
    if(self.bILLWORKFLOW != nil){
        [aCoder encodeObject:self.bILLWORKFLOW forKey:kAppBillFeeModelBILLWORKFLOW];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kAppBillFeeModelENTIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kAppBillFeeModelIDX];
    }
    if(self.uSERNAME != nil){
        [aCoder encodeObject:self.uSERNAME forKey:kAppBillFeeModelUSERNAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.bILLDATE = [aDecoder decodeObjectForKey:kAppBillFeeModelBILLDATE];
    self.bILLNAME = [aDecoder decodeObjectForKey:kAppBillFeeModelBILLNAME];
    self.bILLSTATE = [aDecoder decodeObjectForKey:kAppBillFeeModelBILLSTATE];
    self.bILLWORKFLOW = [aDecoder decodeObjectForKey:kAppBillFeeModelBILLWORKFLOW];
    self.eNTIDX = [aDecoder decodeObjectForKey:kAppBillFeeModelENTIDX];
    self.iDX = [aDecoder decodeObjectForKey:kAppBillFeeModelIDX];
    self.uSERNAME = [aDecoder decodeObjectForKey:kAppBillFeeModelUSERNAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AppBillFeeModel *copy = [AppBillFeeModel new];
    
    copy.bILLDATE = [self.bILLDATE copy];
    copy.bILLNAME = [self.bILLNAME copy];
    copy.bILLSTATE = [self.bILLSTATE copy];
    copy.bILLWORKFLOW = [self.bILLWORKFLOW copy];
    copy.eNTIDX = [self.eNTIDX copy];
    copy.iDX = [self.iDX copy];
    copy.uSERNAME = [self.uSERNAME copy];
    
    return copy;
}

@end

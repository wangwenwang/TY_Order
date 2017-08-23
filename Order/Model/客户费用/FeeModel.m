//
//  FeeModel.m
//  Order
//
//  Created by 凯东源 on 17/6/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "FeeModel.h"


NSString *const kFeeModelADDDATE = @"ADD_DATE";
NSString *const kFeeModelBUSINESSCODE = @"BUSINESS_CODE";
NSString *const kFeeModelBUSINESSNAME = @"BUSINESS_NAME";
NSString *const kFeeModelEDITDATE = @"EDIT_DATE";
NSString *const kFeeModelENTIDX = @"ENT_IDX";
NSString *const kFeeModelFEEAMOUNT = @"FEE_AMOUNT";
NSString *const kFeeModelFEEDATE = @"FEE_DATE";
NSString *const kFeeModelFEEDESC = @"FEE_DESC";
NSString *const kFeeModelFEENAME = @"FEE_NAME";
NSString *const kFeeModelIDX = @"IDX";
NSString *const kFeeModelPARTYCODE = @"PARTY_CODE";
NSString *const kFeeModelPARTYNAME = @"PARTY_NAME";
NSString *const kFeeModelUSERNAME = @"USER_NAME";


@implementation FeeModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kFeeModelADDDATE] isKindOfClass:[NSNull class]]){
        self.aDDDATE = dictionary[kFeeModelADDDATE];
    }
    if(![dictionary[kFeeModelBUSINESSCODE] isKindOfClass:[NSNull class]]){
        self.bUSINESSCODE = dictionary[kFeeModelBUSINESSCODE];
    }
    if(![dictionary[kFeeModelBUSINESSNAME] isKindOfClass:[NSNull class]]){
        self.bUSINESSNAME = dictionary[kFeeModelBUSINESSNAME];
    }
    if(![dictionary[kFeeModelEDITDATE] isKindOfClass:[NSNull class]]){
        self.eDITDATE = dictionary[kFeeModelEDITDATE];
    }
    if(![dictionary[kFeeModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kFeeModelENTIDX];
    }
    if(![dictionary[kFeeModelFEEAMOUNT] isKindOfClass:[NSNull class]]){
        self.fEEAMOUNT = dictionary[kFeeModelFEEAMOUNT];
    }
    if(![dictionary[kFeeModelFEEDATE] isKindOfClass:[NSNull class]]){
        self.fEEDATE = dictionary[kFeeModelFEEDATE];
    }
    if(![dictionary[kFeeModelFEEDESC] isKindOfClass:[NSNull class]]){
        self.fEEDESC = dictionary[kFeeModelFEEDESC];
    }
    if(![dictionary[kFeeModelFEENAME] isKindOfClass:[NSNull class]]){
        self.fEENAME = dictionary[kFeeModelFEENAME];
    }
    if(![dictionary[kFeeModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kFeeModelIDX];
    }
    if(![dictionary[kFeeModelPARTYCODE] isKindOfClass:[NSNull class]]){
        self.pARTYCODE = dictionary[kFeeModelPARTYCODE];
    }
    if(![dictionary[kFeeModelPARTYNAME] isKindOfClass:[NSNull class]]){
        self.pARTYNAME = dictionary[kFeeModelPARTYNAME];
    }
    if(![dictionary[kFeeModelUSERNAME] isKindOfClass:[NSNull class]]){
        self.uSERNAME = dictionary[kFeeModelUSERNAME];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.aDDDATE != nil){
        dictionary[kFeeModelADDDATE] = self.aDDDATE;
    }
    if(self.bUSINESSCODE != nil){
        dictionary[kFeeModelBUSINESSCODE] = self.bUSINESSCODE;
    }
    if(self.bUSINESSNAME != nil){
        dictionary[kFeeModelBUSINESSNAME] = self.bUSINESSNAME;
    }
    if(self.eDITDATE != nil){
        dictionary[kFeeModelEDITDATE] = self.eDITDATE;
    }
    if(self.eNTIDX != nil){
        dictionary[kFeeModelENTIDX] = self.eNTIDX;
    }
    if(self.fEEAMOUNT != nil){
        dictionary[kFeeModelFEEAMOUNT] = self.fEEAMOUNT;
    }
    if(self.fEEDATE != nil){
        dictionary[kFeeModelFEEDATE] = self.fEEDATE;
    }
    if(self.fEEDESC != nil){
        dictionary[kFeeModelFEEDESC] = self.fEEDESC;
    }
    if(self.fEENAME != nil){
        dictionary[kFeeModelFEENAME] = self.fEENAME;
    }
    if(self.iDX != nil){
        dictionary[kFeeModelIDX] = self.iDX;
    }
    if(self.pARTYCODE != nil){
        dictionary[kFeeModelPARTYCODE] = self.pARTYCODE;
    }
    if(self.pARTYNAME != nil){
        dictionary[kFeeModelPARTYNAME] = self.pARTYNAME;
    }
    if(self.uSERNAME != nil){
        dictionary[kFeeModelUSERNAME] = self.uSERNAME;
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
    if(self.aDDDATE != nil){
        [aCoder encodeObject:self.aDDDATE forKey:kFeeModelADDDATE];
    }
    if(self.bUSINESSCODE != nil){
        [aCoder encodeObject:self.bUSINESSCODE forKey:kFeeModelBUSINESSCODE];
    }
    if(self.bUSINESSNAME != nil){
        [aCoder encodeObject:self.bUSINESSNAME forKey:kFeeModelBUSINESSNAME];
    }
    if(self.eDITDATE != nil){
        [aCoder encodeObject:self.eDITDATE forKey:kFeeModelEDITDATE];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kFeeModelENTIDX];
    }
    if(self.fEEAMOUNT != nil){
        [aCoder encodeObject:self.fEEAMOUNT forKey:kFeeModelFEEAMOUNT];
    }
    if(self.fEEDATE != nil){
        [aCoder encodeObject:self.fEEDATE forKey:kFeeModelFEEDATE];
    }
    if(self.fEEDESC != nil){
        [aCoder encodeObject:self.fEEDESC forKey:kFeeModelFEEDESC];
    }
    if(self.fEENAME != nil){
        [aCoder encodeObject:self.fEENAME forKey:kFeeModelFEENAME];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kFeeModelIDX];
    }
    if(self.pARTYCODE != nil){
        [aCoder encodeObject:self.pARTYCODE forKey:kFeeModelPARTYCODE];
    }
    if(self.pARTYNAME != nil){
        [aCoder encodeObject:self.pARTYNAME forKey:kFeeModelPARTYNAME];
    }
    if(self.uSERNAME != nil){
        [aCoder encodeObject:self.uSERNAME forKey:kFeeModelUSERNAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aDDDATE = [aDecoder decodeObjectForKey:kFeeModelADDDATE];
    self.bUSINESSCODE = [aDecoder decodeObjectForKey:kFeeModelBUSINESSCODE];
    self.bUSINESSNAME = [aDecoder decodeObjectForKey:kFeeModelBUSINESSNAME];
    self.eDITDATE = [aDecoder decodeObjectForKey:kFeeModelEDITDATE];
    self.eNTIDX = [aDecoder decodeObjectForKey:kFeeModelENTIDX];
    self.fEEAMOUNT = [aDecoder decodeObjectForKey:kFeeModelFEEAMOUNT];
    self.fEEDATE = [aDecoder decodeObjectForKey:kFeeModelFEEDATE];
    self.fEEDESC = [aDecoder decodeObjectForKey:kFeeModelFEEDESC];
    self.fEENAME = [aDecoder decodeObjectForKey:kFeeModelFEENAME];
    self.iDX = [aDecoder decodeObjectForKey:kFeeModelIDX];
    self.pARTYCODE = [aDecoder decodeObjectForKey:kFeeModelPARTYCODE];
    self.pARTYNAME = [aDecoder decodeObjectForKey:kFeeModelPARTYNAME];
    self.uSERNAME = [aDecoder decodeObjectForKey:kFeeModelUSERNAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    FeeModel *copy = [FeeModel new];
    
    copy.aDDDATE = [self.aDDDATE copy];
    copy.bUSINESSCODE = [self.bUSINESSCODE copy];
    copy.bUSINESSNAME = [self.bUSINESSNAME copy];
    copy.eDITDATE = [self.eDITDATE copy];
    copy.eNTIDX = [self.eNTIDX copy];
    copy.fEEAMOUNT = [self.fEEAMOUNT copy];
    copy.fEEDATE = [self.fEEDATE copy];
    copy.fEEDESC = [self.fEEDESC copy];
    copy.fEENAME = [self.fEENAME copy];
    copy.iDX = [self.iDX copy];
    copy.pARTYCODE = [self.pARTYCODE copy];
    copy.pARTYNAME = [self.pARTYNAME copy];
    copy.uSERNAME = [self.uSERNAME copy];
    
    return copy;
}

@end

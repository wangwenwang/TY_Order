//
//  StockModel.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "StockModel.h"


NSString *const kStockModelADDDATE = @"ADD_DATE";
NSString *const kStockModelBUSINESSCODE = @"BUSINESS_CODE";
NSString *const kStockModelBUSINESSIDX = @"BUSINESS_IDX";
NSString *const kStockModelBUSINESSNAME = @"BUSINESS_NAME";
NSString *const kStockModelEDITDATE = @"EDIT_DATE";
NSString *const kStockModelENTIDX = @"ENT_IDX";
NSString *const kStockModelIDX = @"IDX";
NSString *const kStockModelPARTYCODE = @"PARTY_CODE";
NSString *const kStockModelPARTYIDX = @"PARTY_IDX";
NSString *const kStockModelPARTYNAME = @"PARTY_NAME";
NSString *const kStockModelSTOCKDATE = @"STOCK_DATE";
NSString *const kStockModelSTOCKSTATE = @"STOCK_STATE";
NSString *const kStockModelSTOCKWORKFLOW = @"STOCK_WORKFLOW";
NSString *const kStockModelSUBMITDATE = @"SUBMIT_DATE";
NSString *const kStockModelUSERNAME = @"USER_NAME";


@implementation StockModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kStockModelADDDATE] isKindOfClass:[NSNull class]]){
        self.aDDDATE = dictionary[kStockModelADDDATE];
    }
    if(![dictionary[kStockModelBUSINESSCODE] isKindOfClass:[NSNull class]]){
        self.bUSINESSCODE = dictionary[kStockModelBUSINESSCODE];
    }
    if(![dictionary[kStockModelBUSINESSIDX] isKindOfClass:[NSNull class]]){
        self.bUSINESSIDX = dictionary[kStockModelBUSINESSIDX];
    }
    if(![dictionary[kStockModelBUSINESSNAME] isKindOfClass:[NSNull class]]){
        self.bUSINESSNAME = dictionary[kStockModelBUSINESSNAME];
    }
    if(![dictionary[kStockModelEDITDATE] isKindOfClass:[NSNull class]]){
        self.eDITDATE = dictionary[kStockModelEDITDATE];
    }
    if(![dictionary[kStockModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kStockModelENTIDX];
    }
    if(![dictionary[kStockModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kStockModelIDX];
    }
    if(![dictionary[kStockModelPARTYCODE] isKindOfClass:[NSNull class]]){
        self.pARTYCODE = dictionary[kStockModelPARTYCODE];
    }
    if(![dictionary[kStockModelPARTYIDX] isKindOfClass:[NSNull class]]){
        self.pARTYIDX = dictionary[kStockModelPARTYIDX];
    }
    if(![dictionary[kStockModelPARTYNAME] isKindOfClass:[NSNull class]]){
        self.pARTYNAME = dictionary[kStockModelPARTYNAME];
    }
    if(![dictionary[kStockModelSTOCKDATE] isKindOfClass:[NSNull class]]){
        self.sTOCKDATE = dictionary[kStockModelSTOCKDATE];
    }
    if(![dictionary[kStockModelSTOCKSTATE] isKindOfClass:[NSNull class]]){
        self.sTOCKSTATE = dictionary[kStockModelSTOCKSTATE];
    }
    if(![dictionary[kStockModelSTOCKWORKFLOW] isKindOfClass:[NSNull class]]){
        self.sTOCKWORKFLOW = dictionary[kStockModelSTOCKWORKFLOW];
    }
    if(![dictionary[kStockModelSUBMITDATE] isKindOfClass:[NSNull class]]){
        self.sUBMITDATE = dictionary[kStockModelSUBMITDATE];
    }
    if(![dictionary[kStockModelUSERNAME] isKindOfClass:[NSNull class]]){
        self.uSERNAME = dictionary[kStockModelUSERNAME];
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
        dictionary[kStockModelADDDATE] = self.aDDDATE;
    }
    if(self.bUSINESSCODE != nil){
        dictionary[kStockModelBUSINESSCODE] = self.bUSINESSCODE;
    }
    if(self.bUSINESSIDX != nil){
        dictionary[kStockModelBUSINESSIDX] = self.bUSINESSIDX;
    }
    if(self.bUSINESSNAME != nil){
        dictionary[kStockModelBUSINESSNAME] = self.bUSINESSNAME;
    }
    if(self.eDITDATE != nil){
        dictionary[kStockModelEDITDATE] = self.eDITDATE;
    }
    if(self.eNTIDX != nil){
        dictionary[kStockModelENTIDX] = self.eNTIDX;
    }
    if(self.iDX != nil){
        dictionary[kStockModelIDX] = self.iDX;
    }
    if(self.pARTYCODE != nil){
        dictionary[kStockModelPARTYCODE] = self.pARTYCODE;
    }
    if(self.pARTYIDX != nil){
        dictionary[kStockModelPARTYIDX] = self.pARTYIDX;
    }
    if(self.pARTYNAME != nil){
        dictionary[kStockModelPARTYNAME] = self.pARTYNAME;
    }
    if(self.sTOCKDATE != nil){
        dictionary[kStockModelSTOCKDATE] = self.sTOCKDATE;
    }
    if(self.sTOCKSTATE != nil){
        dictionary[kStockModelSTOCKSTATE] = self.sTOCKSTATE;
    }
    if(self.sTOCKWORKFLOW != nil){
        dictionary[kStockModelSTOCKWORKFLOW] = self.sTOCKWORKFLOW;
    }
    if(self.sUBMITDATE != nil){
        dictionary[kStockModelSUBMITDATE] = self.sUBMITDATE;
    }
    if(self.uSERNAME != nil){
        dictionary[kStockModelUSERNAME] = self.uSERNAME;
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
        [aCoder encodeObject:self.aDDDATE forKey:kStockModelADDDATE];
    }
    if(self.bUSINESSCODE != nil){
        [aCoder encodeObject:self.bUSINESSCODE forKey:kStockModelBUSINESSCODE];
    }
    if(self.bUSINESSIDX != nil){
        [aCoder encodeObject:self.bUSINESSIDX forKey:kStockModelBUSINESSIDX];
    }
    if(self.bUSINESSNAME != nil){
        [aCoder encodeObject:self.bUSINESSNAME forKey:kStockModelBUSINESSNAME];
    }
    if(self.eDITDATE != nil){
        [aCoder encodeObject:self.eDITDATE forKey:kStockModelEDITDATE];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kStockModelENTIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kStockModelIDX];
    }
    if(self.pARTYCODE != nil){
        [aCoder encodeObject:self.pARTYCODE forKey:kStockModelPARTYCODE];
    }
    if(self.pARTYIDX != nil){
        [aCoder encodeObject:self.pARTYIDX forKey:kStockModelPARTYIDX];
    }
    if(self.pARTYNAME != nil){
        [aCoder encodeObject:self.pARTYNAME forKey:kStockModelPARTYNAME];
    }
    if(self.sTOCKDATE != nil){
        [aCoder encodeObject:self.sTOCKDATE forKey:kStockModelSTOCKDATE];
    }
    if(self.sTOCKSTATE != nil){
        [aCoder encodeObject:self.sTOCKSTATE forKey:kStockModelSTOCKSTATE];
    }
    if(self.sTOCKWORKFLOW != nil){
        [aCoder encodeObject:self.sTOCKWORKFLOW forKey:kStockModelSTOCKWORKFLOW];
    }
    if(self.sUBMITDATE != nil){
        [aCoder encodeObject:self.sUBMITDATE forKey:kStockModelSUBMITDATE];
    }
    if(self.uSERNAME != nil){
        [aCoder encodeObject:self.uSERNAME forKey:kStockModelUSERNAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aDDDATE = [aDecoder decodeObjectForKey:kStockModelADDDATE];
    self.bUSINESSCODE = [aDecoder decodeObjectForKey:kStockModelBUSINESSCODE];
    self.bUSINESSIDX = [aDecoder decodeObjectForKey:kStockModelBUSINESSIDX];
    self.bUSINESSNAME = [aDecoder decodeObjectForKey:kStockModelBUSINESSNAME];
    self.eDITDATE = [aDecoder decodeObjectForKey:kStockModelEDITDATE];
    self.eNTIDX = [aDecoder decodeObjectForKey:kStockModelENTIDX];
    self.iDX = [aDecoder decodeObjectForKey:kStockModelIDX];
    self.pARTYCODE = [aDecoder decodeObjectForKey:kStockModelPARTYCODE];
    self.pARTYIDX = [aDecoder decodeObjectForKey:kStockModelPARTYIDX];
    self.pARTYNAME = [aDecoder decodeObjectForKey:kStockModelPARTYNAME];
    self.sTOCKDATE = [aDecoder decodeObjectForKey:kStockModelSTOCKDATE];
    self.sTOCKSTATE = [aDecoder decodeObjectForKey:kStockModelSTOCKSTATE];
    self.sTOCKWORKFLOW = [aDecoder decodeObjectForKey:kStockModelSTOCKWORKFLOW];
    self.sUBMITDATE = [aDecoder decodeObjectForKey:kStockModelSUBMITDATE];
    self.uSERNAME = [aDecoder decodeObjectForKey:kStockModelUSERNAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    StockModel *copy = [StockModel new];
    
    copy.aDDDATE = [self.aDDDATE copy];
    copy.bUSINESSCODE = [self.bUSINESSCODE copy];
    copy.bUSINESSIDX = [self.bUSINESSIDX copy];
    copy.bUSINESSNAME = [self.bUSINESSNAME copy];
    copy.eDITDATE = [self.eDITDATE copy];
    copy.eNTIDX = [self.eNTIDX copy];
    copy.iDX = [self.iDX copy];
    copy.pARTYCODE = [self.pARTYCODE copy];
    copy.pARTYIDX = [self.pARTYIDX copy];
    copy.pARTYNAME = [self.pARTYNAME copy];
    copy.sTOCKDATE = [self.sTOCKDATE copy];
    copy.sTOCKSTATE = [self.sTOCKSTATE copy];
    copy.sTOCKWORKFLOW = [self.sTOCKWORKFLOW copy];
    copy.sUBMITDATE = [self.sUBMITDATE copy];
    copy.uSERNAME = [self.uSERNAME copy];
    
    return copy;
}

@end

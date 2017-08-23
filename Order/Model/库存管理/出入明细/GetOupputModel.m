//
//  GetOupputModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputModel.h"


NSString *const kGetOupputModelADDRESSCODE = @"ADDRESS_CODE";
NSString *const kGetOupputModelADDRESSIDX = @"ADDRESS_IDX";
NSString *const kGetOupputModelADDRESSINFO = @"ADDRESS_INFO";
NSString *const kGetOupputModelADDRESSNAME = @"ADDRESS_NAME";
NSString *const kGetOupputModelADDDATE = @"ADD_DATE";
NSString *const kGetOupputModelADDUSER = @"ADD_USER";
NSString *const kGetOupputModelADUTDATE = @"ADUT_DATE";
NSString *const kGetOupputModelADUTMARK = @"ADUT_MARK";
NSString *const kGetOupputModelADUTUSER = @"ADUT_USER";
NSString *const kGetOupputModelBUSINESSIDX = @"BUSINESS_IDX";
NSString *const kGetOupputModelEDITDATE = @"EDIT_DATE";
NSString *const kGetOupputModelENTIDX = @"ENT_IDX";
NSString *const kGetOupputModelIDX = @"IDX";
NSString *const kGetOupputModelINPUTNO = @"INPUT_NO";
NSString *const kGetOupputModelOPERUSER = @"OPER_USER";
NSString *const kGetOupputModelOUTPUTDATE = @"OUTPUT_DATE";
NSString *const kGetOupputModelOUTPUTNO = @"OUTPUT_NO";
NSString *const kGetOupputModelOUTPUTQTY = @"OUTPUT_QTY";
NSString *const kGetOupputModelOUTPUTSTATE = @"OUTPUT_STATE";
NSString *const kGetOupputModelOUTPUTSUM = @"OUTPUT_SUM";
NSString *const kGetOupputModelOUTPUTTYPE = @"OUTPUT_TYPE";
NSString *const kGetOupputModelOUTPUTVOLUME = @"OUTPUT_VOLUME";
NSString *const kGetOupputModelOUTPUTWEIGHT = @"OUTPUT_WEIGHT";
NSString *const kGetOupputModelOUTPUTWORKFLOW = @"OUTPUT_WORKFLOW";
NSString *const kGetOupputModelPARTYCODE = @"PARTY_CODE";
NSString *const kGetOupputModelPARTYINFO = @"PARTY_INFO";
NSString *const kGetOupputModelPARTYMARK = @"PARTY_MARK";
NSString *const kGetOupputModelPARTYNAME = @"PARTY_NAME";
NSString *const kGetOupputModelPRICE = @"PRICE";


@implementation GetOupputModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetOupputModelADDRESSCODE] isKindOfClass:[NSNull class]]){
        self.aDDRESSCODE = dictionary[kGetOupputModelADDRESSCODE];
    }
    if(![dictionary[kGetOupputModelADDRESSIDX] isKindOfClass:[NSNull class]]){
        self.aDDRESSIDX = dictionary[kGetOupputModelADDRESSIDX];
    }
    if(![dictionary[kGetOupputModelADDRESSINFO] isKindOfClass:[NSNull class]]){
        self.aDDRESSINFO = dictionary[kGetOupputModelADDRESSINFO];
    }
    if(![dictionary[kGetOupputModelADDRESSNAME] isKindOfClass:[NSNull class]]){
        self.aDDRESSNAME = dictionary[kGetOupputModelADDRESSNAME];
    }
    if(![dictionary[kGetOupputModelADDDATE] isKindOfClass:[NSNull class]]){
        self.aDDDATE = dictionary[kGetOupputModelADDDATE];
    }
    if(![dictionary[kGetOupputModelADDUSER] isKindOfClass:[NSNull class]]){
        self.aDDUSER = dictionary[kGetOupputModelADDUSER];
    }
    if(![dictionary[kGetOupputModelADUTDATE] isKindOfClass:[NSNull class]]){
        self.aDUTDATE = dictionary[kGetOupputModelADUTDATE];
    }
    if(![dictionary[kGetOupputModelADUTMARK] isKindOfClass:[NSNull class]]){
        self.aDUTMARK = dictionary[kGetOupputModelADUTMARK];
    }
    if(![dictionary[kGetOupputModelADUTUSER] isKindOfClass:[NSNull class]]){
        self.aDUTUSER = dictionary[kGetOupputModelADUTUSER];
    }
    if(![dictionary[kGetOupputModelBUSINESSIDX] isKindOfClass:[NSNull class]]){
        self.bUSINESSIDX = dictionary[kGetOupputModelBUSINESSIDX];
    }
    if(![dictionary[kGetOupputModelEDITDATE] isKindOfClass:[NSNull class]]){
        self.eDITDATE = dictionary[kGetOupputModelEDITDATE];
    }
    if(![dictionary[kGetOupputModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kGetOupputModelENTIDX];
    }
    if(![dictionary[kGetOupputModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kGetOupputModelIDX];
    }
    if(![dictionary[kGetOupputModelINPUTNO] isKindOfClass:[NSNull class]]){
        self.iNPUTNO = dictionary[kGetOupputModelINPUTNO];
    }
    if(![dictionary[kGetOupputModelOPERUSER] isKindOfClass:[NSNull class]]){
        self.oPERUSER = dictionary[kGetOupputModelOPERUSER];
    }
    if(![dictionary[kGetOupputModelOUTPUTDATE] isKindOfClass:[NSNull class]]){
        self.oUTPUTDATE = dictionary[kGetOupputModelOUTPUTDATE];
    }
    if(![dictionary[kGetOupputModelOUTPUTNO] isKindOfClass:[NSNull class]]){
        self.oUTPUTNO = dictionary[kGetOupputModelOUTPUTNO];
    }
    if(![dictionary[kGetOupputModelOUTPUTQTY] isKindOfClass:[NSNull class]]){
        self.oUTPUTQTY = dictionary[kGetOupputModelOUTPUTQTY];
    }
    if(![dictionary[kGetOupputModelOUTPUTSTATE] isKindOfClass:[NSNull class]]){
        self.oUTPUTSTATE = dictionary[kGetOupputModelOUTPUTSTATE];
    }
    if(![dictionary[kGetOupputModelOUTPUTSUM] isKindOfClass:[NSNull class]]){
        self.oUTPUTSUM = dictionary[kGetOupputModelOUTPUTSUM];
    }
    if(![dictionary[kGetOupputModelOUTPUTTYPE] isKindOfClass:[NSNull class]]){
        self.oUTPUTTYPE = dictionary[kGetOupputModelOUTPUTTYPE];
    }
    if(![dictionary[kGetOupputModelOUTPUTVOLUME] isKindOfClass:[NSNull class]]){
        self.oUTPUTVOLUME = dictionary[kGetOupputModelOUTPUTVOLUME];
    }
    if(![dictionary[kGetOupputModelOUTPUTWEIGHT] isKindOfClass:[NSNull class]]){
        self.oUTPUTWEIGHT = dictionary[kGetOupputModelOUTPUTWEIGHT];
    }
    if(![dictionary[kGetOupputModelOUTPUTWORKFLOW] isKindOfClass:[NSNull class]]){
        self.oUTPUTWORKFLOW = dictionary[kGetOupputModelOUTPUTWORKFLOW];
    }
    if(![dictionary[kGetOupputModelPARTYCODE] isKindOfClass:[NSNull class]]){
        self.pARTYCODE = dictionary[kGetOupputModelPARTYCODE];
    }
    if(![dictionary[kGetOupputModelPARTYINFO] isKindOfClass:[NSNull class]]){
        self.pARTYINFO = dictionary[kGetOupputModelPARTYINFO];
    }
    if(![dictionary[kGetOupputModelPARTYMARK] isKindOfClass:[NSNull class]]){
        self.pARTYMARK = dictionary[kGetOupputModelPARTYMARK];
    }
    if(![dictionary[kGetOupputModelPARTYNAME] isKindOfClass:[NSNull class]]){
        self.pARTYNAME = dictionary[kGetOupputModelPARTYNAME];
    }
    if(![dictionary[kGetOupputModelPRICE] isKindOfClass:[NSNull class]]){
        self.pRICE = dictionary[kGetOupputModelPRICE];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.aDDRESSCODE != nil){
        dictionary[kGetOupputModelADDRESSCODE] = self.aDDRESSCODE;
    }
    if(self.aDDRESSIDX != nil){
        dictionary[kGetOupputModelADDRESSIDX] = self.aDDRESSIDX;
    }
    if(self.aDDRESSINFO != nil){
        dictionary[kGetOupputModelADDRESSINFO] = self.aDDRESSINFO;
    }
    if(self.aDDRESSNAME != nil){
        dictionary[kGetOupputModelADDRESSNAME] = self.aDDRESSNAME;
    }
    if(self.aDDDATE != nil){
        dictionary[kGetOupputModelADDDATE] = self.aDDDATE;
    }
    if(self.aDDUSER != nil){
        dictionary[kGetOupputModelADDUSER] = self.aDDUSER;
    }
    if(self.aDUTDATE != nil){
        dictionary[kGetOupputModelADUTDATE] = self.aDUTDATE;
    }
    if(self.aDUTMARK != nil){
        dictionary[kGetOupputModelADUTMARK] = self.aDUTMARK;
    }
    if(self.aDUTUSER != nil){
        dictionary[kGetOupputModelADUTUSER] = self.aDUTUSER;
    }
    if(self.bUSINESSIDX != nil){
        dictionary[kGetOupputModelBUSINESSIDX] = self.bUSINESSIDX;
    }
    if(self.eDITDATE != nil){
        dictionary[kGetOupputModelEDITDATE] = self.eDITDATE;
    }
    if(self.eNTIDX != nil){
        dictionary[kGetOupputModelENTIDX] = self.eNTIDX;
    }
    if(self.iDX != nil){
        dictionary[kGetOupputModelIDX] = self.iDX;
    }
    if(self.iNPUTNO != nil){
        dictionary[kGetOupputModelINPUTNO] = self.iNPUTNO;
    }
    if(self.oPERUSER != nil){
        dictionary[kGetOupputModelOPERUSER] = self.oPERUSER;
    }
    if(self.oUTPUTDATE != nil){
        dictionary[kGetOupputModelOUTPUTDATE] = self.oUTPUTDATE;
    }
    if(self.oUTPUTNO != nil){
        dictionary[kGetOupputModelOUTPUTNO] = self.oUTPUTNO;
    }
    if(self.oUTPUTQTY != nil){
        dictionary[kGetOupputModelOUTPUTQTY] = self.oUTPUTQTY;
    }
    if(self.oUTPUTSTATE != nil){
        dictionary[kGetOupputModelOUTPUTSTATE] = self.oUTPUTSTATE;
    }
    if(self.oUTPUTSUM != nil){
        dictionary[kGetOupputModelOUTPUTSUM] = self.oUTPUTSUM;
    }
    if(self.oUTPUTTYPE != nil){
        dictionary[kGetOupputModelOUTPUTTYPE] = self.oUTPUTTYPE;
    }
    if(self.oUTPUTVOLUME != nil){
        dictionary[kGetOupputModelOUTPUTVOLUME] = self.oUTPUTVOLUME;
    }
    if(self.oUTPUTWEIGHT != nil){
        dictionary[kGetOupputModelOUTPUTWEIGHT] = self.oUTPUTWEIGHT;
    }
    if(self.oUTPUTWORKFLOW != nil){
        dictionary[kGetOupputModelOUTPUTWORKFLOW] = self.oUTPUTWORKFLOW;
    }
    if(self.pARTYCODE != nil){
        dictionary[kGetOupputModelPARTYCODE] = self.pARTYCODE;
    }
    if(self.pARTYINFO != nil){
        dictionary[kGetOupputModelPARTYINFO] = self.pARTYINFO;
    }
    if(self.pARTYMARK != nil){
        dictionary[kGetOupputModelPARTYMARK] = self.pARTYMARK;
    }
    if(self.pARTYNAME != nil){
        dictionary[kGetOupputModelPARTYNAME] = self.pARTYNAME;
    }
    if(self.pRICE != nil){
        dictionary[kGetOupputModelPRICE] = self.pRICE;
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
    if(self.aDDRESSCODE != nil){
        [aCoder encodeObject:self.aDDRESSCODE forKey:kGetOupputModelADDRESSCODE];
    }
    if(self.aDDRESSIDX != nil){
        [aCoder encodeObject:self.aDDRESSIDX forKey:kGetOupputModelADDRESSIDX];
    }
    if(self.aDDRESSINFO != nil){
        [aCoder encodeObject:self.aDDRESSINFO forKey:kGetOupputModelADDRESSINFO];
    }
    if(self.aDDRESSNAME != nil){
        [aCoder encodeObject:self.aDDRESSNAME forKey:kGetOupputModelADDRESSNAME];
    }
    if(self.aDDDATE != nil){
        [aCoder encodeObject:self.aDDDATE forKey:kGetOupputModelADDDATE];
    }
    if(self.aDDUSER != nil){
        [aCoder encodeObject:self.aDDUSER forKey:kGetOupputModelADDUSER];
    }
    if(self.aDUTDATE != nil){
        [aCoder encodeObject:self.aDUTDATE forKey:kGetOupputModelADUTDATE];
    }
    if(self.aDUTMARK != nil){
        [aCoder encodeObject:self.aDUTMARK forKey:kGetOupputModelADUTMARK];
    }
    if(self.aDUTUSER != nil){
        [aCoder encodeObject:self.aDUTUSER forKey:kGetOupputModelADUTUSER];
    }
    if(self.bUSINESSIDX != nil){
        [aCoder encodeObject:self.bUSINESSIDX forKey:kGetOupputModelBUSINESSIDX];
    }
    if(self.eDITDATE != nil){
        [aCoder encodeObject:self.eDITDATE forKey:kGetOupputModelEDITDATE];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kGetOupputModelENTIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kGetOupputModelIDX];
    }
    if(self.iNPUTNO != nil){
        [aCoder encodeObject:self.iNPUTNO forKey:kGetOupputModelINPUTNO];
    }
    if(self.oPERUSER != nil){
        [aCoder encodeObject:self.oPERUSER forKey:kGetOupputModelOPERUSER];
    }
    if(self.oUTPUTDATE != nil){
        [aCoder encodeObject:self.oUTPUTDATE forKey:kGetOupputModelOUTPUTDATE];
    }
    if(self.oUTPUTNO != nil){
        [aCoder encodeObject:self.oUTPUTNO forKey:kGetOupputModelOUTPUTNO];
    }
    if(self.oUTPUTQTY != nil){
        [aCoder encodeObject:self.oUTPUTQTY forKey:kGetOupputModelOUTPUTQTY];
    }
    if(self.oUTPUTSTATE != nil){
        [aCoder encodeObject:self.oUTPUTSTATE forKey:kGetOupputModelOUTPUTSTATE];
    }
    if(self.oUTPUTSUM != nil){
        [aCoder encodeObject:self.oUTPUTSUM forKey:kGetOupputModelOUTPUTSUM];
    }
    if(self.oUTPUTTYPE != nil){
        [aCoder encodeObject:self.oUTPUTTYPE forKey:kGetOupputModelOUTPUTTYPE];
    }
    if(self.oUTPUTVOLUME != nil){
        [aCoder encodeObject:self.oUTPUTVOLUME forKey:kGetOupputModelOUTPUTVOLUME];
    }
    if(self.oUTPUTWEIGHT != nil){
        [aCoder encodeObject:self.oUTPUTWEIGHT forKey:kGetOupputModelOUTPUTWEIGHT];
    }
    if(self.oUTPUTWORKFLOW != nil){
        [aCoder encodeObject:self.oUTPUTWORKFLOW forKey:kGetOupputModelOUTPUTWORKFLOW];
    }
    if(self.pARTYCODE != nil){
        [aCoder encodeObject:self.pARTYCODE forKey:kGetOupputModelPARTYCODE];
    }
    if(self.pARTYINFO != nil){
        [aCoder encodeObject:self.pARTYINFO forKey:kGetOupputModelPARTYINFO];
    }
    if(self.pARTYMARK != nil){
        [aCoder encodeObject:self.pARTYMARK forKey:kGetOupputModelPARTYMARK];
    }
    if(self.pARTYNAME != nil){
        [aCoder encodeObject:self.pARTYNAME forKey:kGetOupputModelPARTYNAME];
    }
    if(self.pRICE != nil){
        [aCoder encodeObject:self.pRICE forKey:kGetOupputModelPRICE];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aDDRESSCODE = [aDecoder decodeObjectForKey:kGetOupputModelADDRESSCODE];
    self.aDDRESSIDX = [aDecoder decodeObjectForKey:kGetOupputModelADDRESSIDX];
    self.aDDRESSINFO = [aDecoder decodeObjectForKey:kGetOupputModelADDRESSINFO];
    self.aDDRESSNAME = [aDecoder decodeObjectForKey:kGetOupputModelADDRESSNAME];
    self.aDDDATE = [aDecoder decodeObjectForKey:kGetOupputModelADDDATE];
    self.aDDUSER = [aDecoder decodeObjectForKey:kGetOupputModelADDUSER];
    self.aDUTDATE = [aDecoder decodeObjectForKey:kGetOupputModelADUTDATE];
    self.aDUTMARK = [aDecoder decodeObjectForKey:kGetOupputModelADUTMARK];
    self.aDUTUSER = [aDecoder decodeObjectForKey:kGetOupputModelADUTUSER];
    self.bUSINESSIDX = [aDecoder decodeObjectForKey:kGetOupputModelBUSINESSIDX];
    self.eDITDATE = [aDecoder decodeObjectForKey:kGetOupputModelEDITDATE];
    self.eNTIDX = [aDecoder decodeObjectForKey:kGetOupputModelENTIDX];
    self.iDX = [aDecoder decodeObjectForKey:kGetOupputModelIDX];
    self.iNPUTNO = [aDecoder decodeObjectForKey:kGetOupputModelINPUTNO];
    self.oPERUSER = [aDecoder decodeObjectForKey:kGetOupputModelOPERUSER];
    self.oUTPUTDATE = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTDATE];
    self.oUTPUTNO = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTNO];
    self.oUTPUTQTY = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTQTY];
    self.oUTPUTSTATE = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTSTATE];
    self.oUTPUTSUM = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTSUM];
    self.oUTPUTTYPE = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTTYPE];
    self.oUTPUTVOLUME = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTVOLUME];
    self.oUTPUTWEIGHT = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTWEIGHT];
    self.oUTPUTWORKFLOW = [aDecoder decodeObjectForKey:kGetOupputModelOUTPUTWORKFLOW];
    self.pARTYCODE = [aDecoder decodeObjectForKey:kGetOupputModelPARTYCODE];
    self.pARTYINFO = [aDecoder decodeObjectForKey:kGetOupputModelPARTYINFO];
    self.pARTYMARK = [aDecoder decodeObjectForKey:kGetOupputModelPARTYMARK];
    self.pARTYNAME = [aDecoder decodeObjectForKey:kGetOupputModelPARTYNAME];
    self.pRICE = [aDecoder decodeObjectForKey:kGetOupputModelPRICE];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOupputModel *copy = [GetOupputModel new];
    
    copy.aDDRESSCODE = [self.aDDRESSCODE copy];
    copy.aDDRESSIDX = [self.aDDRESSIDX copy];
    copy.aDDRESSINFO = [self.aDDRESSINFO copy];
    copy.aDDRESSNAME = [self.aDDRESSNAME copy];
    copy.aDDDATE = [self.aDDDATE copy];
    copy.aDDUSER = [self.aDDUSER copy];
    copy.aDUTDATE = [self.aDUTDATE copy];
    copy.aDUTMARK = [self.aDUTMARK copy];
    copy.aDUTUSER = [self.aDUTUSER copy];
    copy.bUSINESSIDX = [self.bUSINESSIDX copy];
    copy.eDITDATE = [self.eDITDATE copy];
    copy.eNTIDX = [self.eNTIDX copy];
    copy.iDX = [self.iDX copy];
    copy.iNPUTNO = [self.iNPUTNO copy];
    copy.oPERUSER = [self.oPERUSER copy];
    copy.oUTPUTDATE = [self.oUTPUTDATE copy];
    copy.oUTPUTNO = [self.oUTPUTNO copy];
    copy.oUTPUTQTY = [self.oUTPUTQTY copy];
    copy.oUTPUTSTATE = [self.oUTPUTSTATE copy];
    copy.oUTPUTSUM = [self.oUTPUTSUM copy];
    copy.oUTPUTTYPE = [self.oUTPUTTYPE copy];
    copy.oUTPUTVOLUME = [self.oUTPUTVOLUME copy];
    copy.oUTPUTWEIGHT = [self.oUTPUTWEIGHT copy];
    copy.oUTPUTWORKFLOW = [self.oUTPUTWORKFLOW copy];
    copy.pARTYCODE = [self.pARTYCODE copy];
    copy.pARTYINFO = [self.pARTYINFO copy];
    copy.pARTYMARK = [self.pARTYMARK copy];
    copy.pARTYNAME = [self.pARTYNAME copy];
    copy.pRICE = [self.pRICE copy];
    
    return copy;
}

@end

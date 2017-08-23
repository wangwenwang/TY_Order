//
//  GetOupputInfoModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputInfoModel.h"


NSString *const kGetOupputInfoModelADDRESSCODE = @"ADDRESS_CODE";
NSString *const kGetOupputInfoModelADDRESSIDX = @"ADDRESS_IDX";
NSString *const kGetOupputInfoModelADDRESSINFO = @"ADDRESS_INFO";
NSString *const kGetOupputInfoModelADDRESSNAME = @"ADDRESS_NAME";
NSString *const kGetOupputInfoModelADDDATE = @"ADD_DATE";
NSString *const kGetOupputInfoModelADDUSER = @"ADD_USER";
NSString *const kGetOupputInfoModelADUTDATE = @"ADUT_DATE";
NSString *const kGetOupputInfoModelADUTMARK = @"ADUT_MARK";
NSString *const kGetOupputInfoModelADUTUSER = @"ADUT_USER";
NSString *const kGetOupputInfoModelBUSINESSIDX = @"BUSINESS_IDX";
NSString *const kGetOupputInfoModelEDITDATE = @"EDIT_DATE";
NSString *const kGetOupputInfoModelENTIDX = @"ENT_IDX";
NSString *const kGetOupputInfoModelIDX = @"IDX";
NSString *const kGetOupputInfoModelINPUTNO = @"INPUT_NO";
NSString *const kGetOupputInfoModelOPERUSER = @"OPER_USER";
NSString *const kGetOupputInfoModelOUTPUTDATE = @"OUTPUT_DATE";
NSString *const kGetOupputInfoModelOUTPUTNO = @"OUTPUT_NO";
NSString *const kGetOupputInfoModelOUTPUTQTY = @"OUTPUT_QTY";
NSString *const kGetOupputInfoModelOUTPUTSTATE = @"OUTPUT_STATE";
NSString *const kGetOupputInfoModelOUTPUTSUM = @"OUTPUT_SUM";
NSString *const kGetOupputInfoModelOUTPUTVOLUME = @"OUTPUT_VOLUME";
NSString *const kGetOupputInfoModelOUTPUTWEIGHT = @"OUTPUT_WEIGHT";
NSString *const kGetOupputInfoModelOUTPUTWORKFLOW = @"OUTPUT_WORKFLOW";
NSString *const kGetOupputInfoModelPARTYCODE = @"PARTY_CODE";
NSString *const kGetOupputInfoModelPARTYINFO = @"PARTY_INFO";
NSString *const kGetOupputInfoModelPARTYMARK = @"PARTY_MARK";
NSString *const kGetOupputInfoModelPARTYNAME = @"PARTY_NAME";
NSString *const kGetOupputInfoModelPRICE = @"PRICE";


@implementation GetOupputInfoModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetOupputInfoModelADDRESSCODE] isKindOfClass:[NSNull class]]){
        self.aDDRESSCODE = dictionary[kGetOupputInfoModelADDRESSCODE];
    }
    if(![dictionary[kGetOupputInfoModelADDRESSIDX] isKindOfClass:[NSNull class]]){
        self.aDDRESSIDX = dictionary[kGetOupputInfoModelADDRESSIDX];
    }
    if(![dictionary[kGetOupputInfoModelADDRESSINFO] isKindOfClass:[NSNull class]]){
        self.aDDRESSINFO = dictionary[kGetOupputInfoModelADDRESSINFO];
    }
    if(![dictionary[kGetOupputInfoModelADDRESSNAME] isKindOfClass:[NSNull class]]){
        self.aDDRESSNAME = dictionary[kGetOupputInfoModelADDRESSNAME];
    }
    if(![dictionary[kGetOupputInfoModelADDDATE] isKindOfClass:[NSNull class]]){
        self.aDDDATE = dictionary[kGetOupputInfoModelADDDATE];
    }
    if(![dictionary[kGetOupputInfoModelADDUSER] isKindOfClass:[NSNull class]]){
        self.aDDUSER = dictionary[kGetOupputInfoModelADDUSER];
    }
    if(![dictionary[kGetOupputInfoModelADUTDATE] isKindOfClass:[NSNull class]]){
        self.aDUTDATE = dictionary[kGetOupputInfoModelADUTDATE];
    }
    if(![dictionary[kGetOupputInfoModelADUTMARK] isKindOfClass:[NSNull class]]){
        self.aDUTMARK = dictionary[kGetOupputInfoModelADUTMARK];
    }
    if(![dictionary[kGetOupputInfoModelADUTUSER] isKindOfClass:[NSNull class]]){
        self.aDUTUSER = dictionary[kGetOupputInfoModelADUTUSER];
    }
    if(![dictionary[kGetOupputInfoModelBUSINESSIDX] isKindOfClass:[NSNull class]]){
        self.bUSINESSIDX = dictionary[kGetOupputInfoModelBUSINESSIDX];
    }
    if(![dictionary[kGetOupputInfoModelEDITDATE] isKindOfClass:[NSNull class]]){
        self.eDITDATE = dictionary[kGetOupputInfoModelEDITDATE];
    }
    if(![dictionary[kGetOupputInfoModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kGetOupputInfoModelENTIDX];
    }
    if(![dictionary[kGetOupputInfoModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kGetOupputInfoModelIDX];
    }
    if(![dictionary[kGetOupputInfoModelINPUTNO] isKindOfClass:[NSNull class]]){
        self.iNPUTNO = dictionary[kGetOupputInfoModelINPUTNO];
    }
    if(![dictionary[kGetOupputInfoModelOPERUSER] isKindOfClass:[NSNull class]]){
        self.oPERUSER = dictionary[kGetOupputInfoModelOPERUSER];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTDATE] isKindOfClass:[NSNull class]]){
        self.oUTPUTDATE = dictionary[kGetOupputInfoModelOUTPUTDATE];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTNO] isKindOfClass:[NSNull class]]){
        self.oUTPUTNO = dictionary[kGetOupputInfoModelOUTPUTNO];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTQTY] isKindOfClass:[NSNull class]]){
        self.oUTPUTQTY = dictionary[kGetOupputInfoModelOUTPUTQTY];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTSTATE] isKindOfClass:[NSNull class]]){
        self.oUTPUTSTATE = dictionary[kGetOupputInfoModelOUTPUTSTATE];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTSUM] isKindOfClass:[NSNull class]]){
        self.oUTPUTSUM = dictionary[kGetOupputInfoModelOUTPUTSUM];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTVOLUME] isKindOfClass:[NSNull class]]){
        self.oUTPUTVOLUME = dictionary[kGetOupputInfoModelOUTPUTVOLUME];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTWEIGHT] isKindOfClass:[NSNull class]]){
        self.oUTPUTWEIGHT = dictionary[kGetOupputInfoModelOUTPUTWEIGHT];
    }
    if(![dictionary[kGetOupputInfoModelOUTPUTWORKFLOW] isKindOfClass:[NSNull class]]){
        self.oUTPUTWORKFLOW = dictionary[kGetOupputInfoModelOUTPUTWORKFLOW];
    }
    if(![dictionary[kGetOupputInfoModelPARTYCODE] isKindOfClass:[NSNull class]]){
        self.pARTYCODE = dictionary[kGetOupputInfoModelPARTYCODE];
    }
    if(![dictionary[kGetOupputInfoModelPARTYINFO] isKindOfClass:[NSNull class]]){
        self.pARTYINFO = dictionary[kGetOupputInfoModelPARTYINFO];
    }
    if(![dictionary[kGetOupputInfoModelPARTYMARK] isKindOfClass:[NSNull class]]){
        self.pARTYMARK = dictionary[kGetOupputInfoModelPARTYMARK];
    }
    if(![dictionary[kGetOupputInfoModelPARTYNAME] isKindOfClass:[NSNull class]]){
        self.pARTYNAME = dictionary[kGetOupputInfoModelPARTYNAME];
    }
    if(![dictionary[kGetOupputInfoModelPRICE] isKindOfClass:[NSNull class]]){
        self.pRICE = dictionary[kGetOupputInfoModelPRICE];
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
        dictionary[kGetOupputInfoModelADDRESSCODE] = self.aDDRESSCODE;
    }
    if(self.aDDRESSIDX != nil){
        dictionary[kGetOupputInfoModelADDRESSIDX] = self.aDDRESSIDX;
    }
    if(self.aDDRESSINFO != nil){
        dictionary[kGetOupputInfoModelADDRESSINFO] = self.aDDRESSINFO;
    }
    if(self.aDDRESSNAME != nil){
        dictionary[kGetOupputInfoModelADDRESSNAME] = self.aDDRESSNAME;
    }
    if(self.aDDDATE != nil){
        dictionary[kGetOupputInfoModelADDDATE] = self.aDDDATE;
    }
    if(self.aDDUSER != nil){
        dictionary[kGetOupputInfoModelADDUSER] = self.aDDUSER;
    }
    if(self.aDUTDATE != nil){
        dictionary[kGetOupputInfoModelADUTDATE] = self.aDUTDATE;
    }
    if(self.aDUTMARK != nil){
        dictionary[kGetOupputInfoModelADUTMARK] = self.aDUTMARK;
    }
    if(self.aDUTUSER != nil){
        dictionary[kGetOupputInfoModelADUTUSER] = self.aDUTUSER;
    }
    if(self.bUSINESSIDX != nil){
        dictionary[kGetOupputInfoModelBUSINESSIDX] = self.bUSINESSIDX;
    }
    if(self.eDITDATE != nil){
        dictionary[kGetOupputInfoModelEDITDATE] = self.eDITDATE;
    }
    if(self.eNTIDX != nil){
        dictionary[kGetOupputInfoModelENTIDX] = self.eNTIDX;
    }
    if(self.iDX != nil){
        dictionary[kGetOupputInfoModelIDX] = self.iDX;
    }
    if(self.iNPUTNO != nil){
        dictionary[kGetOupputInfoModelINPUTNO] = self.iNPUTNO;
    }
    if(self.oPERUSER != nil){
        dictionary[kGetOupputInfoModelOPERUSER] = self.oPERUSER;
    }
    if(self.oUTPUTDATE != nil){
        dictionary[kGetOupputInfoModelOUTPUTDATE] = self.oUTPUTDATE;
    }
    if(self.oUTPUTNO != nil){
        dictionary[kGetOupputInfoModelOUTPUTNO] = self.oUTPUTNO;
    }
    if(self.oUTPUTQTY != nil){
        dictionary[kGetOupputInfoModelOUTPUTQTY] = self.oUTPUTQTY;
    }
    if(self.oUTPUTSTATE != nil){
        dictionary[kGetOupputInfoModelOUTPUTSTATE] = self.oUTPUTSTATE;
    }
    if(self.oUTPUTSUM != nil){
        dictionary[kGetOupputInfoModelOUTPUTSUM] = self.oUTPUTSUM;
    }
    if(self.oUTPUTVOLUME != nil){
        dictionary[kGetOupputInfoModelOUTPUTVOLUME] = self.oUTPUTVOLUME;
    }
    if(self.oUTPUTWEIGHT != nil){
        dictionary[kGetOupputInfoModelOUTPUTWEIGHT] = self.oUTPUTWEIGHT;
    }
    if(self.oUTPUTWORKFLOW != nil){
        dictionary[kGetOupputInfoModelOUTPUTWORKFLOW] = self.oUTPUTWORKFLOW;
    }
    if(self.pARTYCODE != nil){
        dictionary[kGetOupputInfoModelPARTYCODE] = self.pARTYCODE;
    }
    if(self.pARTYINFO != nil){
        dictionary[kGetOupputInfoModelPARTYINFO] = self.pARTYINFO;
    }
    if(self.pARTYMARK != nil){
        dictionary[kGetOupputInfoModelPARTYMARK] = self.pARTYMARK;
    }
    if(self.pARTYNAME != nil){
        dictionary[kGetOupputInfoModelPARTYNAME] = self.pARTYNAME;
    }
    if(self.pRICE != nil){
        dictionary[kGetOupputInfoModelPRICE] = self.pRICE;
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
        [aCoder encodeObject:self.aDDRESSCODE forKey:kGetOupputInfoModelADDRESSCODE];
    }
    if(self.aDDRESSIDX != nil){
        [aCoder encodeObject:self.aDDRESSIDX forKey:kGetOupputInfoModelADDRESSIDX];
    }
    if(self.aDDRESSINFO != nil){
        [aCoder encodeObject:self.aDDRESSINFO forKey:kGetOupputInfoModelADDRESSINFO];
    }
    if(self.aDDRESSNAME != nil){
        [aCoder encodeObject:self.aDDRESSNAME forKey:kGetOupputInfoModelADDRESSNAME];
    }
    if(self.aDDDATE != nil){
        [aCoder encodeObject:self.aDDDATE forKey:kGetOupputInfoModelADDDATE];
    }
    if(self.aDDUSER != nil){
        [aCoder encodeObject:self.aDDUSER forKey:kGetOupputInfoModelADDUSER];
    }
    if(self.aDUTDATE != nil){
        [aCoder encodeObject:self.aDUTDATE forKey:kGetOupputInfoModelADUTDATE];
    }
    if(self.aDUTMARK != nil){
        [aCoder encodeObject:self.aDUTMARK forKey:kGetOupputInfoModelADUTMARK];
    }
    if(self.aDUTUSER != nil){
        [aCoder encodeObject:self.aDUTUSER forKey:kGetOupputInfoModelADUTUSER];
    }
    if(self.bUSINESSIDX != nil){
        [aCoder encodeObject:self.bUSINESSIDX forKey:kGetOupputInfoModelBUSINESSIDX];
    }
    if(self.eDITDATE != nil){
        [aCoder encodeObject:self.eDITDATE forKey:kGetOupputInfoModelEDITDATE];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kGetOupputInfoModelENTIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kGetOupputInfoModelIDX];
    }
    if(self.iNPUTNO != nil){
        [aCoder encodeObject:self.iNPUTNO forKey:kGetOupputInfoModelINPUTNO];
    }
    if(self.oPERUSER != nil){
        [aCoder encodeObject:self.oPERUSER forKey:kGetOupputInfoModelOPERUSER];
    }
    if(self.oUTPUTDATE != nil){
        [aCoder encodeObject:self.oUTPUTDATE forKey:kGetOupputInfoModelOUTPUTDATE];
    }
    if(self.oUTPUTNO != nil){
        [aCoder encodeObject:self.oUTPUTNO forKey:kGetOupputInfoModelOUTPUTNO];
    }
    if(self.oUTPUTQTY != nil){
        [aCoder encodeObject:self.oUTPUTQTY forKey:kGetOupputInfoModelOUTPUTQTY];
    }
    if(self.oUTPUTSTATE != nil){
        [aCoder encodeObject:self.oUTPUTSTATE forKey:kGetOupputInfoModelOUTPUTSTATE];
    }
    if(self.oUTPUTSUM != nil){
        [aCoder encodeObject:self.oUTPUTSUM forKey:kGetOupputInfoModelOUTPUTSUM];
    }
    if(self.oUTPUTVOLUME != nil){
        [aCoder encodeObject:self.oUTPUTVOLUME forKey:kGetOupputInfoModelOUTPUTVOLUME];
    }
    if(self.oUTPUTWEIGHT != nil){
        [aCoder encodeObject:self.oUTPUTWEIGHT forKey:kGetOupputInfoModelOUTPUTWEIGHT];
    }
    if(self.oUTPUTWORKFLOW != nil){
        [aCoder encodeObject:self.oUTPUTWORKFLOW forKey:kGetOupputInfoModelOUTPUTWORKFLOW];
    }
    if(self.pARTYCODE != nil){
        [aCoder encodeObject:self.pARTYCODE forKey:kGetOupputInfoModelPARTYCODE];
    }
    if(self.pARTYINFO != nil){
        [aCoder encodeObject:self.pARTYINFO forKey:kGetOupputInfoModelPARTYINFO];
    }
    if(self.pARTYMARK != nil){
        [aCoder encodeObject:self.pARTYMARK forKey:kGetOupputInfoModelPARTYMARK];
    }
    if(self.pARTYNAME != nil){
        [aCoder encodeObject:self.pARTYNAME forKey:kGetOupputInfoModelPARTYNAME];
    }
    if(self.pRICE != nil){
        [aCoder encodeObject:self.pRICE forKey:kGetOupputInfoModelPRICE];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aDDRESSCODE = [aDecoder decodeObjectForKey:kGetOupputInfoModelADDRESSCODE];
    self.aDDRESSIDX = [aDecoder decodeObjectForKey:kGetOupputInfoModelADDRESSIDX];
    self.aDDRESSINFO = [aDecoder decodeObjectForKey:kGetOupputInfoModelADDRESSINFO];
    self.aDDRESSNAME = [aDecoder decodeObjectForKey:kGetOupputInfoModelADDRESSNAME];
    self.aDDDATE = [aDecoder decodeObjectForKey:kGetOupputInfoModelADDDATE];
    self.aDDUSER = [aDecoder decodeObjectForKey:kGetOupputInfoModelADDUSER];
    self.aDUTDATE = [aDecoder decodeObjectForKey:kGetOupputInfoModelADUTDATE];
    self.aDUTMARK = [aDecoder decodeObjectForKey:kGetOupputInfoModelADUTMARK];
    self.aDUTUSER = [aDecoder decodeObjectForKey:kGetOupputInfoModelADUTUSER];
    self.bUSINESSIDX = [aDecoder decodeObjectForKey:kGetOupputInfoModelBUSINESSIDX];
    self.eDITDATE = [aDecoder decodeObjectForKey:kGetOupputInfoModelEDITDATE];
    self.eNTIDX = [aDecoder decodeObjectForKey:kGetOupputInfoModelENTIDX];
    self.iDX = [aDecoder decodeObjectForKey:kGetOupputInfoModelIDX];
    self.iNPUTNO = [aDecoder decodeObjectForKey:kGetOupputInfoModelINPUTNO];
    self.oPERUSER = [aDecoder decodeObjectForKey:kGetOupputInfoModelOPERUSER];
    self.oUTPUTDATE = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTDATE];
    self.oUTPUTNO = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTNO];
    self.oUTPUTQTY = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTQTY];
    self.oUTPUTSTATE = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTSTATE];
    self.oUTPUTSUM = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTSUM];
    self.oUTPUTVOLUME = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTVOLUME];
    self.oUTPUTWEIGHT = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTWEIGHT];
    self.oUTPUTWORKFLOW = [aDecoder decodeObjectForKey:kGetOupputInfoModelOUTPUTWORKFLOW];
    self.pARTYCODE = [aDecoder decodeObjectForKey:kGetOupputInfoModelPARTYCODE];
    self.pARTYINFO = [aDecoder decodeObjectForKey:kGetOupputInfoModelPARTYINFO];
    self.pARTYMARK = [aDecoder decodeObjectForKey:kGetOupputInfoModelPARTYMARK];
    self.pARTYNAME = [aDecoder decodeObjectForKey:kGetOupputInfoModelPARTYNAME];
    self.pRICE = [aDecoder decodeObjectForKey:kGetOupputInfoModelPRICE];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOupputInfoModel *copy = [GetOupputInfoModel new];
    
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

//
//  GetOupputItemModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputItemModel.h"


NSString *const kGetOupputItemModelACTPRICE = @"ACT_PRICE";
NSString *const kGetOupputItemModelADDDATE = @"ADD_DATE";
NSString *const kGetOupputItemModelBATCHNUMBER = @"BATCH_NUMBER";
NSString *const kGetOupputItemModelEDITDATE = @"EDIT_DATE";
NSString *const kGetOupputItemModelENTIDX = @"ENT_IDX";
NSString *const kGetOupputItemModelIDX = @"IDX";
NSString *const kGetOupputItemModelLINENO = @"LINE_NO";
NSString *const kGetOupputItemModelMJPRICE = @"MJ_PRICE";
NSString *const kGetOupputItemModelMJREMARK = @"MJ_REMARK";
NSString *const kGetOupputItemModelOPERUSER = @"OPER_USER";
NSString *const kGetOupputItemModelORGPRICE = @"ORG_PRICE";
NSString *const kGetOupputItemModelOUTPUTIDX = @"OUTPUT_IDX";
NSString *const kGetOupputItemModelOUTPUTQTY = @"OUTPUT_QTY";
NSString *const kGetOupputItemModelOUTPUTUOM = @"OUTPUT_UOM";
NSString *const kGetOupputItemModelOUTPUTVOLUME = @"OUTPUT_VOLUME";
NSString *const kGetOupputItemModelOUTPUTWEIGHT = @"OUTPUT_WEIGHT";
NSString *const kGetOupputItemModelPRODUCTIONDATE = @"PRODUCTION_DATE";
NSString *const kGetOupputItemModelPRODUCTDESC = @"PRODUCT_DESC";
NSString *const kGetOupputItemModelPRODUCTIDX = @"PRODUCT_IDX";
NSString *const kGetOupputItemModelPRODUCTNAME = @"PRODUCT_NAME";
NSString *const kGetOupputItemModelPRODUCTNO = @"PRODUCT_NO";
NSString *const kGetOupputItemModelPRODUCTSTATE = @"PRODUCT_STATE";
NSString *const kGetOupputItemModelPRODUCTTYPE = @"PRODUCT_TYPE";
NSString *const kGetOupputItemModelPRODUCTVOLUME = @"PRODUCT_VOLUME";
NSString *const kGetOupputItemModelPRODUCTWEIGHT = @"PRODUCT_WEIGHT";
NSString *const kGetOupputItemModelSALEREMARK = @"SALE_REMARK";
NSString *const kGetOupputItemModelSUM = @"SUM";


@implementation GetOupputItemModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetOupputItemModelACTPRICE] isKindOfClass:[NSNull class]]){
        self.aCTPRICE = dictionary[kGetOupputItemModelACTPRICE];
    }
    if(![dictionary[kGetOupputItemModelADDDATE] isKindOfClass:[NSNull class]]){
        self.aDDDATE = dictionary[kGetOupputItemModelADDDATE];
    }
    if(![dictionary[kGetOupputItemModelBATCHNUMBER] isKindOfClass:[NSNull class]]){
        self.bATCHNUMBER = dictionary[kGetOupputItemModelBATCHNUMBER];
    }
    if(![dictionary[kGetOupputItemModelEDITDATE] isKindOfClass:[NSNull class]]){
        self.eDITDATE = dictionary[kGetOupputItemModelEDITDATE];
    }
    if(![dictionary[kGetOupputItemModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kGetOupputItemModelENTIDX];
    }
    if(![dictionary[kGetOupputItemModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kGetOupputItemModelIDX];
    }
    if(![dictionary[kGetOupputItemModelLINENO] isKindOfClass:[NSNull class]]){
        self.lINENO = dictionary[kGetOupputItemModelLINENO];
    }
    if(![dictionary[kGetOupputItemModelMJPRICE] isKindOfClass:[NSNull class]]){
        self.mJPRICE = dictionary[kGetOupputItemModelMJPRICE];
    }
    if(![dictionary[kGetOupputItemModelMJREMARK] isKindOfClass:[NSNull class]]){
        self.mJREMARK = dictionary[kGetOupputItemModelMJREMARK];
    }
    if(![dictionary[kGetOupputItemModelOPERUSER] isKindOfClass:[NSNull class]]){
        self.oPERUSER = dictionary[kGetOupputItemModelOPERUSER];
    }
    if(![dictionary[kGetOupputItemModelORGPRICE] isKindOfClass:[NSNull class]]){
        self.oRGPRICE = dictionary[kGetOupputItemModelORGPRICE];
    }
    if(![dictionary[kGetOupputItemModelOUTPUTIDX] isKindOfClass:[NSNull class]]){
        self.oUTPUTIDX = dictionary[kGetOupputItemModelOUTPUTIDX];
    }
    if(![dictionary[kGetOupputItemModelOUTPUTQTY] isKindOfClass:[NSNull class]]){
        self.oUTPUTQTY = dictionary[kGetOupputItemModelOUTPUTQTY];
    }
    if(![dictionary[kGetOupputItemModelOUTPUTUOM] isKindOfClass:[NSNull class]]){
        self.oUTPUTUOM = dictionary[kGetOupputItemModelOUTPUTUOM];
    }
    if(![dictionary[kGetOupputItemModelOUTPUTVOLUME] isKindOfClass:[NSNull class]]){
        self.oUTPUTVOLUME = dictionary[kGetOupputItemModelOUTPUTVOLUME];
    }
    if(![dictionary[kGetOupputItemModelOUTPUTWEIGHT] isKindOfClass:[NSNull class]]){
        self.oUTPUTWEIGHT = dictionary[kGetOupputItemModelOUTPUTWEIGHT];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTIONDATE] isKindOfClass:[NSNull class]]){
        self.pRODUCTIONDATE = dictionary[kGetOupputItemModelPRODUCTIONDATE];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTDESC] isKindOfClass:[NSNull class]]){
        self.pRODUCTDESC = dictionary[kGetOupputItemModelPRODUCTDESC];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTIDX] isKindOfClass:[NSNull class]]){
        self.pRODUCTIDX = dictionary[kGetOupputItemModelPRODUCTIDX];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTNAME] isKindOfClass:[NSNull class]]){
        self.pRODUCTNAME = dictionary[kGetOupputItemModelPRODUCTNAME];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTNO] isKindOfClass:[NSNull class]]){
        self.pRODUCTNO = dictionary[kGetOupputItemModelPRODUCTNO];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTSTATE] isKindOfClass:[NSNull class]]){
        self.pRODUCTSTATE = dictionary[kGetOupputItemModelPRODUCTSTATE];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTTYPE] isKindOfClass:[NSNull class]]){
        self.pRODUCTTYPE = dictionary[kGetOupputItemModelPRODUCTTYPE];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTVOLUME] isKindOfClass:[NSNull class]]){
        self.pRODUCTVOLUME = dictionary[kGetOupputItemModelPRODUCTVOLUME];
    }
    if(![dictionary[kGetOupputItemModelPRODUCTWEIGHT] isKindOfClass:[NSNull class]]){
        self.pRODUCTWEIGHT = dictionary[kGetOupputItemModelPRODUCTWEIGHT];
    }
    if(![dictionary[kGetOupputItemModelSALEREMARK] isKindOfClass:[NSNull class]]){
        self.sALEREMARK = dictionary[kGetOupputItemModelSALEREMARK];
    }
    if(![dictionary[kGetOupputItemModelSUM] isKindOfClass:[NSNull class]]){
        self.sUM = dictionary[kGetOupputItemModelSUM];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.aCTPRICE != nil){
        dictionary[kGetOupputItemModelACTPRICE] = self.aCTPRICE;
    }
    if(self.aDDDATE != nil){
        dictionary[kGetOupputItemModelADDDATE] = self.aDDDATE;
    }
    if(self.bATCHNUMBER != nil){
        dictionary[kGetOupputItemModelBATCHNUMBER] = self.bATCHNUMBER;
    }
    if(self.eDITDATE != nil){
        dictionary[kGetOupputItemModelEDITDATE] = self.eDITDATE;
    }
    if(self.eNTIDX != nil){
        dictionary[kGetOupputItemModelENTIDX] = self.eNTIDX;
    }
    if(self.iDX != nil){
        dictionary[kGetOupputItemModelIDX] = self.iDX;
    }
    if(self.lINENO != nil){
        dictionary[kGetOupputItemModelLINENO] = self.lINENO;
    }
    if(self.mJPRICE != nil){
        dictionary[kGetOupputItemModelMJPRICE] = self.mJPRICE;
    }
    if(self.mJREMARK != nil){
        dictionary[kGetOupputItemModelMJREMARK] = self.mJREMARK;
    }
    if(self.oPERUSER != nil){
        dictionary[kGetOupputItemModelOPERUSER] = self.oPERUSER;
    }
    if(self.oRGPRICE != nil){
        dictionary[kGetOupputItemModelORGPRICE] = self.oRGPRICE;
    }
    if(self.oUTPUTIDX != nil){
        dictionary[kGetOupputItemModelOUTPUTIDX] = self.oUTPUTIDX;
    }
    if(self.oUTPUTQTY != nil){
        dictionary[kGetOupputItemModelOUTPUTQTY] = self.oUTPUTQTY;
    }
    if(self.oUTPUTUOM != nil){
        dictionary[kGetOupputItemModelOUTPUTUOM] = self.oUTPUTUOM;
    }
    if(self.oUTPUTVOLUME != nil){
        dictionary[kGetOupputItemModelOUTPUTVOLUME] = self.oUTPUTVOLUME;
    }
    if(self.oUTPUTWEIGHT != nil){
        dictionary[kGetOupputItemModelOUTPUTWEIGHT] = self.oUTPUTWEIGHT;
    }
    if(self.pRODUCTIONDATE != nil){
        dictionary[kGetOupputItemModelPRODUCTIONDATE] = self.pRODUCTIONDATE;
    }
    if(self.pRODUCTDESC != nil){
        dictionary[kGetOupputItemModelPRODUCTDESC] = self.pRODUCTDESC;
    }
    if(self.pRODUCTIDX != nil){
        dictionary[kGetOupputItemModelPRODUCTIDX] = self.pRODUCTIDX;
    }
    if(self.pRODUCTNAME != nil){
        dictionary[kGetOupputItemModelPRODUCTNAME] = self.pRODUCTNAME;
    }
    if(self.pRODUCTNO != nil){
        dictionary[kGetOupputItemModelPRODUCTNO] = self.pRODUCTNO;
    }
    if(self.pRODUCTSTATE != nil){
        dictionary[kGetOupputItemModelPRODUCTSTATE] = self.pRODUCTSTATE;
    }
    if(self.pRODUCTTYPE != nil){
        dictionary[kGetOupputItemModelPRODUCTTYPE] = self.pRODUCTTYPE;
    }
    if(self.pRODUCTVOLUME != nil){
        dictionary[kGetOupputItemModelPRODUCTVOLUME] = self.pRODUCTVOLUME;
    }
    if(self.pRODUCTWEIGHT != nil){
        dictionary[kGetOupputItemModelPRODUCTWEIGHT] = self.pRODUCTWEIGHT;
    }
    if(self.sALEREMARK != nil){
        dictionary[kGetOupputItemModelSALEREMARK] = self.sALEREMARK;
    }
    if(self.sUM != nil){
        dictionary[kGetOupputItemModelSUM] = self.sUM;
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
    if(self.aCTPRICE != nil){
        [aCoder encodeObject:self.aCTPRICE forKey:kGetOupputItemModelACTPRICE];
    }
    if(self.aDDDATE != nil){
        [aCoder encodeObject:self.aDDDATE forKey:kGetOupputItemModelADDDATE];
    }
    if(self.bATCHNUMBER != nil){
        [aCoder encodeObject:self.bATCHNUMBER forKey:kGetOupputItemModelBATCHNUMBER];
    }
    if(self.eDITDATE != nil){
        [aCoder encodeObject:self.eDITDATE forKey:kGetOupputItemModelEDITDATE];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kGetOupputItemModelENTIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kGetOupputItemModelIDX];
    }
    if(self.lINENO != nil){
        [aCoder encodeObject:self.lINENO forKey:kGetOupputItemModelLINENO];
    }
    if(self.mJPRICE != nil){
        [aCoder encodeObject:self.mJPRICE forKey:kGetOupputItemModelMJPRICE];
    }
    if(self.mJREMARK != nil){
        [aCoder encodeObject:self.mJREMARK forKey:kGetOupputItemModelMJREMARK];
    }
    if(self.oPERUSER != nil){
        [aCoder encodeObject:self.oPERUSER forKey:kGetOupputItemModelOPERUSER];
    }
    if(self.oRGPRICE != nil){
        [aCoder encodeObject:self.oRGPRICE forKey:kGetOupputItemModelORGPRICE];
    }
    if(self.oUTPUTIDX != nil){
        [aCoder encodeObject:self.oUTPUTIDX forKey:kGetOupputItemModelOUTPUTIDX];
    }
    if(self.oUTPUTQTY != nil){
        [aCoder encodeObject:self.oUTPUTQTY forKey:kGetOupputItemModelOUTPUTQTY];
    }
    if(self.oUTPUTUOM != nil){
        [aCoder encodeObject:self.oUTPUTUOM forKey:kGetOupputItemModelOUTPUTUOM];
    }
    if(self.oUTPUTVOLUME != nil){
        [aCoder encodeObject:self.oUTPUTVOLUME forKey:kGetOupputItemModelOUTPUTVOLUME];
    }
    if(self.oUTPUTWEIGHT != nil){
        [aCoder encodeObject:self.oUTPUTWEIGHT forKey:kGetOupputItemModelOUTPUTWEIGHT];
    }
    if(self.pRODUCTIONDATE != nil){
        [aCoder encodeObject:self.pRODUCTIONDATE forKey:kGetOupputItemModelPRODUCTIONDATE];
    }
    if(self.pRODUCTDESC != nil){
        [aCoder encodeObject:self.pRODUCTDESC forKey:kGetOupputItemModelPRODUCTDESC];
    }
    if(self.pRODUCTIDX != nil){
        [aCoder encodeObject:self.pRODUCTIDX forKey:kGetOupputItemModelPRODUCTIDX];
    }
    if(self.pRODUCTNAME != nil){
        [aCoder encodeObject:self.pRODUCTNAME forKey:kGetOupputItemModelPRODUCTNAME];
    }
    if(self.pRODUCTNO != nil){
        [aCoder encodeObject:self.pRODUCTNO forKey:kGetOupputItemModelPRODUCTNO];
    }
    if(self.pRODUCTSTATE != nil){
        [aCoder encodeObject:self.pRODUCTSTATE forKey:kGetOupputItemModelPRODUCTSTATE];
    }
    if(self.pRODUCTTYPE != nil){
        [aCoder encodeObject:self.pRODUCTTYPE forKey:kGetOupputItemModelPRODUCTTYPE];
    }
    if(self.pRODUCTVOLUME != nil){
        [aCoder encodeObject:self.pRODUCTVOLUME forKey:kGetOupputItemModelPRODUCTVOLUME];
    }
    if(self.pRODUCTWEIGHT != nil){
        [aCoder encodeObject:self.pRODUCTWEIGHT forKey:kGetOupputItemModelPRODUCTWEIGHT];
    }
    if(self.sALEREMARK != nil){
        [aCoder encodeObject:self.sALEREMARK forKey:kGetOupputItemModelSALEREMARK];
    }
    if(self.sUM != nil){
        [aCoder encodeObject:self.sUM forKey:kGetOupputItemModelSUM];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aCTPRICE = [aDecoder decodeObjectForKey:kGetOupputItemModelACTPRICE];
    self.aDDDATE = [aDecoder decodeObjectForKey:kGetOupputItemModelADDDATE];
    self.bATCHNUMBER = [aDecoder decodeObjectForKey:kGetOupputItemModelBATCHNUMBER];
    self.eDITDATE = [aDecoder decodeObjectForKey:kGetOupputItemModelEDITDATE];
    self.eNTIDX = [aDecoder decodeObjectForKey:kGetOupputItemModelENTIDX];
    self.iDX = [aDecoder decodeObjectForKey:kGetOupputItemModelIDX];
    self.lINENO = [aDecoder decodeObjectForKey:kGetOupputItemModelLINENO];
    self.mJPRICE = [aDecoder decodeObjectForKey:kGetOupputItemModelMJPRICE];
    self.mJREMARK = [aDecoder decodeObjectForKey:kGetOupputItemModelMJREMARK];
    self.oPERUSER = [aDecoder decodeObjectForKey:kGetOupputItemModelOPERUSER];
    self.oRGPRICE = [aDecoder decodeObjectForKey:kGetOupputItemModelORGPRICE];
    self.oUTPUTIDX = [aDecoder decodeObjectForKey:kGetOupputItemModelOUTPUTIDX];
    self.oUTPUTQTY = [aDecoder decodeObjectForKey:kGetOupputItemModelOUTPUTQTY];
    self.oUTPUTUOM = [aDecoder decodeObjectForKey:kGetOupputItemModelOUTPUTUOM];
    self.oUTPUTVOLUME = [aDecoder decodeObjectForKey:kGetOupputItemModelOUTPUTVOLUME];
    self.oUTPUTWEIGHT = [aDecoder decodeObjectForKey:kGetOupputItemModelOUTPUTWEIGHT];
    self.pRODUCTIONDATE = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTIONDATE];
    self.pRODUCTDESC = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTDESC];
    self.pRODUCTIDX = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTIDX];
    self.pRODUCTNAME = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTNAME];
    self.pRODUCTNO = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTNO];
    self.pRODUCTSTATE = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTSTATE];
    self.pRODUCTTYPE = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTTYPE];
    self.pRODUCTVOLUME = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTVOLUME];
    self.pRODUCTWEIGHT = [aDecoder decodeObjectForKey:kGetOupputItemModelPRODUCTWEIGHT];
    self.sALEREMARK = [aDecoder decodeObjectForKey:kGetOupputItemModelSALEREMARK];
    self.sUM = [aDecoder decodeObjectForKey:kGetOupputItemModelSUM];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOupputItemModel *copy = [GetOupputItemModel new];
    
    copy.aCTPRICE = [self.aCTPRICE copy];
    copy.aDDDATE = [self.aDDDATE copy];
    copy.bATCHNUMBER = [self.bATCHNUMBER copy];
    copy.eDITDATE = [self.eDITDATE copy];
    copy.eNTIDX = [self.eNTIDX copy];
    copy.iDX = [self.iDX copy];
    copy.lINENO = [self.lINENO copy];
    copy.mJPRICE = [self.mJPRICE copy];
    copy.mJREMARK = [self.mJREMARK copy];
    copy.oPERUSER = [self.oPERUSER copy];
    copy.oRGPRICE = [self.oRGPRICE copy];
    copy.oUTPUTIDX = [self.oUTPUTIDX copy];
    copy.oUTPUTQTY = [self.oUTPUTQTY copy];
    copy.oUTPUTUOM = [self.oUTPUTUOM copy];
    copy.oUTPUTVOLUME = [self.oUTPUTVOLUME copy];
    copy.oUTPUTWEIGHT = [self.oUTPUTWEIGHT copy];
    copy.pRODUCTIONDATE = [self.pRODUCTIONDATE copy];
    copy.pRODUCTDESC = [self.pRODUCTDESC copy];
    copy.pRODUCTIDX = [self.pRODUCTIDX copy];
    copy.pRODUCTNAME = [self.pRODUCTNAME copy];
    copy.pRODUCTNO = [self.pRODUCTNO copy];
    copy.pRODUCTSTATE = [self.pRODUCTSTATE copy];
    copy.pRODUCTTYPE = [self.pRODUCTTYPE copy];
    copy.pRODUCTVOLUME = [self.pRODUCTVOLUME copy];
    copy.pRODUCTWEIGHT = [self.pRODUCTWEIGHT copy];
    copy.sALEREMARK = [self.sALEREMARK copy];
    copy.sUM = [self.sUM copy];
    
    return copy;
}

@end

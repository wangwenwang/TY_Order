//
//  AppStockModel.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AppStockModel.h"


NSString *const kAppStockModelADDDATE = @"ADD_DATE";
NSString *const kAppStockModelAZHUOLING = @"A_ZHUO_LING";
NSString *const kAppStockModelAZTHUOLING = @"A_ZTHUO_LING";
NSString *const kAppStockModelDAOQI = @"DAOQI";
NSString *const kAppStockModelEDITDATE = @"EDIT_DATE";
NSString *const kAppStockModelENTIDX = @"ENT_IDX";
NSString *const kAppStockModelEXPIRATIONDAY = @"EXPIRATION_DAY";
NSString *const kAppStockModelHUOLING = @"HUO_LING";
NSString *const kAppStockModelIDX = @"IDX";
NSString *const kAppStockModelPRODUCTIONDATE = @"PRODUCTION_DATE";
NSString *const kAppStockModelPRODUCTIDX = @"PRODUCT_IDX";
NSString *const kAppStockModelPRODUCTNAME = @"PRODUCT_NAME";
NSString *const kAppStockModelPRODUCTNO = @"PRODUCT_NO";
NSString *const kAppStockModelSTOCKDATE = @"STOCK_DATE";
NSString *const kAppStockModelSTOCKIDX = @"STOCK_IDX";
NSString *const kAppStockModelSTOCKQTY = @"STOCK_QTY";
NSString *const kAppStockModelTHUOLING = @"THUO_LING";
NSString *const kAppStockModelUSERNAME = @"USER_NAME";


@implementation AppStockModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAppStockModelADDDATE] isKindOfClass:[NSNull class]]){
        self.aDDDATE = dictionary[kAppStockModelADDDATE];
    }
    if(![dictionary[kAppStockModelAZHUOLING] isKindOfClass:[NSNull class]]){
        self.aZHUOLING = dictionary[kAppStockModelAZHUOLING];
    }
    if(![dictionary[kAppStockModelAZTHUOLING] isKindOfClass:[NSNull class]]){
        self.aZTHUOLING = dictionary[kAppStockModelAZTHUOLING];
    }
    if(![dictionary[kAppStockModelDAOQI] isKindOfClass:[NSNull class]]){
        self.dAOQI = dictionary[kAppStockModelDAOQI];
    }
    if(![dictionary[kAppStockModelEDITDATE] isKindOfClass:[NSNull class]]){
        self.eDITDATE = dictionary[kAppStockModelEDITDATE];
    }
    if(![dictionary[kAppStockModelENTIDX] isKindOfClass:[NSNull class]]){
        self.eNTIDX = dictionary[kAppStockModelENTIDX];
    }
    if(![dictionary[kAppStockModelEXPIRATIONDAY] isKindOfClass:[NSNull class]]){
        self.eXPIRATIONDAY = dictionary[kAppStockModelEXPIRATIONDAY];
    }
    if(![dictionary[kAppStockModelHUOLING] isKindOfClass:[NSNull class]]){
        self.hUOLING = dictionary[kAppStockModelHUOLING];
    }
    if(![dictionary[kAppStockModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kAppStockModelIDX];
    }
    if(![dictionary[kAppStockModelPRODUCTIONDATE] isKindOfClass:[NSNull class]]){
        self.pRODUCTIONDATE = dictionary[kAppStockModelPRODUCTIONDATE];
    }
    if(![dictionary[kAppStockModelPRODUCTIDX] isKindOfClass:[NSNull class]]){
        self.pRODUCTIDX = dictionary[kAppStockModelPRODUCTIDX];
    }
    if(![dictionary[kAppStockModelPRODUCTNAME] isKindOfClass:[NSNull class]]){
        self.pRODUCTNAME = dictionary[kAppStockModelPRODUCTNAME];
    }
    if(![dictionary[kAppStockModelPRODUCTNO] isKindOfClass:[NSNull class]]){
        self.pRODUCTNO = dictionary[kAppStockModelPRODUCTNO];
    }
    if(![dictionary[kAppStockModelSTOCKDATE] isKindOfClass:[NSNull class]]){
        self.sTOCKDATE = dictionary[kAppStockModelSTOCKDATE];
    }
    if(![dictionary[kAppStockModelSTOCKIDX] isKindOfClass:[NSNull class]]){
        self.sTOCKIDX = dictionary[kAppStockModelSTOCKIDX];
    }
    if(![dictionary[kAppStockModelSTOCKQTY] isKindOfClass:[NSNull class]]){
        self.sTOCKQTY = dictionary[kAppStockModelSTOCKQTY];
    }
    if(![dictionary[kAppStockModelTHUOLING] isKindOfClass:[NSNull class]]){
        self.tHUOLING = dictionary[kAppStockModelTHUOLING];
    }
    if(![dictionary[kAppStockModelUSERNAME] isKindOfClass:[NSNull class]]){
        self.uSERNAME = dictionary[kAppStockModelUSERNAME];
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
        dictionary[kAppStockModelADDDATE] = self.aDDDATE;
    }
    if(self.aZHUOLING != nil){
        dictionary[kAppStockModelAZHUOLING] = self.aZHUOLING;
    }
    if(self.aZTHUOLING != nil){
        dictionary[kAppStockModelAZTHUOLING] = self.aZTHUOLING;
    }
    if(self.dAOQI != nil){
        dictionary[kAppStockModelDAOQI] = self.dAOQI;
    }
    if(self.eDITDATE != nil){
        dictionary[kAppStockModelEDITDATE] = self.eDITDATE;
    }
    if(self.eNTIDX != nil){
        dictionary[kAppStockModelENTIDX] = self.eNTIDX;
    }
    if(self.eXPIRATIONDAY != nil){
        dictionary[kAppStockModelEXPIRATIONDAY] = self.eXPIRATIONDAY;
    }
    if(self.hUOLING != nil){
        dictionary[kAppStockModelHUOLING] = self.hUOLING;
    }
    if(self.iDX != nil){
        dictionary[kAppStockModelIDX] = self.iDX;
    }
    if(self.pRODUCTIONDATE != nil){
        dictionary[kAppStockModelPRODUCTIONDATE] = self.pRODUCTIONDATE;
    }
    if(self.pRODUCTIDX != nil){
        dictionary[kAppStockModelPRODUCTIDX] = self.pRODUCTIDX;
    }
    if(self.pRODUCTNAME != nil){
        dictionary[kAppStockModelPRODUCTNAME] = self.pRODUCTNAME;
    }
    if(self.pRODUCTNO != nil){
        dictionary[kAppStockModelPRODUCTNO] = self.pRODUCTNO;
    }
    if(self.sTOCKDATE != nil){
        dictionary[kAppStockModelSTOCKDATE] = self.sTOCKDATE;
    }
    if(self.sTOCKIDX != nil){
        dictionary[kAppStockModelSTOCKIDX] = self.sTOCKIDX;
    }
    if(self.sTOCKQTY != nil){
        dictionary[kAppStockModelSTOCKQTY] = self.sTOCKQTY;
    }
    if(self.tHUOLING != nil){
        dictionary[kAppStockModelTHUOLING] = self.tHUOLING;
    }
    if(self.uSERNAME != nil){
        dictionary[kAppStockModelUSERNAME] = self.uSERNAME;
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
        [aCoder encodeObject:self.aDDDATE forKey:kAppStockModelADDDATE];
    }
    if(self.aZHUOLING != nil){
        [aCoder encodeObject:self.aZHUOLING forKey:kAppStockModelAZHUOLING];
    }
    if(self.aZTHUOLING != nil){
        [aCoder encodeObject:self.aZTHUOLING forKey:kAppStockModelAZTHUOLING];
    }
    if(self.dAOQI != nil){
        [aCoder encodeObject:self.dAOQI forKey:kAppStockModelDAOQI];
    }
    if(self.eDITDATE != nil){
        [aCoder encodeObject:self.eDITDATE forKey:kAppStockModelEDITDATE];
    }
    if(self.eNTIDX != nil){
        [aCoder encodeObject:self.eNTIDX forKey:kAppStockModelENTIDX];
    }
    if(self.eXPIRATIONDAY != nil){
        [aCoder encodeObject:self.eXPIRATIONDAY forKey:kAppStockModelEXPIRATIONDAY];
    }
    if(self.hUOLING != nil){
        [aCoder encodeObject:self.hUOLING forKey:kAppStockModelHUOLING];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kAppStockModelIDX];
    }
    if(self.pRODUCTIONDATE != nil){
        [aCoder encodeObject:self.pRODUCTIONDATE forKey:kAppStockModelPRODUCTIONDATE];
    }
    if(self.pRODUCTIDX != nil){
        [aCoder encodeObject:self.pRODUCTIDX forKey:kAppStockModelPRODUCTIDX];
    }
    if(self.pRODUCTNAME != nil){
        [aCoder encodeObject:self.pRODUCTNAME forKey:kAppStockModelPRODUCTNAME];
    }
    if(self.pRODUCTNO != nil){
        [aCoder encodeObject:self.pRODUCTNO forKey:kAppStockModelPRODUCTNO];
    }
    if(self.sTOCKDATE != nil){
        [aCoder encodeObject:self.sTOCKDATE forKey:kAppStockModelSTOCKDATE];
    }
    if(self.sTOCKIDX != nil){
        [aCoder encodeObject:self.sTOCKIDX forKey:kAppStockModelSTOCKIDX];
    }
    if(self.sTOCKQTY != nil){
        [aCoder encodeObject:self.sTOCKQTY forKey:kAppStockModelSTOCKQTY];
    }
    if(self.tHUOLING != nil){
        [aCoder encodeObject:self.tHUOLING forKey:kAppStockModelTHUOLING];
    }
    if(self.uSERNAME != nil){
        [aCoder encodeObject:self.uSERNAME forKey:kAppStockModelUSERNAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.aDDDATE = [aDecoder decodeObjectForKey:kAppStockModelADDDATE];
    self.aZHUOLING = [aDecoder decodeObjectForKey:kAppStockModelAZHUOLING];
    self.aZTHUOLING = [aDecoder decodeObjectForKey:kAppStockModelAZTHUOLING];
    self.dAOQI = [aDecoder decodeObjectForKey:kAppStockModelDAOQI];
    self.eDITDATE = [aDecoder decodeObjectForKey:kAppStockModelEDITDATE];
    self.eNTIDX = [aDecoder decodeObjectForKey:kAppStockModelENTIDX];
    self.eXPIRATIONDAY = [aDecoder decodeObjectForKey:kAppStockModelEXPIRATIONDAY];
    self.hUOLING = [aDecoder decodeObjectForKey:kAppStockModelHUOLING];
    self.iDX = [aDecoder decodeObjectForKey:kAppStockModelIDX];
    self.pRODUCTIONDATE = [aDecoder decodeObjectForKey:kAppStockModelPRODUCTIONDATE];
    self.pRODUCTIDX = [aDecoder decodeObjectForKey:kAppStockModelPRODUCTIDX];
    self.pRODUCTNAME = [aDecoder decodeObjectForKey:kAppStockModelPRODUCTNAME];
    self.pRODUCTNO = [aDecoder decodeObjectForKey:kAppStockModelPRODUCTNO];
    self.sTOCKDATE = [aDecoder decodeObjectForKey:kAppStockModelSTOCKDATE];
    self.sTOCKIDX = [aDecoder decodeObjectForKey:kAppStockModelSTOCKIDX];
    self.sTOCKQTY = [aDecoder decodeObjectForKey:kAppStockModelSTOCKQTY];
    self.tHUOLING = [aDecoder decodeObjectForKey:kAppStockModelTHUOLING];
    self.uSERNAME = [aDecoder decodeObjectForKey:kAppStockModelUSERNAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AppStockModel *copy = [AppStockModel new];
    
    copy.aDDDATE = [self.aDDDATE copy];
    copy.aZHUOLING = [self.aZHUOLING copy];
    copy.aZTHUOLING = [self.aZTHUOLING copy];
    copy.dAOQI = [self.dAOQI copy];
    copy.eDITDATE = [self.eDITDATE copy];
    copy.eNTIDX = [self.eNTIDX copy];
    copy.eXPIRATIONDAY = [self.eXPIRATIONDAY copy];
    copy.hUOLING = [self.hUOLING copy];
    copy.iDX = [self.iDX copy];
    copy.pRODUCTIONDATE = [self.pRODUCTIONDATE copy];
    copy.pRODUCTIDX = [self.pRODUCTIDX copy];
    copy.pRODUCTNAME = [self.pRODUCTNAME copy];
    copy.pRODUCTNO = [self.pRODUCTNO copy];
    copy.sTOCKDATE = [self.sTOCKDATE copy];
    copy.sTOCKIDX = [self.sTOCKIDX copy];
    copy.sTOCKQTY = [self.sTOCKQTY copy];
    copy.tHUOLING = [self.tHUOLING copy];
    copy.uSERNAME = [self.uSERNAME copy];
    
    return copy;
}

@end

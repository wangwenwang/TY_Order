//
//  StoreProductModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "StoreProductModel.h"


NSString *const kStoreProductModelBUSINESSIDX = @"BUSINESS_IDX";
NSString *const kStoreProductModelIDX = @"IDX";
NSString *const kStoreProductModelPRODUCTBARCODE = @"PRODUCT_BARCODE";
NSString *const kStoreProductModelPRODUCTCLASS = @"PRODUCT_CLASS";
NSString *const kStoreProductModelPRODUCTDESC = @"PRODUCT_DESC";
NSString *const kStoreProductModelPRODUCTNAME = @"PRODUCT_NAME";
NSString *const kStoreProductModelPRODUCTNO = @"PRODUCT_NO";
NSString *const kStoreProductModelPRODUCTPOLICY = @"PRODUCT_POLICY";
NSString *const kStoreProductModelPRODUCTPRICE = @"PRODUCT_PRICE";
NSString *const kStoreProductModelPRODUCTTYPE = @"PRODUCT_TYPE";
NSString *const kStoreProductModelPRODUCTVOLUME = @"PRODUCT_VOLUME";
NSString *const kStoreProductModelPRODUCTWEIGHT = @"PRODUCT_WEIGHT";


@implementation StoreProductModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kStoreProductModelBUSINESSIDX] isKindOfClass:[NSNull class]]){
        self.bUSINESSIDX = dictionary[kStoreProductModelBUSINESSIDX];
    }
    if(![dictionary[kStoreProductModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kStoreProductModelIDX];
    }
    if(![dictionary[kStoreProductModelPRODUCTBARCODE] isKindOfClass:[NSNull class]]){
        self.pRODUCTBARCODE = dictionary[kStoreProductModelPRODUCTBARCODE];
    }
    if(![dictionary[kStoreProductModelPRODUCTCLASS] isKindOfClass:[NSNull class]]){
        self.pRODUCTCLASS = dictionary[kStoreProductModelPRODUCTCLASS];
    }
    if(![dictionary[kStoreProductModelPRODUCTDESC] isKindOfClass:[NSNull class]]){
        self.pRODUCTDESC = dictionary[kStoreProductModelPRODUCTDESC];
    }
    if(![dictionary[kStoreProductModelPRODUCTNAME] isKindOfClass:[NSNull class]]){
        self.pRODUCTNAME = dictionary[kStoreProductModelPRODUCTNAME];
    }
    if(![dictionary[kStoreProductModelPRODUCTNO] isKindOfClass:[NSNull class]]){
        self.pRODUCTNO = dictionary[kStoreProductModelPRODUCTNO];
    }
    if(![dictionary[kStoreProductModelPRODUCTPOLICY] isKindOfClass:[NSNull class]]){
        self.pRODUCTPOLICY = dictionary[kStoreProductModelPRODUCTPOLICY];
    }
    if(![dictionary[kStoreProductModelPRODUCTPRICE] isKindOfClass:[NSNull class]]){
        self.pRODUCTPRICE = dictionary[kStoreProductModelPRODUCTPRICE];
    }
    if(![dictionary[kStoreProductModelPRODUCTTYPE] isKindOfClass:[NSNull class]]){
        self.pRODUCTTYPE = dictionary[kStoreProductModelPRODUCTTYPE];
    }
    if(![dictionary[kStoreProductModelPRODUCTVOLUME] isKindOfClass:[NSNull class]]){
        self.pRODUCTVOLUME = dictionary[kStoreProductModelPRODUCTVOLUME];
    }
    if(![dictionary[kStoreProductModelPRODUCTWEIGHT] isKindOfClass:[NSNull class]]){
        self.pRODUCTWEIGHT = dictionary[kStoreProductModelPRODUCTWEIGHT];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.bUSINESSIDX != nil){
        dictionary[kStoreProductModelBUSINESSIDX] = self.bUSINESSIDX;
    }
    if(self.iDX != nil){
        dictionary[kStoreProductModelIDX] = self.iDX;
    }
    if(self.pRODUCTBARCODE != nil){
        dictionary[kStoreProductModelPRODUCTBARCODE] = self.pRODUCTBARCODE;
    }
    if(self.pRODUCTCLASS != nil){
        dictionary[kStoreProductModelPRODUCTCLASS] = self.pRODUCTCLASS;
    }
    if(self.pRODUCTDESC != nil){
        dictionary[kStoreProductModelPRODUCTDESC] = self.pRODUCTDESC;
    }
    if(self.pRODUCTNAME != nil){
        dictionary[kStoreProductModelPRODUCTNAME] = self.pRODUCTNAME;
    }
    if(self.pRODUCTNO != nil){
        dictionary[kStoreProductModelPRODUCTNO] = self.pRODUCTNO;
    }
    if(self.pRODUCTPOLICY != nil){
        dictionary[kStoreProductModelPRODUCTPOLICY] = self.pRODUCTPOLICY;
    }
    if(self.pRODUCTPRICE != nil){
        dictionary[kStoreProductModelPRODUCTPRICE] = self.pRODUCTPRICE;
    }
    if(self.pRODUCTTYPE != nil){
        dictionary[kStoreProductModelPRODUCTTYPE] = self.pRODUCTTYPE;
    }
    if(self.pRODUCTVOLUME != nil){
        dictionary[kStoreProductModelPRODUCTVOLUME] = self.pRODUCTVOLUME;
    }
    if(self.pRODUCTWEIGHT != nil){
        dictionary[kStoreProductModelPRODUCTWEIGHT] = self.pRODUCTWEIGHT;
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
    if(self.bUSINESSIDX != nil){
        [aCoder encodeObject:self.bUSINESSIDX forKey:kStoreProductModelBUSINESSIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kStoreProductModelIDX];
    }
    if(self.pRODUCTBARCODE != nil){
        [aCoder encodeObject:self.pRODUCTBARCODE forKey:kStoreProductModelPRODUCTBARCODE];
    }
    if(self.pRODUCTCLASS != nil){
        [aCoder encodeObject:self.pRODUCTCLASS forKey:kStoreProductModelPRODUCTCLASS];
    }
    if(self.pRODUCTDESC != nil){
        [aCoder encodeObject:self.pRODUCTDESC forKey:kStoreProductModelPRODUCTDESC];
    }
    if(self.pRODUCTNAME != nil){
        [aCoder encodeObject:self.pRODUCTNAME forKey:kStoreProductModelPRODUCTNAME];
    }
    if(self.pRODUCTNO != nil){
        [aCoder encodeObject:self.pRODUCTNO forKey:kStoreProductModelPRODUCTNO];
    }
    if(self.pRODUCTPOLICY != nil){
        [aCoder encodeObject:self.pRODUCTPOLICY forKey:kStoreProductModelPRODUCTPOLICY];
    }
    if(self.pRODUCTPRICE != nil){
        [aCoder encodeObject:self.pRODUCTPRICE forKey:kStoreProductModelPRODUCTPRICE];
    }
    if(self.pRODUCTTYPE != nil){
        [aCoder encodeObject:self.pRODUCTTYPE forKey:kStoreProductModelPRODUCTTYPE];
    }
    if(self.pRODUCTVOLUME != nil){
        [aCoder encodeObject:self.pRODUCTVOLUME forKey:kStoreProductModelPRODUCTVOLUME];
    }
    if(self.pRODUCTWEIGHT != nil){
        [aCoder encodeObject:self.pRODUCTWEIGHT forKey:kStoreProductModelPRODUCTWEIGHT];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.bUSINESSIDX = [aDecoder decodeObjectForKey:kStoreProductModelBUSINESSIDX];
    self.iDX = [aDecoder decodeObjectForKey:kStoreProductModelIDX];
    self.pRODUCTBARCODE = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTBARCODE];
    self.pRODUCTCLASS = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTCLASS];
    self.pRODUCTDESC = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTDESC];
    self.pRODUCTNAME = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTNAME];
    self.pRODUCTNO = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTNO];
    self.pRODUCTPOLICY = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTPOLICY];
    self.pRODUCTPRICE = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTPRICE];
    self.pRODUCTTYPE = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTTYPE];
    self.pRODUCTVOLUME = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTVOLUME];
    self.pRODUCTWEIGHT = [aDecoder decodeObjectForKey:kStoreProductModelPRODUCTWEIGHT];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    StoreProductModel *copy = [StoreProductModel new];
    
    copy.bUSINESSIDX = [self.bUSINESSIDX copy];
    copy.iDX = [self.iDX copy];
    copy.pRODUCTBARCODE = [self.pRODUCTBARCODE copy];
    copy.pRODUCTCLASS = [self.pRODUCTCLASS copy];
    copy.pRODUCTDESC = [self.pRODUCTDESC copy];
    copy.pRODUCTNAME = [self.pRODUCTNAME copy];
    copy.pRODUCTNO = [self.pRODUCTNO copy];
    copy.pRODUCTPOLICY = [self.pRODUCTPOLICY copy];
    copy.pRODUCTPRICE = [self.pRODUCTPRICE copy];
    copy.pRODUCTTYPE = [self.pRODUCTTYPE copy];
    copy.pRODUCTVOLUME = [self.pRODUCTVOLUME copy];
    copy.pRODUCTWEIGHT = [self.pRODUCTWEIGHT copy];
    
    return copy;
}

@end

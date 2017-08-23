//
//  AddStockModel.m
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddStockModel.h"


//NSString *const kAddStockModelPRODUCTIONDATE = @"PRODUCTION_DATE";
//NSString *const kAddStockModelPRODUCTIDX = @"PRODUCT_IDX";
//NSString *const kAddStockModelPRODUCTNAME = @"PRODUCT_NAME";
//NSString *const kAddStockModelPRODUCTNO = @"PRODUCT_NO";
//NSString *const kAddStockModelSTOCKQTY = @"STOCK_QTY";


@implementation AddStockModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

//-(instancetype)initWithDictionary:(NSDictionary *)dictionary
//{
//    self = [super init];
//    if(![dictionary[kAddStockModelPRODUCTIONDATE] isKindOfClass:[NSNull class]]){
//        self.pRODUCTIONDATE = dictionary[kAddStockModelPRODUCTIONDATE];
//    }
//    if(![dictionary[kAddStockModelPRODUCTIDX] isKindOfClass:[NSNull class]]){
//        self.pRODUCTIDX = dictionary[kAddStockModelPRODUCTIDX];
//    }
//    if(![dictionary[kAddStockModelPRODUCTNAME] isKindOfClass:[NSNull class]]){
//        self.pRODUCTNAME = dictionary[kAddStockModelPRODUCTNAME];
//    }
//    if(![dictionary[kAddStockModelPRODUCTNO] isKindOfClass:[NSNull class]]){
//        self.pRODUCTNO = dictionary[kAddStockModelPRODUCTNO];
//    }
//    if(![dictionary[kAddStockModelSTOCKQTY] isKindOfClass:[NSNull class]]){
//        self.sTOCKQTY = dictionary[kAddStockModelSTOCKQTY];
//    }
//    return self;
//}
//
//
///**
// * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
// */
//-(NSDictionary *)toDictionary
//{
//    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
//    if(self.pRODUCTIONDATE != nil){
//        dictionary[kAddStockModelPRODUCTIONDATE] = self.pRODUCTIONDATE;
//    }
//    if(self.pRODUCTIDX != nil){
//        dictionary[kAddStockModelPRODUCTIDX] = self.pRODUCTIDX;
//    }
//    if(self.pRODUCTNAME != nil){
//        dictionary[kAddStockModelPRODUCTNAME] = self.pRODUCTNAME;
//    }
//    if(self.pRODUCTNO != nil){
//        dictionary[kAddStockModelPRODUCTNO] = self.pRODUCTNO;
//    }
//    if(self.sTOCKQTY != nil){
//        dictionary[kAddStockModelSTOCKQTY] = self.sTOCKQTY;
//    }
//    return dictionary;
//    
//}
//
///**
// * Implementation of NSCoding encoding method
// */
///**
// * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
// */
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    if(self.pRODUCTIONDATE != nil){
//        [aCoder encodeObject:self.pRODUCTIONDATE forKey:kAddStockModelPRODUCTIONDATE];
//    }
//    if(self.pRODUCTIDX != nil){
//        [aCoder encodeObject:self.pRODUCTIDX forKey:kAddStockModelPRODUCTIDX];
//    }
//    if(self.pRODUCTNAME != nil){
//        [aCoder encodeObject:self.pRODUCTNAME forKey:kAddStockModelPRODUCTNAME];
//    }
//    if(self.pRODUCTNO != nil){
//        [aCoder encodeObject:self.pRODUCTNO forKey:kAddStockModelPRODUCTNO];
//    }
//    if(self.sTOCKQTY != nil){
//        [aCoder encodeObject:self.sTOCKQTY forKey:kAddStockModelSTOCKQTY];
//    }
//    
//}
//
///**
// * Implementation of NSCoding initWithCoder: method
// */
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    self.pRODUCTIONDATE = [aDecoder decodeObjectForKey:kAddStockModelPRODUCTIONDATE];
//    self.pRODUCTIDX = [aDecoder decodeObjectForKey:kAddStockModelPRODUCTIDX];
//    self.pRODUCTNAME = [aDecoder decodeObjectForKey:kAddStockModelPRODUCTNAME];
//    self.pRODUCTNO = [aDecoder decodeObjectForKey:kAddStockModelPRODUCTNO];
//    self.sTOCKQTY = [aDecoder decodeObjectForKey:kAddStockModelSTOCKQTY];
//    return self;
//    
//}
//
///**
// * Implementation of NSCopying copyWithZone: method
// */
//- (instancetype)copyWithZone:(NSZone *)zone
//{
//    AddStockModel *copy = [AddStockModel new];
//    
//    copy.pRODUCTIONDATE = [self.pRODUCTIONDATE copy];
//    copy.pRODUCTIDX = [self.pRODUCTIDX copy];
//    copy.pRODUCTNAME = [self.pRODUCTNAME copy];
//    copy.pRODUCTNO = [self.pRODUCTNO copy];
//    copy.sTOCKQTY = [self.sTOCKQTY copy];
//    
//    return copy;
//}

@end

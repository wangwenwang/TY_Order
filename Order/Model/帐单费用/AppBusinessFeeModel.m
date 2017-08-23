//
//  AppBusinessFeeModel.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AppBusinessFeeModel.h"


NSString *const kAppBusinessFeeModelBUSINESSCODE = @"BUSINESS_CODE";
NSString *const kAppBusinessFeeModelBUSINESSNAME = @"BUSINESS_NAME";
NSString *const kAppBusinessFeeModelLastMonth = @"LastMonth";
NSString *const kAppBusinessFeeModelPARTYCODE = @"PARTY_CODE";
NSString *const kAppBusinessFeeModelPARTYNAME = @"PARTY_NAME";
NSString *const kAppBusinessFeeModelThisMonth = @"ThisMonth";
NSString *const kAppBusinessFeeModelThisMonthMinus = @"ThisMonthMinus";
NSString *const kAppBusinessFeeModelThisMonthPostive = @"ThisMonthPostive";


@implementation AppBusinessFeeModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAppBusinessFeeModelBUSINESSCODE] isKindOfClass:[NSNull class]]){
        self.bUSINESSCODE = dictionary[kAppBusinessFeeModelBUSINESSCODE];
    }
    if(![dictionary[kAppBusinessFeeModelBUSINESSNAME] isKindOfClass:[NSNull class]]){
        self.bUSINESSNAME = dictionary[kAppBusinessFeeModelBUSINESSNAME];
    }
    if(![dictionary[kAppBusinessFeeModelLastMonth] isKindOfClass:[NSNull class]]){
        self.lastMonth = dictionary[kAppBusinessFeeModelLastMonth];
    }
    if(![dictionary[kAppBusinessFeeModelPARTYCODE] isKindOfClass:[NSNull class]]){
        self.pARTYCODE = dictionary[kAppBusinessFeeModelPARTYCODE];
    }
    if(![dictionary[kAppBusinessFeeModelPARTYNAME] isKindOfClass:[NSNull class]]){
        self.pARTYNAME = dictionary[kAppBusinessFeeModelPARTYNAME];
    }
    if(![dictionary[kAppBusinessFeeModelThisMonth] isKindOfClass:[NSNull class]]){
        self.thisMonth = dictionary[kAppBusinessFeeModelThisMonth];
    }
    if(![dictionary[kAppBusinessFeeModelThisMonthMinus] isKindOfClass:[NSNull class]]){
        self.thisMonthMinus = dictionary[kAppBusinessFeeModelThisMonthMinus];
    }
    if(![dictionary[kAppBusinessFeeModelThisMonthPostive] isKindOfClass:[NSNull class]]){
        self.thisMonthPostive = dictionary[kAppBusinessFeeModelThisMonthPostive];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.bUSINESSCODE != nil){
        dictionary[kAppBusinessFeeModelBUSINESSCODE] = self.bUSINESSCODE;
    }
    if(self.bUSINESSNAME != nil){
        dictionary[kAppBusinessFeeModelBUSINESSNAME] = self.bUSINESSNAME;
    }
    if(self.lastMonth != nil){
        dictionary[kAppBusinessFeeModelLastMonth] = self.lastMonth;
    }
    if(self.pARTYCODE != nil){
        dictionary[kAppBusinessFeeModelPARTYCODE] = self.pARTYCODE;
    }
    if(self.pARTYNAME != nil){
        dictionary[kAppBusinessFeeModelPARTYNAME] = self.pARTYNAME;
    }
    if(self.thisMonth != nil){
        dictionary[kAppBusinessFeeModelThisMonth] = self.thisMonth;
    }
    if(self.thisMonthMinus != nil){
        dictionary[kAppBusinessFeeModelThisMonthMinus] = self.thisMonthMinus;
    }
    if(self.thisMonthPostive != nil){
        dictionary[kAppBusinessFeeModelThisMonthPostive] = self.thisMonthPostive;
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
    if(self.bUSINESSCODE != nil){
        [aCoder encodeObject:self.bUSINESSCODE forKey:kAppBusinessFeeModelBUSINESSCODE];
    }
    if(self.bUSINESSNAME != nil){
        [aCoder encodeObject:self.bUSINESSNAME forKey:kAppBusinessFeeModelBUSINESSNAME];
    }
    if(self.lastMonth != nil){
        [aCoder encodeObject:self.lastMonth forKey:kAppBusinessFeeModelLastMonth];
    }
    if(self.pARTYCODE != nil){
        [aCoder encodeObject:self.pARTYCODE forKey:kAppBusinessFeeModelPARTYCODE];
    }
    if(self.pARTYNAME != nil){
        [aCoder encodeObject:self.pARTYNAME forKey:kAppBusinessFeeModelPARTYNAME];
    }
    if(self.thisMonth != nil){
        [aCoder encodeObject:self.thisMonth forKey:kAppBusinessFeeModelThisMonth];
    }
    if(self.thisMonthMinus != nil){
        [aCoder encodeObject:self.thisMonthMinus forKey:kAppBusinessFeeModelThisMonthMinus];
    }
    if(self.thisMonthPostive != nil){
        [aCoder encodeObject:self.thisMonthPostive forKey:kAppBusinessFeeModelThisMonthPostive];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.bUSINESSCODE = [aDecoder decodeObjectForKey:kAppBusinessFeeModelBUSINESSCODE];
    self.bUSINESSNAME = [aDecoder decodeObjectForKey:kAppBusinessFeeModelBUSINESSNAME];
    self.lastMonth = [aDecoder decodeObjectForKey:kAppBusinessFeeModelLastMonth];
    self.pARTYCODE = [aDecoder decodeObjectForKey:kAppBusinessFeeModelPARTYCODE];
    self.pARTYNAME = [aDecoder decodeObjectForKey:kAppBusinessFeeModelPARTYNAME];
    self.thisMonth = [aDecoder decodeObjectForKey:kAppBusinessFeeModelThisMonth];
    self.thisMonthMinus = [aDecoder decodeObjectForKey:kAppBusinessFeeModelThisMonthMinus];
    self.thisMonthPostive = [aDecoder decodeObjectForKey:kAppBusinessFeeModelThisMonthPostive];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AppBusinessFeeModel *copy = [AppBusinessFeeModel new];
    
    copy.bUSINESSCODE = [self.bUSINESSCODE copy];
    copy.bUSINESSNAME = [self.bUSINESSNAME copy];
    copy.lastMonth = [self.lastMonth copy];
    copy.pARTYCODE = [self.pARTYCODE copy];
    copy.pARTYNAME = [self.pARTYNAME copy];
    copy.thisMonth = [self.thisMonth copy];
    copy.thisMonthMinus = [self.thisMonthMinus copy];
    copy.thisMonthPostive = [self.thisMonthPostive copy];
    
    return copy;
}

@end

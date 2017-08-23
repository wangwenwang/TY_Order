//
//  AppBusinessFeeListModel.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AppBusinessFeeListModel.h"


NSString *const kAppBusinessFeeListModelFEEAMOUNT = @"FEE_AMOUNT";
NSString *const kAppBusinessFeeListModelFEEDATE = @"FEE_DATE";
NSString *const kAppBusinessFeeListModelFEENAME = @"FEE_NAME";


@implementation AppBusinessFeeListModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAppBusinessFeeListModelFEEAMOUNT] isKindOfClass:[NSNull class]]){
        self.fEEAMOUNT = dictionary[kAppBusinessFeeListModelFEEAMOUNT];
    }
    if(![dictionary[kAppBusinessFeeListModelFEEDATE] isKindOfClass:[NSNull class]]){
        self.fEEDATE = dictionary[kAppBusinessFeeListModelFEEDATE];
    }
    if(![dictionary[kAppBusinessFeeListModelFEENAME] isKindOfClass:[NSNull class]]){
        self.fEENAME = dictionary[kAppBusinessFeeListModelFEENAME];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.fEEAMOUNT != nil){
        dictionary[kAppBusinessFeeListModelFEEAMOUNT] = self.fEEAMOUNT;
    }
    if(self.fEEDATE != nil){
        dictionary[kAppBusinessFeeListModelFEEDATE] = self.fEEDATE;
    }
    if(self.fEENAME != nil){
        dictionary[kAppBusinessFeeListModelFEENAME] = self.fEENAME;
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
    if(self.fEEAMOUNT != nil){
        [aCoder encodeObject:self.fEEAMOUNT forKey:kAppBusinessFeeListModelFEEAMOUNT];
    }
    if(self.fEEDATE != nil){
        [aCoder encodeObject:self.fEEDATE forKey:kAppBusinessFeeListModelFEEDATE];
    }
    if(self.fEENAME != nil){
        [aCoder encodeObject:self.fEENAME forKey:kAppBusinessFeeListModelFEENAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.fEEAMOUNT = [aDecoder decodeObjectForKey:kAppBusinessFeeListModelFEEAMOUNT];
    self.fEEDATE = [aDecoder decodeObjectForKey:kAppBusinessFeeListModelFEEDATE];
    self.fEENAME = [aDecoder decodeObjectForKey:kAppBusinessFeeListModelFEENAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AppBusinessFeeListModel *copy = [AppBusinessFeeListModel new];
    
    copy.fEEAMOUNT = [self.fEEAMOUNT copy];
    copy.fEEDATE = [self.fEEDATE copy];
    copy.fEENAME = [self.fEENAME copy];
    
    return copy;
}

@end

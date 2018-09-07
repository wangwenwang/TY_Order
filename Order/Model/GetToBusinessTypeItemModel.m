//
//  GetToBusinessTypeItemModel.m
//  Order
//
//  Created by wenwang wang on 2018/9/7.
//  Copyright © 2018年 凯东源. All rights reserved.
//

#import "GetToBusinessTypeItemModel.h"

NSString *const kGetToBusinessTypeItemModelBUSINESSIDX = @"BUSINESS_IDX";
NSString *const kGetToBusinessTypeItemModelIDX = @"IDX";

@implementation GetToBusinessTypeItemModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetToBusinessTypeItemModelBUSINESSIDX] isKindOfClass:[NSNull class]]){
        self.bUSINESSIDX = dictionary[kGetToBusinessTypeItemModelBUSINESSIDX];
    }
    if(![dictionary[kGetToBusinessTypeItemModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kGetToBusinessTypeItemModelIDX];
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
        dictionary[kGetToBusinessTypeItemModelBUSINESSIDX] = self.bUSINESSIDX;
    }
    if(self.iDX != nil){
        dictionary[kGetToBusinessTypeItemModelIDX] = self.iDX;
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
        [aCoder encodeObject:self.bUSINESSIDX forKey:kGetToBusinessTypeItemModelBUSINESSIDX];
    }
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kGetToBusinessTypeItemModelIDX];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.bUSINESSIDX = [aDecoder decodeObjectForKey:kGetToBusinessTypeItemModelBUSINESSIDX];
    self.iDX = [aDecoder decodeObjectForKey:kGetToBusinessTypeItemModelIDX];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetToBusinessTypeItemModel *copy = [GetToBusinessTypeItemModel new];
    
    copy.bUSINESSIDX = [self.bUSINESSIDX copy];
    copy.iDX = [self.iDX copy];
    
    return copy;
}

@end

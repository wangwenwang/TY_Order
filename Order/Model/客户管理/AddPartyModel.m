//
//  AddPartyModel.m
//  Order
//
//  Created by 凯东源 on 17/7/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddPartyModel.h"


NSString *const kAddPartyModelIDX = @"IDX";
NSString *const kAddPartyModelStrPartyCode = @"strPartyCode";


@implementation AddPartyModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAddPartyModelIDX] isKindOfClass:[NSNull class]]){
        self.iDX = dictionary[kAddPartyModelIDX];
    }
    if(![dictionary[kAddPartyModelStrPartyCode] isKindOfClass:[NSNull class]]){
        self.strPartyCode = dictionary[kAddPartyModelStrPartyCode];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.iDX != nil){
        dictionary[kAddPartyModelIDX] = self.iDX;
    }
    if(self.strPartyCode != nil){
        dictionary[kAddPartyModelStrPartyCode] = self.strPartyCode;
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
    if(self.iDX != nil){
        [aCoder encodeObject:self.iDX forKey:kAddPartyModelIDX];
    }
    if(self.strPartyCode != nil){
        [aCoder encodeObject:self.strPartyCode forKey:kAddPartyModelStrPartyCode];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.iDX = [aDecoder decodeObjectForKey:kAddPartyModelIDX];
    self.strPartyCode = [aDecoder decodeObjectForKey:kAddPartyModelStrPartyCode];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AddPartyModel *copy = [AddPartyModel new];
    
    copy.iDX = [self.iDX copy];
    copy.strPartyCode = [self.strPartyCode copy];
    
    return copy;
}

@end

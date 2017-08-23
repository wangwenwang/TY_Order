//
//  NormalAdressModel.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "NormalAdressModel.h"


NSString *const kNormalAdressModelITEMIDX = @"ITEM_IDX";
NSString *const kNormalAdressModelITEMNAME = @"ITEM_NAME";


@implementation NormalAdressModel


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kNormalAdressModelITEMIDX] isKindOfClass:[NSNull class]]){
        self.iTEMIDX = dictionary[kNormalAdressModelITEMIDX];
    }
    if(![dictionary[kNormalAdressModelITEMNAME] isKindOfClass:[NSNull class]]){
        self.iTEMNAME = dictionary[kNormalAdressModelITEMNAME];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.iTEMIDX != nil){
        dictionary[kNormalAdressModelITEMIDX] = self.iTEMIDX;
    }
    if(self.iTEMNAME != nil){
        dictionary[kNormalAdressModelITEMNAME] = self.iTEMNAME;
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
    if(self.iTEMIDX != nil){
        [aCoder encodeObject:self.iTEMIDX forKey:kNormalAdressModelITEMIDX];
    }
    if(self.iTEMNAME != nil){
        [aCoder encodeObject:self.iTEMNAME forKey:kNormalAdressModelITEMNAME];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.iTEMIDX = [aDecoder decodeObjectForKey:kNormalAdressModelITEMIDX];
    self.iTEMNAME = [aDecoder decodeObjectForKey:kNormalAdressModelITEMNAME];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    NormalAdressModel *copy = [NormalAdressModel new];
    
    copy.iTEMIDX = [self.iTEMIDX copy];
    copy.iTEMNAME = [self.iTEMNAME copy];
    
    return copy;
}

@end

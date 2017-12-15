//
//  DeliveryWayItemModel.m
//  Order
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "DeliveryWayItemModel.h"


NSString *const kDeliveryWayItemModelItemDesc = @"item_desc";
NSString *const kDeliveryWayItemModelItemName = @"item_name";


@implementation DeliveryWayItemModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kDeliveryWayItemModelItemDesc] isKindOfClass:[NSNull class]]){
        self.itemDesc = dictionary[kDeliveryWayItemModelItemDesc];
    }
    if(![dictionary[kDeliveryWayItemModelItemName] isKindOfClass:[NSNull class]]){
        self.itemName = dictionary[kDeliveryWayItemModelItemName];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.itemDesc != nil){
        dictionary[kDeliveryWayItemModelItemDesc] = self.itemDesc;
    }
    if(self.itemName != nil){
        dictionary[kDeliveryWayItemModelItemName] = self.itemName;
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
    if(self.itemDesc != nil){
        [aCoder encodeObject:self.itemDesc forKey:kDeliveryWayItemModelItemDesc];
    }
    if(self.itemName != nil){
        [aCoder encodeObject:self.itemName forKey:kDeliveryWayItemModelItemName];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.itemDesc = [aDecoder decodeObjectForKey:kDeliveryWayItemModelItemDesc];
    self.itemName = [aDecoder decodeObjectForKey:kDeliveryWayItemModelItemName];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    DeliveryWayItemModel *copy = [DeliveryWayItemModel new];
    
    copy.itemDesc = [self.itemDesc copy];
    copy.itemName = [self.itemName copy];
    
    return copy;
}

@end

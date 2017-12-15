//
//  DeliveryWayListModel.m
//  Order
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "DeliveryWayListModel.h"


NSString *const kDeliveryWayListModelDeliveryWayItemModel = @"result";
NSString *const kDeliveryWayListModelMsg = @"msg";
NSString *const kDeliveryWayListModelType = @"type";


@implementation DeliveryWayListModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kDeliveryWayListModelDeliveryWayItemModel] != nil && [dictionary[kDeliveryWayListModelDeliveryWayItemModel] isKindOfClass:[NSArray class]]){
        NSArray * deliveryWayItemModelDictionaries = dictionary[kDeliveryWayListModelDeliveryWayItemModel];
        NSMutableArray * deliveryWayItemModelItems = [NSMutableArray array];
        for(NSDictionary * deliveryWayItemModelDictionary in deliveryWayItemModelDictionaries){
            DeliveryWayItemModel * deliveryWayItemModelItem = [[DeliveryWayItemModel alloc] initWithDictionary:deliveryWayItemModelDictionary];
            [deliveryWayItemModelItems addObject:deliveryWayItemModelItem];
        }
        self.deliveryWayItemModel = deliveryWayItemModelItems;
    }
    if(![dictionary[kDeliveryWayListModelMsg] isKindOfClass:[NSNull class]]){
        self.msg = dictionary[kDeliveryWayListModelMsg];
    }
    if(![dictionary[kDeliveryWayListModelType] isKindOfClass:[NSNull class]]){
        self.type = dictionary[kDeliveryWayListModelType];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.deliveryWayItemModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(DeliveryWayItemModel * deliveryWayItemModelElement in self.deliveryWayItemModel){
            [dictionaryElements addObject:[deliveryWayItemModelElement toDictionary]];
        }
        dictionary[kDeliveryWayListModelDeliveryWayItemModel] = dictionaryElements;
    }
    if(self.msg != nil){
        dictionary[kDeliveryWayListModelMsg] = self.msg;
    }
    if(self.type != nil){
        dictionary[kDeliveryWayListModelType] = self.type;
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
    if(self.deliveryWayItemModel != nil){
        [aCoder encodeObject:self.deliveryWayItemModel forKey:kDeliveryWayListModelDeliveryWayItemModel];
    }
    if(self.msg != nil){
        [aCoder encodeObject:self.msg forKey:kDeliveryWayListModelMsg];
    }
    if(self.type != nil){
        [aCoder encodeObject:self.type forKey:kDeliveryWayListModelType];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.deliveryWayItemModel = [aDecoder decodeObjectForKey:kDeliveryWayListModelDeliveryWayItemModel];
    self.msg = [aDecoder decodeObjectForKey:kDeliveryWayListModelMsg];
    self.type = [aDecoder decodeObjectForKey:kDeliveryWayListModelType];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    DeliveryWayListModel *copy = [DeliveryWayListModel new];
    
    copy.deliveryWayItemModel = [self.deliveryWayItemModel copy];
    copy.msg = [self.msg copy];
    copy.type = [self.type copy];
    
    return copy;
}

@end

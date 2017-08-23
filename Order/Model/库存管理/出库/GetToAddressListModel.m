//
//  GetToAddressListModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetToAddressListModel.h"


NSString *const kGetToAddressListModelGetToAddressModel = @"To";


@implementation GetToAddressListModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kGetToAddressListModelGetToAddressModel] != nil && [dictionary[kGetToAddressListModelGetToAddressModel] isKindOfClass:[NSArray class]]){
        NSArray * getToAddressModelDictionaries = dictionary[kGetToAddressListModelGetToAddressModel];
        NSMutableArray * getToAddressModelItems = [NSMutableArray array];
        for(NSDictionary * getToAddressModelDictionary in getToAddressModelDictionaries){
            GetToAddressModel * getToAddressModelItem = [[GetToAddressModel alloc] initWithDictionary:getToAddressModelDictionary];
            [getToAddressModelItems addObject:getToAddressModelItem];
        }
        self.getToAddressModel = getToAddressModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.getToAddressModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(GetToAddressModel * getToAddressModelElement in self.getToAddressModel){
            [dictionaryElements addObject:[getToAddressModelElement toDictionary]];
        }
        dictionary[kGetToAddressListModelGetToAddressModel] = dictionaryElements;
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
    if(self.getToAddressModel != nil){
        [aCoder encodeObject:self.getToAddressModel forKey:kGetToAddressListModelGetToAddressModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.getToAddressModel = [aDecoder decodeObjectForKey:kGetToAddressListModelGetToAddressModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetToAddressListModel *copy = [GetToAddressListModel new];
    
    copy.getToAddressModel = [self.getToAddressModel copy];
    
    return copy;
}

@end

//
//  GetOupputListModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputListModel.h"


NSString *const kGetOupputListModelGetOupputModel = @"List";


@implementation GetOupputListModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kGetOupputListModelGetOupputModel] != nil && [dictionary[kGetOupputListModelGetOupputModel] isKindOfClass:[NSArray class]]){
        NSArray * getOupputModelDictionaries = dictionary[kGetOupputListModelGetOupputModel];
        NSMutableArray * getOupputModelItems = [NSMutableArray array];
        for(NSDictionary * getOupputModelDictionary in getOupputModelDictionaries){
            GetOupputModel * getOupputModelItem = [[GetOupputModel alloc] initWithDictionary:getOupputModelDictionary];
            [getOupputModelItems addObject:getOupputModelItem];
        }
        self.getOupputModel = getOupputModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.getOupputModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(GetOupputModel * getOupputModelElement in self.getOupputModel){
            [dictionaryElements addObject:[getOupputModelElement toDictionary]];
        }
        dictionary[kGetOupputListModelGetOupputModel] = dictionaryElements;
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
    if(self.getOupputModel != nil){
        [aCoder encodeObject:self.getOupputModel forKey:kGetOupputListModelGetOupputModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.getOupputModel = [aDecoder decodeObjectForKey:kGetOupputListModelGetOupputModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOupputListModel *copy = [GetOupputListModel new];
    
    copy.getOupputModel = [self.getOupputModel copy];
    
    return copy;
}

@end

//
//  GetToBusinessTypeListModel.m
//  Order
//
//  Created by wenwang wang on 2018/9/7.
//  Copyright © 2018年 凯东源. All rights reserved.
//

#import "GetToBusinessTypeListModel.h"

NSString *const kGetToBusinessTypeListModelGetToBusinessTypeItemModel = @"List";

@implementation GetToBusinessTypeListModel


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kGetToBusinessTypeListModelGetToBusinessTypeItemModel] != nil && [dictionary[kGetToBusinessTypeListModelGetToBusinessTypeItemModel] isKindOfClass:[NSArray class]]){
        NSArray * getToBusinessTypeItemModelDictionaries = dictionary[kGetToBusinessTypeListModelGetToBusinessTypeItemModel];
        NSMutableArray * getToBusinessTypeItemModelItems = [NSMutableArray array];
        for(NSDictionary * getToBusinessTypeItemModelDictionary in getToBusinessTypeItemModelDictionaries){
            GetToBusinessTypeItemModel * getToBusinessTypeItemModelItem = [[GetToBusinessTypeItemModel alloc] initWithDictionary:getToBusinessTypeItemModelDictionary];
            [getToBusinessTypeItemModelItems addObject:getToBusinessTypeItemModelItem];
        }
        self.getToBusinessTypeItemModel = getToBusinessTypeItemModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.getToBusinessTypeItemModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(GetToBusinessTypeItemModel * getToBusinessTypeItemModelElement in self.getToBusinessTypeItemModel){
            [dictionaryElements addObject:[getToBusinessTypeItemModelElement toDictionary]];
        }
        dictionary[kGetToBusinessTypeListModelGetToBusinessTypeItemModel] = dictionaryElements;
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
    if(self.getToBusinessTypeItemModel != nil){
        [aCoder encodeObject:self.getToBusinessTypeItemModel forKey:kGetToBusinessTypeListModelGetToBusinessTypeItemModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.getToBusinessTypeItemModel = [aDecoder decodeObjectForKey:kGetToBusinessTypeListModelGetToBusinessTypeItemModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetToBusinessTypeListModel *copy = [GetToBusinessTypeListModel new];
    
    copy.getToBusinessTypeItemModel = [self.getToBusinessTypeItemModel copy];
    
    return copy;
}

@end

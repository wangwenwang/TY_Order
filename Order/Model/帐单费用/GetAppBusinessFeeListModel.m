//
//  GetAppBusinessFeeListModel.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBusinessFeeListModel.h"


NSString *const kGetAppBusinessFeeListModelAppBusinessFeeListModel = @"AppBusinessFeeList";
NSString *const kGetAppBusinessFeeListModelAppBusinessFeeModel = @"AppBusinessFee";


@implementation GetAppBusinessFeeListModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kGetAppBusinessFeeListModelAppBusinessFeeListModel] != nil && [dictionary[kGetAppBusinessFeeListModelAppBusinessFeeListModel] isKindOfClass:[NSArray class]]){
        NSArray * appBusinessFeeListModelDictionaries = dictionary[kGetAppBusinessFeeListModelAppBusinessFeeListModel];
        NSMutableArray * appBusinessFeeListModelItems = [NSMutableArray array];
        for(NSDictionary * appBusinessFeeListModelDictionary in appBusinessFeeListModelDictionaries){
            AppBusinessFeeListModel * appBusinessFeeListModelItem = [[AppBusinessFeeListModel alloc] initWithDictionary:appBusinessFeeListModelDictionary];
            [appBusinessFeeListModelItems addObject:appBusinessFeeListModelItem];
        }
        self.appBusinessFeeListModel = appBusinessFeeListModelItems;
    }
    if(![dictionary[kGetAppBusinessFeeListModelAppBusinessFeeModel] isKindOfClass:[NSNull class]]){
        self.appBusinessFeeModel = [[AppBusinessFeeModel alloc] initWithDictionary:dictionary[kGetAppBusinessFeeListModelAppBusinessFeeModel]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.appBusinessFeeListModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(AppBusinessFeeListModel * appBusinessFeeListModelElement in self.appBusinessFeeListModel){
            [dictionaryElements addObject:[appBusinessFeeListModelElement toDictionary]];
        }
        dictionary[kGetAppBusinessFeeListModelAppBusinessFeeListModel] = dictionaryElements;
    }
    if(self.appBusinessFeeModel != nil){
        dictionary[kGetAppBusinessFeeListModelAppBusinessFeeModel] = [self.appBusinessFeeModel toDictionary];
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
    if(self.appBusinessFeeListModel != nil){
        [aCoder encodeObject:self.appBusinessFeeListModel forKey:kGetAppBusinessFeeListModelAppBusinessFeeListModel];
    }
    if(self.appBusinessFeeModel != nil){
        [aCoder encodeObject:self.appBusinessFeeModel forKey:kGetAppBusinessFeeListModelAppBusinessFeeModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.appBusinessFeeListModel = [aDecoder decodeObjectForKey:kGetAppBusinessFeeListModelAppBusinessFeeListModel];
    self.appBusinessFeeModel = [aDecoder decodeObjectForKey:kGetAppBusinessFeeListModelAppBusinessFeeModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetAppBusinessFeeListModel *copy = [GetAppBusinessFeeListModel new];
    
    copy.appBusinessFeeListModel = [self.appBusinessFeeListModel copy];
    copy.appBusinessFeeModel = [self.appBusinessFeeModel copy];
    
    return copy;
}

@end

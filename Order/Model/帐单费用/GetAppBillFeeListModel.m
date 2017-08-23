//
//  GetAppBillFeeListModel.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBillFeeListModel.h"


NSString *const kGetAppBillFeeListModelAppBillFeeModel = @"AppBillFee";


@implementation GetAppBillFeeListModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kGetAppBillFeeListModelAppBillFeeModel] != nil && [dictionary[kGetAppBillFeeListModelAppBillFeeModel] isKindOfClass:[NSArray class]]){
        NSArray * appBillFeeModelDictionaries = dictionary[kGetAppBillFeeListModelAppBillFeeModel];
        NSMutableArray * appBillFeeModelItems = [NSMutableArray array];
        for(NSDictionary * appBillFeeModelDictionary in appBillFeeModelDictionaries){
            AppBillFeeModel * appBillFeeModelItem = [[AppBillFeeModel alloc] initWithDictionary:appBillFeeModelDictionary];
            [appBillFeeModelItems addObject:appBillFeeModelItem];
        }
        self.appBillFeeModel = appBillFeeModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.appBillFeeModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(AppBillFeeModel * appBillFeeModelElement in self.appBillFeeModel){
            [dictionaryElements addObject:[appBillFeeModelElement toDictionary]];
        }
        dictionary[kGetAppBillFeeListModelAppBillFeeModel] = dictionaryElements;
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
    if(self.appBillFeeModel != nil){
        [aCoder encodeObject:self.appBillFeeModel forKey:kGetAppBillFeeListModelAppBillFeeModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.appBillFeeModel = [aDecoder decodeObjectForKey:kGetAppBillFeeListModelAppBillFeeModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetAppBillFeeListModel *copy = [GetAppBillFeeListModel new];
    
    copy.appBillFeeModel = [self.appBillFeeModel copy];
    
    return copy;
}

@end

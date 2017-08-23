//
//  AppStockListModel.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AppStockListModel.h"



NSString *const kAppStockListModelAppStockModel = @"AppStock";
NSString *const kAppStockListModelStockModel = @"Stock";


@implementation AppStockListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kAppStockListModelAppStockModel] != nil && [dictionary[kAppStockListModelAppStockModel] isKindOfClass:[NSArray class]]){
        NSArray * appStockModelDictionaries = dictionary[kAppStockListModelAppStockModel];
        NSMutableArray * appStockModelItems = [NSMutableArray array];
        for(NSDictionary * appStockModelDictionary in appStockModelDictionaries){
            AppStockModel * appStockModelItem = [[AppStockModel alloc] initWithDictionary:appStockModelDictionary];
            [appStockModelItems addObject:appStockModelItem];
        }
        self.appStockModel = appStockModelItems;
    }
    if(![dictionary[kAppStockListModelStockModel] isKindOfClass:[NSNull class]]){
        self.stockModel = [[StockModel alloc] initWithDictionary:dictionary[kAppStockListModelStockModel]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.appStockModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(AppStockModel * appStockModelElement in self.appStockModel){
            [dictionaryElements addObject:[appStockModelElement toDictionary]];
        }
        dictionary[kAppStockListModelAppStockModel] = dictionaryElements;
    }
    if(self.stockModel != nil){
        dictionary[kAppStockListModelStockModel] = [self.stockModel toDictionary];
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
    if(self.appStockModel != nil){
        [aCoder encodeObject:self.appStockModel forKey:kAppStockListModelAppStockModel];
    }
    if(self.stockModel != nil){
        [aCoder encodeObject:self.stockModel forKey:kAppStockListModelStockModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.appStockModel = [aDecoder decodeObjectForKey:kAppStockListModelAppStockModel];
    self.stockModel = [aDecoder decodeObjectForKey:kAppStockListModelStockModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AppStockListModel *copy = [AppStockListModel new];
    
    copy.appStockModel = [self.appStockModel copy];
    copy.stockModel = [self.stockModel copy];
    
    return copy;
}

@end

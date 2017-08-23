//
//  StockListModel.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "StockListModel.h"


NSString *const kStockListModelStockModel = @"Stock";


@implementation StockListModel


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kStockListModelStockModel] != nil && [dictionary[kStockListModelStockModel] isKindOfClass:[NSArray class]]){
        NSArray * stockModelDictionaries = dictionary[kStockListModelStockModel];
        NSMutableArray * stockModelItems = [NSMutableArray array];
        for(NSDictionary * stockModelDictionary in stockModelDictionaries){
            StockModel * stockModelItem = [[StockModel alloc] initWithDictionary:stockModelDictionary];
            [stockModelItems addObject:stockModelItem];
        }
        self.stockModel = stockModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.stockModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(StockModel * stockModelElement in self.stockModel){
            [dictionaryElements addObject:[stockModelElement toDictionary]];
        }
        dictionary[kStockListModelStockModel] = dictionaryElements;
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
    if(self.stockModel != nil){
        [aCoder encodeObject:self.stockModel forKey:kStockListModelStockModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.stockModel = [aDecoder decodeObjectForKey:kStockListModelStockModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    StockListModel *copy = [StockListModel new];
    
    copy.stockModel = [self.stockModel copy];
    
    return copy;
}

@end

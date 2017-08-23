//
//  FeeListModel.m
//  Order
//
//  Created by 凯东源 on 17/6/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "FeeListModel.h"


NSString *const kFeeListModelFeeModel = @"Fee";


@implementation FeeListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kFeeListModelFeeModel] != nil && [dictionary[kFeeListModelFeeModel] isKindOfClass:[NSArray class]]){
        NSArray * feeModelDictionaries = dictionary[kFeeListModelFeeModel];
        NSMutableArray * feeModelItems = [NSMutableArray array];
        for(NSDictionary * feeModelDictionary in feeModelDictionaries){
            FeeModel * feeModelItem = [[FeeModel alloc] initWithDictionary:feeModelDictionary];
            [feeModelItems addObject:feeModelItem];
        }
        self.feeModel = feeModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.feeModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(FeeModel * feeModelElement in self.feeModel){
            [dictionaryElements addObject:[feeModelElement toDictionary]];
        }
        dictionary[kFeeListModelFeeModel] = dictionaryElements;
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
    if(self.feeModel != nil){
        [aCoder encodeObject:self.feeModel forKey:kFeeListModelFeeModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.feeModel = [aDecoder decodeObjectForKey:kFeeListModelFeeModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    FeeListModel *copy = [FeeListModel new];
    
    copy.feeModel = [self.feeModel copy];
    
    return copy;
}

@end

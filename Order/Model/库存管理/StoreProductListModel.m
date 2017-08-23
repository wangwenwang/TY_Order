//
//  StoreProductListModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "StoreProductListModel.h"


NSString *const kStoreProductListModelStoreProductModel = @"result";
NSString *const kStoreProductListModelMsg = @"msg";
NSString *const kStoreProductListModelType = @"type";


@implementation StoreProductListModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kStoreProductListModelStoreProductModel] != nil && [dictionary[kStoreProductListModelStoreProductModel] isKindOfClass:[NSArray class]]){
        NSArray * storeProductModelDictionaries = dictionary[kStoreProductListModelStoreProductModel];
        NSMutableArray * storeProductModelItems = [NSMutableArray array];
        for(NSDictionary * storeProductModelDictionary in storeProductModelDictionaries){
            StoreProductModel * storeProductModelItem = [[StoreProductModel alloc] initWithDictionary:storeProductModelDictionary];
            [storeProductModelItems addObject:storeProductModelItem];
        }
        self.storeProductModel = storeProductModelItems;
    }
    if(![dictionary[kStoreProductListModelMsg] isKindOfClass:[NSNull class]]){
        self.msg = dictionary[kStoreProductListModelMsg];
    }
    if(![dictionary[kStoreProductListModelType] isKindOfClass:[NSNull class]]){
        self.type = dictionary[kStoreProductListModelType];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.storeProductModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(StoreProductModel * storeProductModelElement in self.storeProductModel){
            [dictionaryElements addObject:[storeProductModelElement toDictionary]];
        }
        dictionary[kStoreProductListModelStoreProductModel] = dictionaryElements;
    }
    if(self.msg != nil){
        dictionary[kStoreProductListModelMsg] = self.msg;
    }
    if(self.type != nil){
        dictionary[kStoreProductListModelType] = self.type;
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
    if(self.storeProductModel != nil){
        [aCoder encodeObject:self.storeProductModel forKey:kStoreProductListModelStoreProductModel];
    }
    if(self.msg != nil){
        [aCoder encodeObject:self.msg forKey:kStoreProductListModelMsg];
    }
    if(self.type != nil){
        [aCoder encodeObject:self.type forKey:kStoreProductListModelType];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.storeProductModel = [aDecoder decodeObjectForKey:kStoreProductListModelStoreProductModel];
    self.msg = [aDecoder decodeObjectForKey:kStoreProductListModelMsg];
    self.type = [aDecoder decodeObjectForKey:kStoreProductListModelType];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    StoreProductListModel *copy = [StoreProductListModel new];
    
    copy.storeProductModel = [self.storeProductModel copy];
    copy.msg = [self.msg copy];
    copy.type = [self.type copy];
    
    return copy;
}

@end

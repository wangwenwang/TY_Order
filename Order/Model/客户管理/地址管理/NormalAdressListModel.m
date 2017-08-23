//
//  NormalAdressListModel.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "NormalAdressListModel.h"


NSString *const kNormalAdressListModelNormalAdressModel = @"result";
NSString *const kNormalAdressListModelMsg = @"msg";
NSString *const kNormalAdressListModelType = @"type";


@implementation NormalAdressListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kNormalAdressListModelNormalAdressModel] != nil && [dictionary[kNormalAdressListModelNormalAdressModel] isKindOfClass:[NSArray class]]){
        NSArray * normalAdressModelDictionaries = dictionary[kNormalAdressListModelNormalAdressModel];
        NSMutableArray * normalAdressModelItems = [NSMutableArray array];
        for(NSDictionary * normalAdressModelDictionary in normalAdressModelDictionaries){
            NormalAdressModel * normalAdressModelItem = [[NormalAdressModel alloc] initWithDictionary:normalAdressModelDictionary];
            [normalAdressModelItems addObject:normalAdressModelItem];
        }
        self.normalAdressModel = normalAdressModelItems;
    }
    if(![dictionary[kNormalAdressListModelMsg] isKindOfClass:[NSNull class]]){
        self.msg = dictionary[kNormalAdressListModelMsg];
    }
    if(![dictionary[kNormalAdressListModelType] isKindOfClass:[NSNull class]]){
        self.type = dictionary[kNormalAdressListModelType];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.normalAdressModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(NormalAdressModel * normalAdressModelElement in self.normalAdressModel){
            [dictionaryElements addObject:[normalAdressModelElement toDictionary]];
        }
        dictionary[kNormalAdressListModelNormalAdressModel] = dictionaryElements;
    }
    if(self.msg != nil){
        dictionary[kNormalAdressListModelMsg] = self.msg;
    }
    if(self.type != nil){
        dictionary[kNormalAdressListModelType] = self.type;
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
    if(self.normalAdressModel != nil){
        [aCoder encodeObject:self.normalAdressModel forKey:kNormalAdressListModelNormalAdressModel];
    }
    if(self.msg != nil){
        [aCoder encodeObject:self.msg forKey:kNormalAdressListModelMsg];
    }
    if(self.type != nil){
        [aCoder encodeObject:self.type forKey:kNormalAdressListModelType];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.normalAdressModel = [aDecoder decodeObjectForKey:kNormalAdressListModelNormalAdressModel];
    self.msg = [aDecoder decodeObjectForKey:kNormalAdressListModelMsg];
    self.type = [aDecoder decodeObjectForKey:kNormalAdressListModelType];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    NormalAdressListModel *copy = [NormalAdressListModel new];
    
    copy.normalAdressModel = [self.normalAdressModel copy];
    copy.msg = [self.msg copy];
    copy.type = [self.type copy];
    
    return copy;
}

@end

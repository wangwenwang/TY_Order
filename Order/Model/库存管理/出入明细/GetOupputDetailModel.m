//
//  GetOupputDetailModel.m
//  Order
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputDetailModel.h"


NSString *const kGetOupputDetailModelGetOupputInfoModel = @"Info";
NSString *const kGetOupputDetailModelGetOupputItemModel = @"List";


@implementation GetOupputDetailModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetOupputDetailModelGetOupputInfoModel] isKindOfClass:[NSNull class]]){
        self.getOupputInfoModel = [[GetOupputInfoModel alloc] initWithDictionary:dictionary[kGetOupputDetailModelGetOupputInfoModel]];
    }
    
    if(dictionary[kGetOupputDetailModelGetOupputItemModel] != nil && [dictionary[kGetOupputDetailModelGetOupputItemModel] isKindOfClass:[NSArray class]]){
        NSArray * getOupputItemModelDictionaries = dictionary[kGetOupputDetailModelGetOupputItemModel];
        NSMutableArray * getOupputItemModelItems = [NSMutableArray array];
        for(NSDictionary * getOupputItemModelDictionary in getOupputItemModelDictionaries){
            GetOupputItemModel * getOupputItemModelItem = [[GetOupputItemModel alloc] initWithDictionary:getOupputItemModelDictionary];
            [getOupputItemModelItems addObject:getOupputItemModelItem];
        }
        self.getOupputItemModel = getOupputItemModelItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.getOupputInfoModel != nil){
        dictionary[kGetOupputDetailModelGetOupputInfoModel] = [self.getOupputInfoModel toDictionary];
    }
    if(self.getOupputItemModel != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(GetOupputItemModel * getOupputItemModelElement in self.getOupputItemModel){
            [dictionaryElements addObject:[getOupputItemModelElement toDictionary]];
        }
        dictionary[kGetOupputDetailModelGetOupputItemModel] = dictionaryElements;
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
    if(self.getOupputInfoModel != nil){
        [aCoder encodeObject:self.getOupputInfoModel forKey:kGetOupputDetailModelGetOupputInfoModel];
    }
    if(self.getOupputItemModel != nil){
        [aCoder encodeObject:self.getOupputItemModel forKey:kGetOupputDetailModelGetOupputItemModel];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.getOupputInfoModel = [aDecoder decodeObjectForKey:kGetOupputDetailModelGetOupputInfoModel];
    self.getOupputItemModel = [aDecoder decodeObjectForKey:kGetOupputDetailModelGetOupputItemModel];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOupputDetailModel *copy = [GetOupputDetailModel new];
    
    copy.getOupputInfoModel = [self.getOupputInfoModel copy];
    copy.getOupputItemModel = [self.getOupputItemModel copy];
    
    return copy;
}

@end

//
//  GetToBusinessTypeListModel.h
//  Order
//
//  Created by wenwang wang on 2018/9/7.
//  Copyright © 2018年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetToBusinessTypeItemModel.h"

@interface GetToBusinessTypeListModel : NSObject

@property (nonatomic, strong) NSArray * getToBusinessTypeItemModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

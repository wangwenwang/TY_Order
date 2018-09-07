//
//  GetToBusinessTypeItemModel.h
//  Order
//
//  Created by wenwang wang on 2018/9/7.
//  Copyright © 2018年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetToBusinessTypeItemModel : NSObject

@property (nonatomic, strong) NSString * bUSINESSIDX;
@property (nonatomic, strong) NSString * iDX;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

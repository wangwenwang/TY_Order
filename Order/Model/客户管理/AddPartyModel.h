//
//  AddPartyModel.h
//  Order
//
//  Created by 凯东源 on 17/7/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddPartyModel : NSObject

@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * strPartyCode;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

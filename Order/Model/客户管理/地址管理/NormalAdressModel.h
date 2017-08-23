//
//  NormalAdressModel.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalAdressModel : NSObject

// 地区ID
@property (nonatomic, strong) NSString * iTEMIDX;

// 地区名称
@property (nonatomic, strong) NSString * iTEMNAME;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

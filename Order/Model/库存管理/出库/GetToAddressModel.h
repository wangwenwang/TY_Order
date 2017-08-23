//
//  GetToAddressModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetToAddressModel : NSObject

@property (nonatomic, strong) NSString * aDDRESSINFO;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * iTEMCODE;
@property (nonatomic, strong) NSString * pARTYNAME;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@property (assign, nonatomic) CGFloat cellHeight;

@end

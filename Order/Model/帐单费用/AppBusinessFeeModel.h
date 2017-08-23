//
//  AppBusinessFeeModel.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppBusinessFeeModel : NSObject

@property (nonatomic, strong) NSString * bUSINESSCODE;
@property (nonatomic, strong) NSString * bUSINESSNAME;
@property (nonatomic, strong) NSString * lastMonth;
@property (nonatomic, strong) NSString * pARTYCODE;
@property (nonatomic, strong) NSString * pARTYNAME;
@property (nonatomic, strong) NSString * thisMonth;
@property (nonatomic, strong) NSString * thisMonthMinus;
@property (nonatomic, strong) NSString * thisMonthPostive;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

//
//  StockModel.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockModel : NSObject

@property (nonatomic, strong) NSString * aDDDATE;
@property (nonatomic, strong) NSString * bUSINESSCODE;
@property (nonatomic, strong) NSString * bUSINESSIDX;
@property (nonatomic, strong) NSString * bUSINESSNAME;
@property (nonatomic, strong) NSString * eDITDATE;
@property (nonatomic, strong) NSString * eNTIDX;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * pARTYCODE;
@property (nonatomic, strong) NSString * pARTYIDX;
@property (nonatomic, strong) NSString * pARTYNAME;
@property (nonatomic, strong) NSString * sTOCKDATE;
@property (nonatomic, strong) NSString * sTOCKSTATE;
@property (nonatomic, strong) NSString * sTOCKWORKFLOW;
@property (nonatomic, strong) NSString * sUBMITDATE;
@property (nonatomic, strong) NSString * uSERNAME;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

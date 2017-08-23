//
//  GetOupputModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetOupputModel : NSObject

@property (nonatomic, strong) NSString * aDDRESSCODE;
@property (nonatomic, strong) NSString * aDDRESSIDX;
@property (nonatomic, strong) NSString * aDDRESSINFO;
@property (nonatomic, strong) NSString * aDDRESSNAME;
@property (nonatomic, strong) NSString * aDDDATE;
@property (nonatomic, strong) NSString * aDDUSER;
@property (nonatomic, strong) NSString * aDUTDATE;
@property (nonatomic, strong) NSString * aDUTMARK;
@property (nonatomic, strong) NSString * aDUTUSER;
@property (nonatomic, strong) NSString * bUSINESSIDX;
@property (nonatomic, strong) NSString * eDITDATE;
@property (nonatomic, strong) NSString * eNTIDX;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * iNPUTNO;
@property (nonatomic, strong) NSString * oPERUSER;
@property (nonatomic, strong) NSString * oUTPUTDATE;
@property (nonatomic, strong) NSString * oUTPUTNO;
@property (nonatomic, strong) NSString * oUTPUTQTY;
@property (nonatomic, strong) NSString * oUTPUTSTATE;
@property (nonatomic, strong) NSString * oUTPUTSUM;
@property (nonatomic, strong) NSString * oUTPUTTYPE;
@property (nonatomic, strong) NSString * oUTPUTVOLUME;
@property (nonatomic, strong) NSString * oUTPUTWEIGHT;
@property (nonatomic, strong) NSString * oUTPUTWORKFLOW;
@property (nonatomic, strong) NSString * pARTYCODE;
@property (nonatomic, strong) NSString * pARTYINFO;
@property (nonatomic, strong) NSString * pARTYMARK;
@property (nonatomic, strong) NSString * pARTYNAME;
@property (nonatomic, strong) NSString * pRICE;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@property (assign, nonatomic) CGFloat cellHeight;

@end

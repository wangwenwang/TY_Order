//
//  StoreProductModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreProductModel : NSObject

@property (nonatomic, strong) NSString * bUSINESSIDX;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * pRODUCTBARCODE;
@property (nonatomic, strong) NSString * pRODUCTCLASS;
@property (nonatomic, strong) NSString * pRODUCTDESC;
@property (nonatomic, strong) NSString * pRODUCTNAME;
@property (nonatomic, strong) NSString * pRODUCTNO;
@property (nonatomic, strong) NSArray * pRODUCTPOLICY;
@property (nonatomic, strong) NSString * pRODUCTPRICE;
@property (nonatomic, strong) NSString * pRODUCTTYPE;
@property (nonatomic, strong) NSString * pRODUCTVOLUME;
@property (nonatomic, strong) NSString * pRODUCTWEIGHT;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@property (assign, nonatomic) CGFloat cellHeight;

@end

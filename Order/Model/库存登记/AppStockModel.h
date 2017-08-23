//
//  AppStockModel.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStockModel : NSObject

@property (nonatomic, strong) NSString * aDDDATE;
@property (nonatomic, strong) NSString * aZHUOLING;
@property (nonatomic, strong) NSString * aZTHUOLING;
@property (nonatomic, strong) NSString * dAOQI;
@property (nonatomic, strong) NSString * eDITDATE;
@property (nonatomic, strong) NSString * eNTIDX;
@property (nonatomic, strong) NSString * eXPIRATIONDAY;
@property (nonatomic, strong) NSString * hUOLING;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * pRODUCTIONDATE;
@property (nonatomic, strong) NSString * pRODUCTIDX;
@property (nonatomic, strong) NSString * pRODUCTNAME;
@property (nonatomic, strong) NSString * pRODUCTNO;
@property (nonatomic, strong) NSString * sTOCKDATE;
@property (nonatomic, strong) NSString * sTOCKIDX;
@property (nonatomic, strong) NSString * sTOCKQTY;
@property (nonatomic, strong) NSString * tHUOLING;
@property (nonatomic, strong) NSString * uSERNAME;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;


@property (assign, nonatomic) NSUInteger cellHeight;

@end

//
//  GetOupputItemModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetOupputItemModel : NSObject

@property (nonatomic, strong) NSString * aCTPRICE;
@property (nonatomic, strong) NSString * aDDDATE;
@property (nonatomic, strong) NSString * bATCHNUMBER;
@property (nonatomic, strong) NSString * eDITDATE;
@property (nonatomic, strong) NSString * eNTIDX;
@property (nonatomic, strong) NSString * iDX;
@property (nonatomic, strong) NSString * lINENO;
@property (nonatomic, strong) NSString * mJPRICE;
@property (nonatomic, strong) NSString * mJREMARK;
@property (nonatomic, strong) NSString * oPERUSER;
@property (nonatomic, strong) NSString * oRGPRICE;
@property (nonatomic, strong) NSString * oUTPUTIDX;
@property (nonatomic, strong) NSString * oUTPUTQTY;
@property (nonatomic, strong) NSString * oUTPUTUOM;
@property (nonatomic, strong) NSString * oUTPUTVOLUME;
@property (nonatomic, strong) NSString * oUTPUTWEIGHT;
@property (nonatomic, strong) NSString * pRODUCTIONDATE;
@property (nonatomic, strong) NSString * pRODUCTDESC;
@property (nonatomic, strong) NSString * pRODUCTIDX;
@property (nonatomic, strong) NSString * pRODUCTNAME;
@property (nonatomic, strong) NSString * pRODUCTNO;
@property (nonatomic, strong) NSString * pRODUCTSTATE;
@property (nonatomic, strong) NSString * pRODUCTTYPE;
@property (nonatomic, strong) NSString * pRODUCTVOLUME;
@property (nonatomic, strong) NSString * pRODUCTWEIGHT;
@property (nonatomic, strong) NSString * sALEREMARK;
@property (nonatomic, strong) NSString * sUM;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@property (assign, nonatomic) CGFloat cellHeight;

@end

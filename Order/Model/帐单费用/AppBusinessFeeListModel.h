//
//  AppBusinessFeeListModel.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppBusinessFeeListModel : NSObject

@property (nonatomic, strong) NSString * fEEAMOUNT;
@property (nonatomic, strong) NSString * fEEDATE;
@property (nonatomic, strong) NSString * fEENAME;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@property (assign, nonatomic) CGFloat cellHeight;

@end

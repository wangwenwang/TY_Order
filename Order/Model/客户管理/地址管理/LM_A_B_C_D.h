//
//  LM_A_B_C_D.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalAdressModel.h"

@interface LM_A_B_C_D : NSObject

/// 省
@property (copy, nonatomic) NormalAdressModel *A;

/// 市
@property (copy, nonatomic) NormalAdressModel *B;

/// 区/县
@property (copy, nonatomic) NormalAdressModel *C;

/// 街道/镇
@property (copy, nonatomic) NormalAdressModel *D;

@end

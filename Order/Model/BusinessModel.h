//
//  BusinessModel.h
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessModel : NSObject

/**
 * IDX
 */
@property(copy, nonatomic)NSString *BUSINESS_IDX;

/**
 *
 */
@property(copy, nonatomic)NSString *BUSINESS_CODE;

/**
 * 业务名称
 */
@property(copy, nonatomic)NSString *BUSINESS_NAME;

@end

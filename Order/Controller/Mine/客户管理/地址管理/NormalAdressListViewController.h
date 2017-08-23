//
//  NormalAdressListViewController.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LM_A_B_C_D.h"

@interface NormalAdressListViewController : UIViewController


/// 识别码 A 省， B 市， C 区， D街道
@property (copy, nonatomic) NSString *LM_CODE;


/// 识别码
@property (copy, nonatomic) NSString *strPrentCode;


/// 已选地址
@property (strong, nonatomic) LM_A_B_C_D *lm_a_b_c_d;

@end

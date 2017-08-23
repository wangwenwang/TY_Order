//
//  StockManViewController.h
//  Order
//
//  Created by 凯东源 on 2017/8/17.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "PartyModel.h"

@interface StockManViewController : UIViewController


// 客户信息
@property (strong, nonatomic) PartyModel *partyM;

// 客户地址
@property (strong, nonatomic) AddressModel *addressM;

@end

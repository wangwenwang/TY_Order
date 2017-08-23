//
//  StockOutViewController.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "PartyModel.h"

@interface StockOutViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *payTypes;

@property (strong, nonatomic) NSMutableArray *productTypes;

@property (strong, nonatomic) NSMutableDictionary *dictProducts;

@property (strong, nonatomic) AddressModel *address;

@property (strong, nonatomic) PartyModel *party;

@end

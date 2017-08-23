//
//  SelectGoodsViewController.h
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "PartyModel.h"

@interface SelectGoodsViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *payTypes;

@property (strong, nonatomic) NSMutableArray *productTypes;

@property (strong, nonatomic) NSMutableDictionary *dictProducts;

@property (strong, nonatomic) AddressModel *address;

@property (strong, nonatomic) PartyModel *party;

@end

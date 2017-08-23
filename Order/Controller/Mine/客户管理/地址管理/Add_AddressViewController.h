//
//  Add_AddressViewController.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "PartyModel.h"

@interface Add_AddressViewController : UIViewController


@property (strong, nonatomic) PartyModel *party;

@property (strong, nonatomic) AddressModel *addressM;

@end

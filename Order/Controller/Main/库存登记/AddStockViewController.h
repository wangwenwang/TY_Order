//
//  AddStockViewController.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"
#import "PartyModel.h"

@interface AddStockViewController : SCBaseViewController

@property (strong, nonatomic) PartyModel *partyM;

@property (copy, nonatomic) NSString *PARTY_IDX;

@end

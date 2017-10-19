//
//  OrderDetailViewController.h
//  Order
//
//  Created by 凯东源 on 16/9/30.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "SCBaseViewController.h"

@interface OrderDetailViewController : SCBaseViewController

@property (strong, nonatomic) OrderModel *order;

@property (strong, nonatomic) Class popClass;

@end

//
//  GetAppStockListViewController.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

@interface GetAppStockListViewController : UIViewController


@property (copy, nonatomic) NSString *StockIdx;

@property (strong, nonatomic) StockModel *stockM;

@end

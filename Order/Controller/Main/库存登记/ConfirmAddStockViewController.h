//
//  ConfirmAddStockViewController.h
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLabel.h"
#import "PartyModel.h"

@interface ConfirmAddStockViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *products;

@property (copy, nonatomic) NSString *PARTY_IDX;

// 库存月份
@property (weak, nonatomic) IBOutlet TimeLabel *STOCK_DATE;

// 填表日期
@property (weak, nonatomic) IBOutlet TimeLabel *SUBMIT_DATE;

@property (copy, nonatomic) NSString *STOCK_DATE_text;

@property (copy, nonatomic) NSString *STOCK_DATE_time;

@property (copy, nonatomic) NSString *SUBMIT_DATE_text;

@property (copy, nonatomic) NSString *SUBMIT_DATE_time;

@property (strong, nonatomic) PartyModel *partyM;

@end

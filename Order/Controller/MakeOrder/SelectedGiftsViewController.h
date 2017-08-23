//
//  SelectedGiftsViewController.h
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedGiftsViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *gifts;

@property (strong, nonatomic) NSMutableDictionary *dictPromotionDetails;

/// 品类
@property (strong, nonatomic) NSMutableArray *giftTypes;

@end

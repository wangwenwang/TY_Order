//
//  AddGiftsViewController.h
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGiftsViewController : UIViewController

@property (copy, nonatomic) NSString *partyId;

@property (copy, nonatomic) NSString *addressIdx;

//
@property (assign, nonatomic) int beginLine;

/// 品类
@property (strong, nonatomic) NSMutableArray *giftTypes;

@property (strong, nonatomic) NSMutableDictionary *dictPromotionDetails;

@end

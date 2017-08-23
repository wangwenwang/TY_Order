//
//  ConfirmOrderViewController.h
//  Order
//
//  Created by 凯东源 on 16/10/21.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionOrderModel.h"

@interface ConfirmOrderViewController : UIViewController

@property (strong, nonatomic) PromotionOrderModel *promotionOrder;

/// 已下单的产品(ProductModel)，本地push过来的
@property (strong, nonatomic) NSMutableArray *productsOfLocal;

/// 已下单的产品(PromotionDetailModel)，服务器获取
@property (strong, nonatomic) NSMutableArray *promotionDetailsOfServer;

/// 用户地址代码
@property (copy, nonatomic) NSString *orderAddressCode;

/// 用户地址IDX
@property (copy, nonatomic) NSString *orderAddressIdx;

/// 支付方式
@property (copy, nonatomic) NSString *orderPayType;

/// 用户id
@property (copy, nonatomic) NSString *partyId;

@end

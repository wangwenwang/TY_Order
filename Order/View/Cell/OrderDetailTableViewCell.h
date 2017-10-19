//
//  OrderDetailTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@protocol OrderDetailTableViewCellDelegate <NSObject>

- (void)complete:(CGFloat)quantity andOD_IDX:(NSString *)OD_IDX;

- (void)textFieldShouldBeginEditing:(NSString *)OD_IDX;

@end

@interface OrderDetailTableViewCell : UITableViewCell


@property (strong, nonatomic) OrderDetailModel *orderDetailM;

@property (weak, nonatomic) id<OrderDetailTableViewCellDelegate> delegate;

// 数量输入框
@property (weak, nonatomic) IBOutlet UITextField *quantityF;

@end

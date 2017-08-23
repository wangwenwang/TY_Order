//
//  TransportInformationTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/11.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TransportInformationTableViewCellDelegate <NSObject>

@optional
- (void)checkProcessOnclick:(int)indexRow;

@optional
- (void)checkPathOnclick:(int)indexRow;

@optional
- (void)checkSingatureOnclick:(int)indexRow;

@end

@interface TransportInformationTableViewCell : UITableViewCell

/// 订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

/// 装运时间
@property (weak, nonatomic) IBOutlet UILabel *loadingTimeLabel;

/// 出库时间
@property (weak, nonatomic) IBOutlet UILabel *ckTimeLabel;

/// 装运编号
@property (weak, nonatomic) IBOutlet UILabel *loadingNoLabel;

/// 流程节点
@property (weak, nonatomic) IBOutlet UILabel *processNodeLabel;

/// 司机交付
@property (weak, nonatomic) IBOutlet UILabel *driverLaLabel;

/// 数量
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;

/// 重量
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

/// 体积0m³
@property (weak, nonatomic) IBOutlet UILabel *volLabel;

@property (weak, nonatomic)id <TransportInformationTableViewCellDelegate> delegate;

/// 查看签名按钮
@property (weak, nonatomic) IBOutlet UIButton *checkSignatureButton;

/// 查看签名按钮宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkSignatureWidth;

/// 查看签名按钮离右边距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkSignatureTrailing;

@end

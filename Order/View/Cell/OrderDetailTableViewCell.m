//
//  OrderDetailTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderDetailTableViewCell ()

// 产品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

// 订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

// 数量
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

// 重量
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

// 体积
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

// 原价
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;

// 付款价
@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

// 总价
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

// 产品名称 距下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PRODUCT_NAME_bottom;

@end


@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setOrderDetailM:(OrderDetailModel *)orderDetailM {
    
    _orderDetailM = orderDetailM;
    
    OrderDetailModel *m = _orderDetailM;
    
    double totalPrice = m.ORDER_QTY * m.ACT_PRICE;
    
    NSString *imageURL = [NSString stringWithFormat:@"%@/%@", API_ServerAddress, m.PRODUCT_URL];
    
    _orderNoLabel.text = m.PRODUCT_NO;
    _goodsNameLabel.text = m.PRODUCT_NAME;
    _quantityLabel.text = m.ISSUE_QTY ? [NSString stringWithFormat:@"%.1f箱", m.ISSUE_QTY] : @"";
    _weightLabel.text = [NSString stringWithFormat:@"%@吨", m.ORDER_WEIGHT];
    _volumeLabel.text = [NSString stringWithFormat:@"%@m³", m.ORDER_VOLUME];
    _originalPriceLabel.text = m.ORG_PRICE ? [NSString stringWithFormat:@"￥%.1f", m.ORG_PRICE] : @"￥0.0";
    _payPriceLabel.text = m.ACT_PRICE ? [NSString stringWithFormat:@"￥%.1f", m.ACT_PRICE] : @"￥0.0";
    _totalPriceLabel.text = totalPrice ? [NSString stringWithFormat:@"￥%.1f", totalPrice] : @"￥0.0";
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"ic_information_picture"]];
}

@end

//
//  CheckOrderTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "CheckOrderTableViewCell.h"
#import "Tools.h"
#import "UnAuditedViewController.h"
#import "OrderOneAuditViewController.h"
#import "OrderingViewController.h"
#import "OrderFinishViewController.h"
#import "OrderCancelViewController.h"

@interface CheckOrderTableViewCell ()

/// 订单号
@property (weak, nonatomic) IBOutlet UILabel *orderNOLabel;

/// 创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

/// 订单流程
@property (weak, nonatomic) IBOutlet UILabel *workFlowLabel;

//订单号与左边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderleadX;


@end



@implementation CheckOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setOrder:(OrderModel *)order {
    
    _order = order;
    
    _orderNOLabel.text = order.ORD_NO;
    _createTimeLabel.text = order.ORD_DATE_ADD;
    _locationLabel.text = order.ORD_TO_NAME;
    
    // 读取工作流程
    if(_tableClass == [UnAuditedViewController class] || _tableClass == [OrderOneAuditViewController class]) {
        
            _workFlowLabel.text = [Tools getOrderStatus:order.ORD_WORKFLOW];
    }
    
    // 读取工作状态
    else if(_tableClass == [OrderingViewController class] || _tableClass == [OrderFinishViewController class] || _tableClass == [OrderCancelViewController class]) {
        
        _workFlowLabel.text = [Tools getOrderStatus:order.ORD_STATE];
    }
    
    else {
        
        _workFlowLabel.text = @"未知列表";
    }
}

@end

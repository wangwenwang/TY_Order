//
//  CheckOrderTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "CheckOrderTableViewCell.h"
#import "Tools.h"

@interface CheckOrderTableViewCell ()

/// 订单号
@property (weak, nonatomic) IBOutlet UILabel *orderNOLabel;

/// 创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

/// 订单流程
@property (weak, nonatomic) IBOutlet UILabel *workFlowLabel;

//来计算Label走马灯
@property (weak, nonatomic) IBOutlet UILabel *customerLabel;
//订单号与左边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderleadX;


@end



@implementation CheckOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    _workFlowLabel.text = [Tools getOrderStatus:order.ORD_STATE];
    
    
    [_customerLabel sizeToFit];
    [_locationLabel sizeToFit];
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    //溢出宽度
    CGFloat overflowWidth = CGRectGetWidth(_locationLabel.frame) - (screenWidth - _orderleadX.constant - CGRectGetWidth(_customerLabel.frame) - 5);
    
    
    if(overflowWidth > 0) {
        CGFloat cent = CGRectGetMidX(_locationLabel.frame);
        //如果将12设置成CGRectGetMidY(_locationLabel.frame)有bug，先是8.5，重用之后才12
        CGPoint from = CGPointMake(cent + 2, 12);
        CGPoint to = CGPointMake(cent - overflowWidth, 12);
        
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        moveAnimation.fromValue = [NSValue valueWithCGPoint:from];
        moveAnimation.toValue = [NSValue valueWithCGPoint:to];
        moveAnimation.autoreverses = YES;
        moveAnimation.repeatCount = MAXFLOAT;
        //低于两秒的设置成两秒
        moveAnimation.duration = ((overflowWidth / 8) > 2) ? overflowWidth / 8 : 2;
        
        //开演
        [_locationLabel.layer addAnimation:moveAnimation forKey:@"action"];
        
    } else {
        [_locationLabel.layer removeAllAnimations];
    }
}

@end

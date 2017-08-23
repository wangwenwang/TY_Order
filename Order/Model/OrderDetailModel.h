//
//  OrderDetailModel.h
//  YBDriver
//
//  Created by 凯东源 on 16/9/3.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject
/// 物料编码
@property(copy, nonatomic)NSString *PRODUCT_NO;
/// 物料名称
@property(copy, nonatomic)NSString *PRODUCT_NAME;
@property(assign, nonatomic)double ORDER_QTY;
@property(assign, nonatomic)double ORDER_UOM;
@property(copy, nonatomic)NSString *ORDER_WEIGHT;

@property(copy, nonatomic)NSString *ORDER_VOLUME;
/// 发货数量
@property(assign, nonatomic)double ISSUE_QTY;
@property(copy, nonatomic)NSString *ISSUE_WEIGHT;
@property(copy, nonatomic)NSString *ISSUE_VOLUME;
@property(assign, nonatomic)double PRODUCT_PRICE;

@property(assign, nonatomic)double ACT_PRICE;
@property(copy, nonatomic)NSString *MJ_PRICE;
@property(copy, nonatomic)NSString *MJ_REMARK;
@property(assign, nonatomic)double ORG_PRICE;
@property(copy, nonatomic)NSString *PRODUCT_URL;


@property(copy, nonatomic)NSString *PRODUCT_TYPE;

- (void)setDict:(NSDictionary *)dict;

/// Cell 高度
@property (assign, nonatomic) CGFloat cellHeight;

@end

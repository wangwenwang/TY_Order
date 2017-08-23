//
//  ProductModel.h
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 订单产品信息
 */
@interface ProductModel : NSObject

@property(assign, nonatomic)long long IDX;

@property(copy, nonatomic)NSString *BUSINESS_IDX;

@property(copy, nonatomic)NSString *PRODUCT_NO;

@property(copy, nonatomic)NSString *PRODUCT_NAME;

@property(copy, nonatomic)NSString *PRODUCT_DESC;

@property(copy, nonatomic)NSString *PRODUCT_BARCODE;

@property(copy, nonatomic)NSString *PRODUCT_TYPE;

@property(copy, nonatomic)NSString *PRODUCT_CLASS;

@property(assign, nonatomic)double PRODUCT_PRICE;

@property(copy, nonatomic)NSString *PRODUCT_URL;

@property(assign, nonatomic)double PRODUCT_VOLUME;

@property(assign, nonatomic)double PRODUCT_WEIGHT;

@property(strong, nonatomic)NSMutableArray *PRODUCT_POLICY;

/// 是否考虑库存情况
@property(copy, nonatomic)NSString *ISINVENTORY;

/// 产品库存数目
@property(assign, nonatomic)long long PRODUCT_INVENTORY;

/// 根据用户选择的支付类型设置的产品价格
@property(assign, nonatomic)double PRODUCT_CURRENT_PRICE;

/// 用户下单时选择的数量
@property(assign, nonatomic)long long CHOICED_SIZE;


/************    后期添加，UI操作时使用    ************/
/// 是否点击了模型对应的Cell
@property(assign, nonatomic)BOOL isClickCell;

/// 下单时，已选择的数量
//@property (assign, nonatomic) long selectedProductCount;

- (void)setDict:(NSDictionary *)dict;



/// 生产日期
@property (copy, nonatomic) NSString *PRODUCTION_DATE;

/// 数量
@property (assign, nonatomic) long long STOCK_QTY;

/// Cell 高度
@property (assign, nonatomic) NSUInteger cellHeight;

@end

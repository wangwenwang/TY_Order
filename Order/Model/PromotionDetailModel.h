//
//  PromotionDetailModel.h
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 赠品详情
@interface PromotionDetailModel : NSObject

@property(assign, nonatomic)long long IDX;

@property(assign, nonatomic)long long ENT_IDX;

@property(assign, nonatomic)long long ORDER_IDX;

//NR：正常品  GF：赠品
@property(copy, nonatomic)NSString *PRODUCT_TYPE;

@property(assign, nonatomic)long long PRODUCT_IDX;

@property(copy, nonatomic)NSString *PRODUCT_NO;

@property(copy, nonatomic)NSString *PRODUCT_NAME;

@property(assign, nonatomic)long long LINE_NO;

@property(assign, nonatomic)long long PO_QTY;

@property(copy, nonatomic)NSString *PO_UOM;

@property(assign, nonatomic)double PO_WEIGHT;

@property(assign, nonatomic)double PO_VOLUME;

@property(assign, nonatomic)double ORG_PRICE;

@property(assign, nonatomic)double ACT_PRICE;

//促销备注信息
@property(copy, nonatomic)NSString *SALE_REMARK;

@property(copy, nonatomic)NSString *MJ_REMARK;

@property(assign, nonatomic)double MJ_PRICE;

@property(copy, nonatomic)NSString *LOTTABLE01;

//NR：正常品  GF：赠品
@property(copy, nonatomic)NSString *LOTTABLE02;

@property(copy, nonatomic)NSString *LOTTABLE03;

@property(copy, nonatomic)NSString *LOTTABLE04;

@property(copy, nonatomic)NSString *LOTTABLE05;

/** 此赠品信息是否要可以调价 “Y”考虑 “N”不考虑 */
@property(copy, nonatomic)NSString *LOTTABLE06;

@property(copy, nonatomic)NSString *LOTTABLE07;

@property(copy, nonatomic)NSString *LOTTABLE08;

/** 此赠品信息是否要考虑库存 “Y”考虑 “N”不考虑 */
@property(copy, nonatomic)NSString *LOTTABLE09;

//产品所属的分类名
@property(copy, nonatomic)NSString *LOTTABLE10;

/** 此赠品信息对应的库存 */
@property(assign, nonatomic)long long LOTTABLE11;

/** 此赠品信息调价上限数 */
@property(assign, nonatomic)double LOTTABLE12;

/** 此赠品信息调价下限数 */
@property(assign, nonatomic)double LOTTABLE13;

@property(assign, nonatomic)long long OPERATOR_IDX;

@property(copy, nonatomic)NSString *ADD_DATE;

@property(copy, nonatomic)NSString *EDIT_DATE;

@property(copy, nonatomic)NSString *PRODUCT_URL;

- (void)setDict:(NSDictionary *)dict;

/// Cell的高度
@property (assign, nonatomic) CGFloat cellHeight;

@end

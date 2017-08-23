//
//  SelectGoodsService.h
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SelectGoodsServiceDelegate <NSObject>

/// 请求支付方式成功
@optional
- (void)successOfGetPayTypeData:(NSMutableArray *)payTypes;

/// 请求支付方式失败
@optional
- (void)failureOfGetPayTypeData:(NSString *)msg;


/// 请求产品类型列表成功
@optional
- (void)successOfGetProductTypeData:(NSMutableArray *)productTypes;

/// 请求产品类型列表失败
@optional
- (void)failureOfGetProductTypeData:(NSString *)msg;


/// 请求产品数据列表成功
@optional
- (void)successOfGetProductData:(NSMutableArray *)products;

/// 请求产品数据列表失败
@optional
- (void)failureOfGetProductData:(NSString *)msg;



@end


@interface SelectGoodsService : NSObject

@property (weak, nonatomic)id <SelectGoodsServiceDelegate> delegate;

/**
 * 获取支付类型数据
 *
 * @return 发送请求是否成功
 */
- (void)getPayTypeData;

/**
 * 获取产品类型列表数据
 *
 * @return 发送请求是否成功
 */

- (void)getProductTypesData;


/**
 获取产品数据

 @param orderPartyId    客户id
 @param orderAddressIdx 地址
 @param index           在产品分类列表集合中的位置
 @param productType     产品类型
 @param orderBrand      产品分类
 */
- (void)getProductsData:(NSString *)orderPartyId andOrderAddressIdx:(NSString *)orderAddressIdx andProductTypeIndex:(int)index andProductType:(NSString *)productType andOrderBrand:(NSString *)orderBrand;


@end

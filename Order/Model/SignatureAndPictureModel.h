//
//  SignatureAndPictureModel.h
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 订单签名图片
@interface SignatureAndPictureModel : NSObject

/// 签名图片
@property(copy, nonatomic)NSString *AUTOGRAPH;

/// 现场图片
@property(copy, nonatomic)NSString *PICTURE;

/// 图片的 idx
@property(copy, nonatomic)NSString *IDX;

/// 订单的 idx
@property(copy, nonatomic)NSString *PRODUCT_IDX;

/// 图片的 Url
@property(copy, nonatomic)NSString *PRODUCT_URL;

/**
 * 用于标记是签名还是交货现场图片
 * "Autograph" 客户签名
 * "pricture" 现场图片
 */
@property(copy, nonatomic)NSString *REMARK;

- (void)setDict:(NSDictionary *)dict;

@end

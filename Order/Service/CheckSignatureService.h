//
//  CheckSignatureService.h
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckSignatureServiceDelegate <NSObject>

/// 请求签名图片成功
@optional
- (void)successOfCheckSignature:(NSMutableArray *)signatures;

/// 请求签名图片失败
@optional
- (void)failureOfCheckSignature:(NSString *)msg;

@end


@interface CheckSignatureService : NSObject

@property (weak, nonatomic)id <CheckSignatureServiceDelegate> delegate;

/**
 * 获取签名和交货现场图片数据
 * @param orderIdx 订单编号
 * @return 发送请求是否成功
 */
- (void)getAutographAndPictureData:(NSString *)orderIdx;

@end

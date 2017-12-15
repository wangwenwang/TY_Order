//
//  UpdateRemarkService.h
//  Order
//
//  Created by 凯东源 on 2017/12/15.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 修改备注

@protocol UpdateRemarkServiceDelegate <NSObject>

/// 修改成功
@optional
- (void)successOfUpdateRemark:(NSString *)msg;

/// 修改失败
@optional
- (void)failureOfUpdateRemark:(NSString *)msg;

@end

@interface UpdateRemarkService : NSObject

@property (weak, nonatomic) id<UpdateRemarkServiceDelegate> delegate;


- (void)UpdateRemark:(NSString *)strIdx andstrRemark:(NSString *)strRemark;

@end

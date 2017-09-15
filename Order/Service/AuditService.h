//
//  AuditService.h
//  ZSDOrder
//
//  Created by 凯东源 on 17/4/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuditServiceDelegate <NSObject>

@optional
- (void)successOfAuditPass:(NSString *)msg;

@optional
- (void)failureOfAuditPass:(NSString *)msg;

@optional
- (void)successOfAuditRefuse:(NSString *)msg;

@optional
- (void)failureOfAuditRefuse:(NSString *)msg;

@end

@interface AuditService : NSObject

@property (weak, nonatomic)id <AuditServiceDelegate> delegate;


/**
 审核通过

 @param strOrderIdx 订单id
 @param strUserName 用户名
 */
- (void)UpdateAudit:(NSString *)strOrderIdx andstrUserName:(NSString *)strUserName;


/**
 审核不通过

 @param strOrderIdx 订单id
 @param strUserName 用户名
 */
- (void)RuturnAudit:(NSString *)strOrderIdx andstrUserName:(NSString *)strUserName andstrReason:(NSString *)strReason;

@end

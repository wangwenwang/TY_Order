//
//  OrderConfirmService.m
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderConfirmService.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "PromotionDetailModel.h"
#import "NSString+Trim.h"

@interface OrderConfirmService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation OrderConfirmService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getPromotionData:(NSString *)submitString {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  submitString, @"strOrderInfo",
                  @"", @"strLicense",
                  nil];
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_GET_SUBMIT_ORDER parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求策略成功---%@", responseObject);
        int type = [responseObject[@"type"] intValue];
        
        if(type == 1) {
            NSDictionary *dictResult = responseObject[@"result"];
            
            if([dictResult isKindOfClass:[NSDictionary class]]) {
                
                if([_delegate respondsToSelector:@selector(successOfOrderConfirm:)]) {
                    
                    NSMutableArray *promotionDetails = [[NSMutableArray alloc] init];
                    PromotionOrderModel *m = [[PromotionOrderModel alloc] init];
                    [m setDict:dictResult];
                    
                    //再次确保IDX没错
                    for(int i = 0; i < m.OrderDetails.count; i++) {
                        m.OPERATOR_IDX = [_app.user.IDX longLongValue];
                    }
                    [promotionDetails addObject:m];
                    
                    [_delegate successOfOrderConfirm:m];
                }
            }else {
                
                NSString *msg = responseObject[@"msg"];
                [self failureOfOrderConfirm:msg];
            }
        } else {
            [self failureOfOrderConfirm:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@", error);
        [self failureOfOrderConfirm:nil];
    }];
}

- (void)failureOfOrderConfirm:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfOrderConfirm:)]) {
        [_delegate failureOfOrderConfirm:msg];
    }
}

- (void)confirm:(NSString *)order {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                order, @"strOrderInfo",
                                @"", @"strLicense",
                                nil];
    
    NSLog(@"%@", parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];;
    
    [manager POST:API_CONFIRM_ORDER parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下单成功---%@", responseObject);
        
        int type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        
        if(type == 0) {
                    
            [_delegate successOfOrderConfirmWithCommit];
            
        } else {
            [self failureOfOrderConfirmWithCommit:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@", error);
        [self failureOfOrderConfirmWithCommit:nil];
    }];
}

- (void)failureOfOrderConfirmWithCommit:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfOrderConfirmWithCommit:)]) {
        [_delegate failureOfOrderConfirmWithCommit:msg];
    }
}

- (void)setConfirmData:(NSMutableArray *)returnGiftData andProducts:(NSMutableArray *)choicedProducts andTempTotalQTY:(long long)tempTotalQTY andDate:(NSDate *)date andRemark:(NSString *)remark andPromotionOrder:(PromotionOrderModel *)order andSelectPronotionDetails:(NSMutableArray *)selectPronotionDetails {
    
    //总现价
    double mActPrice = 0;
    for (int i = 0; i < choicedProducts.count; i++) {
        PromotionDetailModel *m = selectPronotionDetails[i];
        mActPrice += m.ACT_PRICE * m.PO_QTY;
    }
    
    //添加赠品
    for (int i = 0; i < returnGiftData.count; i++) {
        PromotionDetailModel *m = returnGiftData[i];
        //如果赠品不存在则添加，防止提交失败，再次提交时重复添加赠品
        if([order.OrderDetails indexOfObject:m] == NSNotFound) {
            [order.OrderDetails addObject:m];
        }
    }
    
    //依据手动配置赠品情况，修改订单中的总原价、总体积、总重量和总数目
    if(returnGiftData.count > 0) {
        double mOrgPrice = 0;
        double mVolume = 0;
        double mWeight = 0;
        long long prQty;
        for (int i = 0; i < returnGiftData.count; i++) {
            PromotionDetailModel *m = returnGiftData[i];
            prQty = m.PO_QTY;
            mOrgPrice += m.ORG_PRICE * prQty;
            mVolume += m.PO_VOLUME * prQty;
            mWeight += m.PO_WEIGHT * prQty;
        }
        order.ORG_PRICE += mOrgPrice;
        order.TOTAL_VOLUME += mVolume;
        order.TOTAL_WEIGHT += mWeight;
    }
    if(tempTotalQTY > order.TOTAL_QTY) {
        order.TOTAL_QTY = tempTotalQTY;
    }
    if(date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.REQUEST_DELIVERY = [formatter stringFromDate:date];
    } else {
        order.REQUEST_DELIVERY = @"1900-01-01T00:00:00";
    }
    order.CONSIGNEE_REMARK = remark;
}

@end

//
//  ChartService.h
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChartServiceDelegate <NSObject>

@optional
- (void)successOfChartServiceWithCustomer:(NSMutableArray *)customerChart;

@optional
- (void)failureOfChartServiceWithCustomer:(NSString *)msg;

@optional
- (void)successOfChartServiceWithProduct:(NSMutableArray *)productChart;

@optional
- (void)failureOfChartServiceWithProduct:(NSString *)msg;

@optional
- (void)failureOfChartService:(NSString *)msg;

@end

@interface ChartService : NSObject

@property (weak, nonatomic)id <ChartServiceDelegate> delegate;


/**
 * * 获取客户报表数据
 *
 * @param url Url
 * @param tag 发送请求是的标记
 * @return 发送请求是否成功
 */
- (void)getChartDataList:(NSString *)url andTag:(NSString *)tag;

@end

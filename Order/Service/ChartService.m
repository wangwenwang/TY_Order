//
//  ChartService.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ChartService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "CustomerChartModel.h"
#import "ProductChartModel.h"

@interface ChartService ()

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation ChartService

- (instancetype)init {
    if (self = [super init]) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)getChartDataList:(NSString *)url andTag:(NSString *)tag {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                _app.user.IDX, @"strUserId",
                                @"", @"strLicense",
                                nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求报表数据成功---%@", responseObject);
        int _type = [responseObject[@"type"] intValue];
        NSString *msg = responseObject[@"msg"];
        if(_type == 1) {
            
            NSArray *arrResult = responseObject[@"result"];
            if([arrResult isKindOfClass:[NSArray class]]) {
                
                if(arrResult.count < 1) {
                    [self failureOfChartService:@"获取报表数据失败!"];
                }else {
                    
                    if([tag isEqualToString:mTagGetCustomerChartDataList]) {
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        for(int i = 0; i < arrResult.count; i++) {
                            CustomerChartModel *m = [[CustomerChartModel alloc] init];
                            [m setDict:arrResult[i]];
                            [array addObject:m];
                        }
                        
                        if([_delegate respondsToSelector:@selector(successOfChartServiceWithCustomer:)]) {
                            [_delegate successOfChartServiceWithCustomer:array];
                        }
                        
                    } else if([tag isEqualToString:mTagGetProductChartDataList]) {
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        for(int i = 0; i < arrResult.count; i++) {
                            ProductChartModel *m = [[ProductChartModel alloc] init];
                            [m setDict:arrResult[i]];
                            [array addObject:m];
                        }
                        if([_delegate respondsToSelector:@selector(successOfChartServiceWithProduct:)]) {
                            
                            [_delegate successOfChartServiceWithProduct:array];
                        }
                    } else {
                        
                        [self failureOfChartService:@"获取报表数据失败!"];
                    }
                }
            }else {
                [self failureOfChartService:msg];
            }
        }else {
            [self failureOfChartService:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求报表数据失败:%@", error);
        [self failureOfChartService:nil];
    }];
}

//- (void)failureOfChartServiceWithCustomer:(NSString *)msg {
//    if([_delegate respondsToSelector:@selector(failureOfChartServiceWithCustomer:)]) {
//        [_delegate failureOfChartServiceWithCustomer:msg];
//    }
//}
//
//- (void)failureOfChartServiceWithProduct:(NSString *)msg {
//    if([_delegate respondsToSelector:@selector(failureOfChartServiceWithProduct:)]) {
//        [_delegate failureOfChartServiceWithProduct:msg];
//    }
//}

- (void)failureOfChartService:(NSString *)msg {
    if([_delegate respondsToSelector:@selector(failureOfChartService:)]) {
        [_delegate failureOfChartService:msg];
    }
}

@end

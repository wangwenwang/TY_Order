//
//  SearchOrderPathViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/30.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SearchOrderPathViewController.h"

@interface SearchOrderPathViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *baiduMapView;

@end

@implementation SearchOrderPathViewController

- (instancetype)init {
    if(self = [super init]) {
        _baiduMapView.zoomLevel = 16;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单轨迹查询";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
    
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _baiduMapView.delegate = self;
    [_baiduMapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s", __func__);
    
     // 不用时，置nil
    _baiduMapView.delegate = nil;
    [_baiduMapView viewWillDisappear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- BMKMapViewDelegate 前台显示
/// 百度地图初始化完成
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //先关闭显示的定位图层
    _baiduMapView.showsUserLocation = NO;
    //设置定位的状态
    _baiduMapView.userTrackingMode = BMKUserTrackingModeNone;
    //显示定位图层
    _baiduMapView.showsUserLocation = YES;
    //设置定位精度
}



@end

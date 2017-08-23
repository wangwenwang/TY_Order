//
//  TransportInformationViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/10.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "TransportInformationViewController.h"
#import "Tools.h"
#import "TransportInformationTableViewCell.h"
#import "OrderModel.h"
#import "OrderTmsDetailsViewController.h"
#import "OrderTmsDetailsService.h"
#import <MBProgressHUD.h>
#import "OrderProgressNodeViewController.h"
#import "CheckSignatureViewController.h"
#import "CheckSignatureService.h"
#import "CheckOrderPathViewController.h"

@interface TransportInformationViewController ()<UITableViewDelegate, UITableViewDataSource, TransportInformationTableViewCellDelegate, OrderTmsDetailsServiceDelegate, CheckSignatureServiceDelegate>

// 顶部视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;

// 客户名称 距下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customerNameLabel_bottom;

// 目的地址
@property (weak, nonatomic) IBOutlet UILabel *toAddressLabel;

// 目的地址 距下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toAddressLabel_bottom;

// 下单总量
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;

// 下单总重
@property (weak, nonatomic) IBOutlet UILabel *orderTotalWeightLabel;

// 下单体积
@property (weak, nonatomic) IBOutlet UILabel *orderVolumeLabel;

// 发货总量
@property (weak, nonatomic) IBOutlet UILabel *sendGoodsTotalLabel;

// 发货重量
@property (weak, nonatomic) IBOutlet UILabel *sendGoodsWeightLabel;

// 发货体积
@property (weak, nonatomic) IBOutlet UILabel *sendGoodsVolumeLabel;

// 原单，拆单
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

// 提示无拆单
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (strong, nonatomic)OrderTmsDetailsService *service;

@property (strong, nonatomic) CheckSignatureService *checkSignatureService;

@end

@implementation TransportInformationViewController

- (instancetype)init {
    if(self = [super init]) {
        _service = [[OrderTmsDetailsService alloc] init];
        _service.delegate = self;
        
        _checkSignatureService = [[CheckSignatureService alloc] init];
        _checkSignatureService.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"物流信息";
    
    //如果没的拆单，则显示无
    _promptLabel.hidden = _tmsInformtions.TmsList.count;
    
//    NSMutableArray *array = _tmsInformtions.TmsList;
//    
//    if(array.count > 0) {
//        OrderModel *or = array[0];
//        for(int i = 0; i < 10; i++) {
//            [array addObject:or];
//        }
//    }
//    _tmsInformtions.TmsList = array;
    
    
    [self fullData];
    
    [self registerCell];
    
    [self addAnimationForLabel];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

//填充数据
- (void)fullData {
    
    _customerNameLabel.text = _tmsInformtions.ORD_TO_NAME;
    _toAddressLabel.text = _tmsInformtions.ORD_TO_ADDRESS;
    _orderTotalLabel.text = [NSString stringWithFormat:@"%.1f件", _tmsInformtions.ORD_QTY];
    _sendGoodsTotalLabel.text = [NSString stringWithFormat:@"%.1f件", _tmsInformtions.TMS_QTY];
    _orderTotalWeightLabel.text = [NSString stringWithFormat:@"%@吨", _tmsInformtions.ORD_WEIGHT];
    _sendGoodsWeightLabel.text = [NSString stringWithFormat:@"%@吨", _tmsInformtions.TMS_WEIGHT];
    _orderVolumeLabel.text = [NSString stringWithFormat:@"%@m³", _tmsInformtions.ORD_VOLUME];
    _sendGoodsVolumeLabel.text = [NSString stringWithFormat:@"%@m³", _tmsInformtions.TMS_VOLUME];
}


- (void)registerCell {
    
    [_myTableView registerNib:[UINib nibWithNibName:@"TransportInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"TransportInformationTableViewCell"];
    _myTableView.separatorStyle = NO;
}


// Label换行
- (void)addAnimationForLabel {
    
    // 客户名称换行
    [_customerNameLabel sizeToFit];
    CGFloat overflowWidth = _customerNameLabel.frame.size.width - (ScreenWidth - (15 + 70));
    if(overflowWidth > 0) {
        
        _customerNameLabel_bottom.constant = 20;
        _headViewHeight.constant += _customerNameLabel_bottom.constant;
    }
    
    // 客户地址换行
    [_toAddressLabel sizeToFit];
    overflowWidth = _toAddressLabel.frame.size.width - (ScreenWidth - (15 + 70));
    if(overflowWidth > 0) {
        
        _toAddressLabel_bottom.constant = 20;
        _headViewHeight.constant += _toAddressLabel_bottom.constant;
    }
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _tmsInformtions.TmsList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //构建界面
    static NSString *cellId = @"TransportInformationTableViewCell";
    TransportInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.delegate = self;
    
    //处理数据
    OrderModel *order = _tmsInformtions.TmsList[indexPath.row];
    
    //填充数据
    cell.orderNoLabel.text = order.ORD_NO;
    cell.loadingTimeLabel.text = order.TMS_DATE_LOAD;
    cell.ckTimeLabel.text = order.TMS_DATE_ISSUE;
    cell.loadingNoLabel.text = order.TMS_SHIPMENT_NO;
    cell.processNodeLabel.text = [Tools getOrderState:order.ORD_WORKFLOW];
    cell.driverLaLabel.text = order.DRIVER_PAY;
    cell.qtyLabel.text = [NSString stringWithFormat:@"%.1f件", order.ORD_ISSUE_QTY];
    cell.weightLabel.text = [NSString stringWithFormat:@"%@吨", order.ORD_ISSUE_WEIGHT];
    cell.volLabel.text = [NSString stringWithFormat:@"%@m³", order.ORD_ISSUE_VOLUME];
    
    //处理是否显示查看签名按钮
    cell.checkSignatureWidth.constant = [[Tools getOrderState:order.ORD_WORKFLOW] isEqualToString:@"已完结"] ? (ScreenWidth - 15 * 4) / 3 : 0;
    cell.checkSignatureTrailing.constant = [[Tools getOrderState:order.ORD_WORKFLOW] isEqualToString:@"已完结"] ? 15 : 0;
    
    //返回Cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self getOrderTmsDetailsData:indexPath.row andPushVc:@"OrderTmsDetailsViewController"];
    
}


- (void)getOrderTmsDetailsData:(NSInteger)indexRow andPushVc:(NSString *)vc {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    OrderModel *m = _tmsInformtions.TmsList[indexRow];
    _service.pushDirection = vc;
    [_service getOrderTmsDetailsData:m.ORD_IDX];
}


#pragma mark - TransportInformationTableViewCellDelegate

//查看进度
- (void)checkProcessOnclick:(int)indexRow {
    
    [self getOrderTmsDetailsData:indexRow andPushVc:@"OrderProgressNodeViewController"];
}


// 查看路线
- (void)checkPathOnclick:(int)indexRow {
    
    OrderModel *m = _tmsInformtions.TmsList[indexRow];
    
    if(m.ORD_IDX.length <= 0) {
        [Tools showAlert:self.view andTitle:@"请重新进入该界面，如果重新进入还是不能正常显示，请联系供应商！"];
    } else {
        
        CheckOrderPathViewController *vc = [[CheckOrderPathViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.orderIDX = m.ORD_IDX;
    }
}


// 查看签名
- (void)checkSingatureOnclick:(int)indexRow {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    OrderModel *m = _tmsInformtions.TmsList[indexRow];
    [_checkSignatureService getAutographAndPictureData:m.ORD_IDX];
}


#pragma mark - OrderTmsDetailsServiceDelegate

- (void)successOfTmsDetails:(OrderModel *)order andPushVc:(NSString *)vcStr {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if([vcStr isEqualToString:@"OrderTmsDetailsViewController"]) {
        OrderTmsDetailsViewController *vc = [[OrderTmsDetailsViewController alloc] init];
        vc.order = order;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([vcStr isEqualToString:@"OrderProgressNodeViewController"]) {
        OrderProgressNodeViewController *vc = [[OrderProgressNodeViewController alloc] init];
        vc.stateTacks = order.StateTacks;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)failureOfTmsDetails:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取物流详情失败"];
}


#pragma mark - CheckSignatureServiceDelegate

- (void)successOfCheckSignature:(NSMutableArray *)signatures {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    CheckSignatureViewController *vc = [[CheckSignatureViewController alloc] init];
    vc.signatures = signatures;
    
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)failureOfCheckSignature:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取签名失败"];
}

@end

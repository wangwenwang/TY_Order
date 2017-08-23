//
//  OrderTmsDetailsViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/11.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderTmsDetailsViewController.h"
#import "OrderTmsDetailsTableViewCell.h"
#import "Tools.h"
#import "OrderDetailModel.h"

@interface OrderTmsDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//scroll内View的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

//头部View的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;

//订单号
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

//装运编号
@property (weak, nonatomic) IBOutlet UILabel *zyNoLabel;

//装运时间
@property (weak, nonatomic) IBOutlet UILabel *zyDateLabel;

//出库时间
@property (weak, nonatomic) IBOutlet UILabel *orderIssueDateLabel;

//承运商名
@property (weak, nonatomic) IBOutlet UILabel *fleetNameLabel;

//车牌号码
@property (weak, nonatomic) IBOutlet UILabel *driverCarNumberLabel;

//司机姓名
@property (weak, nonatomic) IBOutlet UILabel *driverNameLabel;

//司机号码
@property (weak, nonatomic) IBOutlet UILabel *driverPhoneNumLabel;

//下单数量
@property (weak, nonatomic) IBOutlet UILabel *orderQtyLabel;

//订单流程
@property (weak, nonatomic) IBOutlet UILabel *orderFlowLabel;

//下单总重
@property (weak, nonatomic) IBOutlet UILabel *orderWeightLabel;

//订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

//下单体积
@property (weak, nonatomic) IBOutlet UILabel *orderVolLabel;

//付款方式
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;

@end

#define kCellHeight 80

@implementation OrderTmsDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"物流信息详情";
    
    [self registerCell];
    
    [self dealWithData];
    
    [self fullData];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)fullData {
    
    _orderNoLabel.text = _order.ORD_NO;
    _zyNoLabel.text = _order.TMS_SHIPMENT_NO;
    _zyDateLabel.text = _order.TMS_DATE_LOAD;
    _orderIssueDateLabel.text = _order.TMS_DATE_ISSUE;
    _fleetNameLabel.text = _order.TMS_FLEET_NAME;
    _driverCarNumberLabel.text = _order.TMS_PLATE_NUMBER;
    _driverNameLabel.text = _order.TMS_DRIVER_NAME;
    _driverPhoneNumLabel.text = _order.TMS_DRIVER_TEL;
    _orderQtyLabel.text = [NSString stringWithFormat:@"%.1f件", _order.ORD_ISSUE_QTY];
    _orderFlowLabel.text = [Tools getOrderState:_order.ORD_WORKFLOW];
    _orderWeightLabel.text = [NSString stringWithFormat:@"%@吨", _order.ORD_ISSUE_WEIGHT];
    _orderStatusLabel.text = [Tools getOrderStatus:_order.ORD_STATE];
    _orderVolLabel.text = [NSString stringWithFormat:@"%@m³", _order.ORD_ISSUE_VOLUME];
    _payTypeLabel.text = [Tools getOrderStatus:_order.DRIVER_PAY];
}


#pragma mark - 私有方法

- (void)registerCell {
    
    [_myTableView registerNib:[UINib nibWithNibName:@"OrderTmsDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderTmsDetailsTableViewCell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _order.OrderDetails.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailModel *m = _order.OrderDetails[indexPath.row];
    
    return m.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"OrderTmsDetailsTableViewCell";
    OrderTmsDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    OrderDetailModel *m = _order.OrderDetails[indexPath.row];
    cell.productNameLabel.text = m.PRODUCT_NAME;
    cell.productNoLabel.text = m.PRODUCT_NO;
    cell.productQtyLabel.text = [NSString stringWithFormat:@"%.1f箱", m.ISSUE_QTY + m.ORDER_UOM];
    cell.productWeightLabel.text = [NSString stringWithFormat:@"%@吨", m.ISSUE_WEIGHT];
    cell.productVolLabel.text = [NSString stringWithFormat:@"%@m³", m.ISSUE_VOLUME];
    return cell;
}


- (void)dealWithData {
    
    CGFloat tableViewHeight = 0;
    for (OrderDetailModel *m in _order.OrderDetails) {
        
        // Label 容器宽度
        CGFloat contentWidth = ScreenWidth - 2 - 15 - 71.5 + 3 - 3;
        // Label 单行高度
        CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:MAXFLOAT];
        
        CGFloat overflowHeight = [Tools getHeightOfString:m.PRODUCT_NAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
        
        if(overflowHeight > 0) {
            
            m.cellHeight = kCellHeight + overflowHeight;
        } else {
            
            m.cellHeight = kCellHeight;
        }
        tableViewHeight += m.cellHeight;
    }
    
    _scrollContentViewHeight.constant = _headViewHeight.constant + 15 + 19.5 + 15 + tableViewHeight;
}

@end

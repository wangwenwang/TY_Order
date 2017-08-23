//
//  AddStockViewController.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddStockViewController.h"
#import "AddStockTableViewCell.h"
#import "MakeOrderService.h"
#import "SelectGoodsService.h"
#import <MBProgressHUD.h>
#import "AddressModel.h"
#import "Tools.h"
#import "IB_UIButton.h"
#import "ConfirmAddStockViewController.h"
#import "UITableView+NoDataPrompt.h"
#import "LMPickerView.h"


@interface AddStockViewController ()<UITableViewDelegate, UITableViewDataSource, AddStockTableViewCellDelegate, MakeOrderServiceDelegate, SelectGoodsServiceDelegate, LMPickerViewDelegate>


@property (strong, nonatomic)LMPickerView *LM;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *products;

// 服务层

@property (strong, nonatomic) MakeOrderService *service_makeOrder;

@property (strong, nonatomic) SelectGoodsService *service_serviceGoods;

// scrollContentView 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

// 填表日期容器
@property (weak, nonatomic) IBOutlet UIView *SUBMIT_DATE_containerView;

// 确认按钮容器 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmContainerViewHeight;

// 库存月份
@property (weak, nonatomic) IBOutlet TimeLabel *STOCK_DATE;

// 填表日期
@property (weak, nonatomic) IBOutlet TimeLabel *SUBMIT_DATE;

// 生产日期
@property (strong, nonatomic) TimeLabel *PRODUCTION_DATE;

// 时间格式 yyyy-MM
@property (strong, nonatomic) NSDateFormatter *formatter_mm;

// 时间格式 yyyy-MM-dd
@property (strong, nonatomic) NSDateFormatter *formatter_dd;

// 时间格式 yyyy-MM-dd HH:mm:ss
@property (strong, nonatomic) NSDateFormatter *formatter_ss;

// 已选择时间
@property (strong, nonatomic) NSDate *selectedDate;

// 当前时间类型
@property (assign, nonatomic) NSUInteger currentDateType;


// 生产日期 cell_all indexRow
@property (assign, nonatomic) NSUInteger PRODUCTION_DATE_indexRow_in_all;

// 生产日期 cell_paty indexRow
@property (assign, nonatomic) NSUInteger PRODUCTION_DATE_indexRow_in_paty;

/// 库存数量 生产日期 列表 全部
@property (strong, nonatomic) NSMutableArray *products_cell_all;

/// 库存数量 生产日期 列表 产品为单位
//@property (strong, nonatomic) NSMutableArray *products_cell_party;

// tableView 距上
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_top;

// 库存月份距左
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *STOCK_DATE_leading;

// 填表日期 距左
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SUBMIT_DATE_leading;

// 客户类型
@property (weak, nonatomic) IBOutlet UILabel *PARTY_TYPE;

// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

// 客户城市
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CITY;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

// 库存月份 下划线
@property (weak, nonatomic) IBOutlet UIView *STOCK_DATE_line;

@end

#define kCellHeight 155

#define kCellName @"AddStockTableViewCell"

// 时间类型
typedef enum _DateType {
    
    Date_TYPE_STOCK_DATE = 0,         // 库存月份
    Date_TYPE_SUBMIT_DATE,            // 填表日期
    Date_TYPE_PRODUCTION_DATE         // 生产日期
} DateType;

@implementation AddStockViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service_makeOrder = [[MakeOrderService alloc] init];
        _service_makeOrder.delegate = self;
        
        _service_serviceGoods = [[SelectGoodsService alloc] init];
        _service_serviceGoods.delegate = self;
        
        _formatter_mm = [[NSDateFormatter alloc] init];
        [_formatter_mm setDateFormat:@"yyyy-MM"];
        _formatter_dd = [[NSDateFormatter alloc] init];
        [_formatter_dd setDateFormat:@"yyyy-MM-dd"];
        _formatter_ss = [[NSDateFormatter alloc] init];
        [_formatter_ss setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _products_cell_all = [[NSMutableArray alloc] init];
        
        _LM = [[LMPickerView alloc] init];
        _LM.delegate = self;
        [_LM initDatePicker];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"添加库存";
    
    [self registerCell];
    
    [self initUI];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service_makeOrder getPartygetAddressInfo:_partyM.IDX];
    
    [self.view layoutIfNeeded];
    
    // 今天
    NSDate *toDate = [NSDate date];
    
    _STOCK_DATE.text = @"库存月份:";
    _STOCK_DATE.time = @"";
    
    _SUBMIT_DATE.text = [NSString stringWithFormat:@"%@%@", @"填表日期: ", [_formatter_dd stringFromDate:toDate]];
    _SUBMIT_DATE.time = [_formatter_ss stringFromDate:toDate];
    
    // 填表日期宽度  让库存月份和填表日期站位居中靠左
    CGFloat SUBMIT_DATE_width = CGRectGetWidth(_SUBMIT_DATE.frame);
    _STOCK_DATE_leading.constant = (ScreenWidth - SUBMIT_DATE_width) / 2;
    _SUBMIT_DATE_leading.constant = (ScreenWidth - SUBMIT_DATE_width) / 2;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - 手势

// 库存月份
- (IBAction)STOCK_DATE_onclick:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
    
    _currentDateType = Date_TYPE_STOCK_DATE;
    
    NSDate *maxDate = [_formatter_mm dateFromString:[Tools getCurrentBeforeDate_Second:365 * 2 * 24 * 60 * 60]];
    
    NSDate *defaultDate = nil;
    if([_STOCK_DATE.time isEqualToString:@""]) {
        
        NSLog(@"");
        defaultDate = [NSDate date];
    } else {
        
        NSLog(@"");
        defaultDate = [_formatter_mm dateFromString:_STOCK_DATE.time];
    }
    
    NSDate *minDate = [_formatter_mm dateFromString:[Tools getCurrentBeforeDate_Second:-365 * 10 * 24 * 60 * 60]];
    
    
    _selectedDate = defaultDate;
    
    [self createDatePicker:Date_TYPE_STOCK_DATE andDefaultDate:defaultDate andMaxDate:maxDate andMinDate:minDate];
}


// 填表日期
//- (IBAction)SUBMIT_DATE_onclick:(UITapGestureRecognizer *)sender {
//    
//    [self.view endEditing:YES];
//    
//    _currentDateType = Date_TYPE_SUBMIT_DATE;
//    
//    NSDate *maxDate = [_formatter_ss dateFromString:[Tools getCurrentBeforeDate_Second:365 * 24 * 60 * 60]];
//    
//    NSDate *defaultDate = [_formatter_ss dateFromString:_SUBMIT_DATE.time];
//    
//    _selectedDate = defaultDate;
//    
//    [self createDatePicker:Date_TYPE_SUBMIT_DATE andDefaultDate:defaultDate andMaxDate:maxDate andMinDate:[NSDate date]];
//}


#pragma mark - 功能函数

// 注册Cell
- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)initUI {
    
    _PARTY_TYPE.text = _partyM.PARTY_TYPE;
    _PARTY_CODE.text = _partyM.PARTY_CODE;
    _PARTY_CITY.text = _partyM.PARTY_CITY;
    _PARTY_NAME.text = _partyM.PARTY_NAME;
}

#pragma mark - 时间模块

- (void)PickerViewComplete:(NSDate *)date {

    ProductModel *productM = nil;

    switch (_currentDateType) {
        case Date_TYPE_STOCK_DATE:        // 库存月份

            _STOCK_DATE.text = [NSString stringWithFormat:@"%@%@", @"库存月份: ", [_formatter_mm stringFromDate:date]];
            _STOCK_DATE.time = [_formatter_mm stringFromDate:date];
            [_STOCK_DATE_line setHidden:YES];
            break;

        case Date_TYPE_SUBMIT_DATE:       // 填表日期

            _SUBMIT_DATE.text = [NSString stringWithFormat:@"%@%@", @"填表日期: ", [_formatter_dd stringFromDate:date]];
            _SUBMIT_DATE.time = [_formatter_ss stringFromDate:date];
            break;

        case Date_TYPE_PRODUCTION_DATE:   // 生产日期

            productM = _products_cell_all[_PRODUCTION_DATE_indexRow_in_all][_PRODUCTION_DATE_indexRow_in_paty];
            productM.PRODUCTION_DATE = [_formatter_dd stringFromDate:date];
            [_tableView reloadData];
            break;

        default:
            break;
    }
}


- (void)createDatePicker:(NSUInteger)tag andDefaultDate:(NSDate *)defaultDate andMaxDate:(NSDate *)maxDate andMinDate:(NSDate *)minDate {
    
    _LM.date = defaultDate;
    _LM.maximumDate = maxDate;
    _LM.minimumDate = minDate;
    
    if(_currentDateType == Date_TYPE_STOCK_DATE) {
        
        _LM.dateType = @"yyyy-MM";
    } else {
        
        _LM.dateType = @"";
    }
    [_LM showDatePicker];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _products.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductModel *p = _products[indexPath.row];
    return p.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    AddStockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    ProductModel *productM = _products[indexPath.row];
    cell.productM = productM;
    
    cell.products_cell_paty = _products_cell_all[indexPath.row];
    
    return cell;
}


#pragma mark - AddStockTableViewCellDelegate

- (void)PRODUCTION_DATE_onclick:(NSUInteger)index_in_all andIndex_in_paty:(NSUInteger)index_in_paty {
    
    [self.view endEditing:YES];
    
    _PRODUCTION_DATE_indexRow_in_all = index_in_all;
    _PRODUCTION_DATE_indexRow_in_paty = index_in_paty;
    
    _currentDateType = Date_TYPE_PRODUCTION_DATE;
    
    NSDate *maxDate = [_formatter_ss dateFromString:[Tools getCurrentBeforeDate_Second:365 * 24 * 60 * 60]];
    
    NSDate *defaultDate = nil;
    ProductModel *p = _products_cell_all[index_in_all][index_in_paty];
    if([p.PRODUCTION_DATE isEqualToString:@""]) {
        
        NSLog(@"");
        defaultDate = [NSDate date];
    } else {
        
        NSLog(@"");
        defaultDate = [_formatter_dd dateFromString:p.PRODUCTION_DATE];
    }
    
    _selectedDate = defaultDate;
    
    NSDate *minDate = [_formatter_ss dateFromString:[Tools getCurrentBeforeDate_Second:-10 * 365 * 24 * 60 * 60]];
    
    [self createDatePicker:Date_TYPE_PRODUCTION_DATE andDefaultDate:defaultDate andMaxDate:maxDate andMinDate:minDate];
}


#pragma mark - MakeOrderServiceDelegate

// 获取产品数据回调
- (void)successOfGetPartygetAddressInfo:(NSMutableArray *)address {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if(address.count > 0) {
        
        AddressModel *addressM = address[0];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_service_serviceGoods getProductsData:_partyM.IDX andOrderAddressIdx:addressM.IDX andProductTypeIndex:0 andProductType:@"" andOrderBrand:@""];
    } else {
        
        [Tools showAlert:self.view andTitle:@"没有客户地址"];
        return;
    }
}


- (void)successOfGetPartygetAddressInfoNoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tableView noData:@"没有地址哦" andImageName:LM_NoResult_noResult];
}


- (void)failureOfGetPartygetAddressInfo:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)successOfGetProductData:(NSMutableArray *)products {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _products = products;
    
    for (int i = 0; i < _products.count; i++) {
        
        ProductModel *p = _products[i];
        p.cellHeight = kCellHeight;
        
        NSMutableArray *products_cell_party = [[NSMutableArray alloc] init];
        [products_cell_party addObject:p];
        [_products_cell_all addObject:products_cell_party];
    }
    
    CGFloat maxY = CGRectGetMaxY(_SUBMIT_DATE_containerView.frame);
    _scrollContentViewHeight.constant = maxY + _tableView_top.constant + _products.count * kCellHeight + _confirmContainerViewHeight.constant;
    
    
    [_tableView reloadData];
}


- (void)failureOfGetProductData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - 事件

- (IBAction)PreviewOnclick:(IB_UIButton *)sender {
    
    NSMutableArray *products = [[NSMutableArray alloc] init];
    
    // 库存数量为0的去掉
    for (int i = 0; i < _products_cell_all.count; i++) {
        
        NSMutableArray *product_cell_part = _products_cell_all[i];
        for (int j = 0; j < product_cell_part.count; j++) {
            
            ProductModel *p = product_cell_part[j];
            if(p.STOCK_QTY != 0) {
                
                [products addObject:p];
            }
        }
    }
    
    // 没有操作库存数量
    if(products.count == 0) {
        
        [Tools showAlert:self.view andTitle:@"没有操作库存数量哦"];
        return;
    }
    
    // 库存月份必填
    if([_STOCK_DATE.time isEqualToString:@""]) {
        
        [Tools showAlert:self.view andTitle:@"库存月份不能为空哦"];
        return;
    }
    
    // 生产日期不能为空
    for (int i = 0; i < products.count; i++) {
        
        ProductModel *p = products[i];
        if([p.PRODUCTION_DATE isEqualToString:@""]) {
            
            [Tools showAlert:self.view andTitle:@"生产日期不能为空哦"];
            return;
        }
    }
    
    ConfirmAddStockViewController *vc = [[ConfirmAddStockViewController alloc] init];
    vc.PARTY_IDX = _partyM.IDX;
    vc.products = products;
    vc.STOCK_DATE_text = _STOCK_DATE.text;
    vc.STOCK_DATE_time = _STOCK_DATE.time;
    vc.SUBMIT_DATE_text = _SUBMIT_DATE.text;
    vc.SUBMIT_DATE_time = _SUBMIT_DATE.time;
    vc.partyM = _partyM;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)reloadData_LM {
    
    CGFloat cellHeight = 0;
    for (int i = 0; i < _products.count; i++) {
        
        ProductModel *p = _products[i];
        cellHeight += p.cellHeight;
    }
    
    CGFloat maxY = CGRectGetMaxY(_SUBMIT_DATE_containerView.frame);
    _scrollContentViewHeight.constant = maxY + _tableView_top.constant + cellHeight + _confirmContainerViewHeight.constant;
    
    [_tableView reloadData];
}

@end

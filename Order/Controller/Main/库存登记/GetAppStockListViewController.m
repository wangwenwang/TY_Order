//
//  GetAppStockListViewController.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppStockListViewController.h"
#import "GetAppStockListService.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "GetAppStockListTableViewCell.h"
#import "IB_UIButton.h"
#import "CancelStockService.h"

@interface GetAppStockListViewController ()<GetAppStockListServiceDelegate, CancelStockServiceDelegate>

// 业务名
@property (weak, nonatomic) IBOutlet UILabel *BUSINESS_NAME;

// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

// 库存月份
@property (weak, nonatomic) IBOutlet UILabel *STOCK_DATE;

// 填表日期
@property (weak, nonatomic) IBOutlet UILabel *SUBMIT_DATE;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 服务层
@property (strong, nonatomic) GetAppStockListService *service;

// 服务层 取消库存
@property (strong, nonatomic) CancelStockService *service_cancelStock;

@property (strong, nonatomic) AppStockListModel *appStockListM;

// scrollContentView 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

// 头部View 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

// 底部View 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

// 底部View
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

#define kCellHeight 201

#define kCellName @"GetAppStockListTableViewCell"

@implementation GetAppStockListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[GetAppStockListService alloc] init];
        _service.delegate = self;
        _service_cancelStock = [[CancelStockService alloc] init];
        _service_cancelStock.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"库存详情";
    
    // 初始化界面
    [self initUI];
    
    // 注册Cell
    [self registerCell];
    
    // 网络请求
    [_service GetAppStockList:_StockIdx];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - 功能函数

// 注册Cell
- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)initUI {
    
    _BUSINESS_NAME.text = _stockM.bUSINESSNAME;
    _PARTY_CODE.text = _stockM.pARTYCODE;
    _PARTY_NAME.text = _stockM.pARTYNAME;
    _STOCK_DATE.text = _stockM.sTOCKDATE;
    _SUBMIT_DATE.text = _stockM.sUBMITDATE;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _appStockListM.appStockModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppStockModel *appStockM = _appStockListM.appStockModel[indexPath.row];
    
    return appStockM.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    GetAppStockListTableViewCell *cell = (GetAppStockListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    AppStockModel *appStockM = _appStockListM.appStockModel[indexPath.row];
    
    cell.appStockM = appStockM;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - GetAppStockListServiceDelegate

- (void)successOfGetAppStockList:(AppStockListModel *)appStockListM {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _appStockListM = appStockListM;
    
    _BUSINESS_NAME.text = _appStockListM.stockModel.bUSINESSNAME;
    _PARTY_CODE.text = _appStockListM.stockModel.pARTYCODE;
    _PARTY_NAME.text = _appStockListM.stockModel.pARTYNAME;
    _STOCK_DATE.text = _appStockListM.stockModel.sTOCKDATE;
    _SUBMIT_DATE.text = [Tools getDate_yyyy_mm_dd_hh_mm_ss:_appStockListM.stockModel.sUBMITDATE];
    
    
    if([_appStockListM.stockModel.sTOCKSTATE isEqualToString:@"CANCEL"]) {
        
        [_bottomView setHidden:YES];
        _bottomViewHeight.constant = 0;
    }
    
    
    
    CGFloat cellHeight = 0;
    for (int i = 0; i < _appStockListM.appStockModel.count; i++) {
        
        // 产品名称换行
        AppStockModel *a = _appStockListM.appStockModel[i];
        
        // 单行高度
        CGFloat oneLine = [Tools getHeightOfString:@"fds" fontSize:15 andWidth:(ScreenWidth - 8 - 69.5 - 8)];
        
        CGFloat PRODUCT_NAME_height = [Tools getHeightOfString:a.pRODUCTNAME fontSize:15 andWidth:(ScreenWidth - 8 - 69.5 - 8)];
        
        CGFloat oneCellHeight = 0;
        if(PRODUCT_NAME_height > oneLine) {
            
            oneCellHeight = kCellHeight + PRODUCT_NAME_height - oneLine;
        } else {
            
            oneCellHeight = kCellHeight;
        }
        
        cellHeight += oneCellHeight;
        
        a.cellHeight = oneCellHeight;
    }
    
    
    _scrollContentViewHeight.constant = _topViewHeight.constant + cellHeight;
    
    [_tableView reloadData];
}


- (void)successOfGetAppStockListNoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)failureOfGetAppStockList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - 事件

- (IBAction)cancelStockOnclick:(IB_UIButton *)sender {
    
    [_service_cancelStock CancelStock:_StockIdx];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


#pragma mark - CancelStockServiceDelegate

- (void)successOfCancelStock:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetStockListViewController_receiveMsg object:nil userInfo:@{@"msg" : msg}];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)failureOfCancelStock:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}

@end

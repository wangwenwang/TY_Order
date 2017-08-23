//
//  ConfirmAddStockViewController.m
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "ConfirmAddStockViewController.h"
#import "ConfirmAddStockTableViewCell.h"
#import "AddStockService.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "IB_UIButton.h"
#import "AppDelegate.h"
#import "AddStockModel.h"
#import "GetStockListViewController.h"

@interface ConfirmAddStockViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;

// scrollContentView 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

// 填表日期容器
@property (weak, nonatomic) IBOutlet UIView *SUBMIT_DATE_containerView;

// 确认按钮容器 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmContainerViewHeight;

@property (strong, nonatomic) AddStockService *service;

@property (strong, nonatomic) AppDelegate *app;

// tableView 距上
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_top;

// 客户类型
@property (weak, nonatomic) IBOutlet UILabel *PARTY_TYPE;

// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

// 客户城市
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CITY;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

@end


#define kCellHeight 118

#define kCellName @"ConfirmAddStockTableViewCell"


@interface ConfirmAddStockViewController ()<AddStockServiceDelegate>

@end

@implementation ConfirmAddStockViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[AddStockService alloc] init];
        _service.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"确认信息";
    
    [self registerCell];
    
    [self initUI];
    
    _STOCK_DATE.text = _STOCK_DATE_text;
    _STOCK_DATE.time = _STOCK_DATE_time;
    _SUBMIT_DATE.text = _SUBMIT_DATE_text;
    _SUBMIT_DATE.time = _SUBMIT_DATE_time;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
    
    CGFloat maxY = CGRectGetMaxY(_SUBMIT_DATE_containerView.frame);
    _scrollContentViewHeight.constant = maxY + _tableView_top.constant + _products.count * kCellHeight + _confirmContainerViewHeight.constant;
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
    
    _PARTY_TYPE.text = _partyM.PARTY_TYPE;
    _PARTY_CODE.text = _partyM.PARTY_CODE;
    _PARTY_CITY.text = _partyM.PARTY_CITY;
    _PARTY_NAME.text = _partyM.PARTY_NAME;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _products.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    ConfirmAddStockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    ProductModel *productM = _products[indexPath.row];
    cell.productM = productM;
    
    return cell;
}


#pragma mark - 事件

/**
 *  数组转json字符串
 *
 *  数组调用
 *  @return <#return value description#>
 */
- (NSString *)arrayToJsonString :(NSArray *)arr {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (IBAction)ConfirmAddStockOnclick:(IB_UIButton *)sender {
    
    NSString *BUSINESS_IDX = _app.business.BUSINESS_IDX;
    NSString *PARTY_IDX = _PARTY_IDX;
    NSString *STOCK_DATE = _STOCK_DATE_time;
    NSString *SUBMIT_DATE = _SUBMIT_DATE_time;
    NSString *USER_NAME = _app.user.USER_NAME;
    
    
    NSMutableArray *AppStockList = [[NSMutableArray alloc] init];
    for (int i = 0; i < _products.count; i++) {
        
        ProductModel *p = _products[i];
        
        NSDictionary *AppStockListString = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @(p.IDX), @"PRODUCT_IDX",
                                            p.PRODUCT_NO, @"PRODUCT_NO",
                                            p.PRODUCT_NAME, @"PRODUCT_NAME",
                                            p.PRODUCTION_DATE, @"PRODUCTION_DATE",
                                            @(p.STOCK_QTY), @"STOCK_QTY",
                                            nil];
        
        [AppStockList addObject:AppStockListString];
    }
    
    //    NSString *AppStockListString = [self arrayToJsonString:[AppStockList copy]];
    
    
    
    NSDictionary *AppStock = @{@"result" : AppStockList};
    
    NSString *AppStockString = [Tools JsonStringWithDictonary:AppStock];
    
    NSDictionary *reuslt = [NSDictionary dictionaryWithObjectsAndKeys:
                            BUSINESS_IDX , @"BUSINESS_IDX",
                            PARTY_IDX , @"PARTY_IDX",
                            STOCK_DATE , @"STOCK_DATE",
                            SUBMIT_DATE , @"SUBMIT_DATE",
                            USER_NAME , @"USER_NAME",
                            AppStockString , @"AppStock",
                            nil];
    
    NSString *reusltString = [Tools JsonStringWithDictonary:reuslt];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service AddStock:reusltString];
}


#pragma mark - AddStockServiceDelegate

- (void)successOfAddStock:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMainViewController_receiveMsg object:nil userInfo:@{@"msg" : msg}];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
    
//    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
//        
//        UIViewController *vc = self.navigationController.viewControllers[i];
//        NSLog(@"%@", [vc class]);
//        if([vc isKindOfClass:[GetStockListViewController class]]) {
//            
//            
//        }
//    }
}


- (void)failureOfAddStock:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}

@end

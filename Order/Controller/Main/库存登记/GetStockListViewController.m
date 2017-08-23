//
//  GetStockListViewController.m
//  Order
//
//  Created by 凯东源 on 17/6/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetStockListViewController.h"
#import <MBProgressHUD.h>
#import "GetStockListService.h"
#import "Tools.h"
#import "AppDelegate.h"
#import "GetStockListTableViewCell.h"
#import "CustomerListViewController.h"
#import "GetAppStockListViewController.h"
#import "UITableView+NoDataPrompt.h"

@interface GetStockListViewController ()<GetStockListServiceDelegate, UITableViewDelegate, UITableViewDataSource>

// 网络层
@property (strong, nonatomic) GetStockListService *service;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) StockListModel *stockListM;

@end


#define kCellHeight 119

#define kCellName @"GetStockListTableViewCell"

@implementation GetStockListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[GetStockListService alloc] init];
        _service.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"库存登记表";
    
    // 注册Cell
    [self registerCell];
    
    // 注册通知
    [self addNotification];
    
    [Tools addNavRightItemTypeAdd:self andAction:@selector(AddStockOnclick)];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service GetStockList:_app.user.USER_NAME andstrPage:1 andstrPageCount:200 and:_app.user.IDX andstrBusinessId:_app.business.BUSINESS_IDX];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 通知

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:kGetStockListViewController_receiveMsg object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGetStockListViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify{
    
    NSString *msg = aNotify.userInfo[@"msg"];
    [Tools showAlert:self.view andTitle:msg andTime:2.5];
    
    [_service GetStockList:_app.user.USER_NAME andstrPage:1 andstrPageCount:200 and:_app.user.IDX andstrBusinessId:_app.business.BUSINESS_IDX];
}


#pragma mark - 功能函数

// 注册Cell
- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - 事件

- (void)AddStockOnclick {
    
    CustomerListViewController *vc = [[CustomerListViewController alloc] init];
    vc.vcClass = NSStringFromClass([self class]);
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _stockListM.stockModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    GetStockListTableViewCell *cell = (GetStockListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    StockModel *stockM = _stockListM.stockModel[indexPath.row];
    
    cell.stockM = stockM;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StockModel *stockM = _stockListM.stockModel[indexPath.row];
    
    GetAppStockListViewController *vc = [[GetAppStockListViewController alloc] init];
    vc.StockIdx = stockM.iDX;
    vc.stockM = stockM;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - GetStockListServiceDelegate

- (void)successOfGetStockList:(StockListModel *)stockListM {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _stockListM = stockListM;
    
    if(_stockListM.stockModel.count == 0) {
        
        [_tableView noData:@"您还没有库存登记表哦" andImageName:LM_NoResult_noResult];
    }
    [_tableView reloadData];
}


- (void)successOfGetStockListNoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tableView noData:@"您还没有库存登记表哦" andImageName:LM_NoResult_noResult];
}


- (void)failureOfGetStockList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
    [_tableView noData:@"数据异常" andImageName:LM_NoResult_noResult];
}

@end

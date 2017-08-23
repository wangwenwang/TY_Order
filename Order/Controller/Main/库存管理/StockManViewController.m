//
//  StockManViewController.m
//  Order
//
//  Created by 凯东源 on 2017/8/17.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "StockManViewController.h"
#import "GetOupputListViewController.h"
#import "Store_GetOutProductListService.h"
#import "Store_GetOutProductListTableViewCell.h"
#import <MBProgressHUD.h>
#import "UITableView+NoDataPrompt.h"
#import "Tools.h"
#import "GetOupputInfoViewController.h"
#import "StockOutViewController.h"

// 出库
#import "AppDelegate.h"
#import "SelectGoodsService.h"

@interface StockManViewController ()<Store_GetOutProductListServiceDelegate, SelectGoodsServiceDelegate>

// 客户类型
@property (weak, nonatomic) IBOutlet UILabel *PARTY_TYPE;

// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

// 客户城市
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CITY;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

// 联系人名
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_PERSON;

// 地址代码
@property (weak, nonatomic) IBOutlet UILabel *ADDRESS_CODE;

// 地址详情
@property (weak, nonatomic) IBOutlet UILabel *ADDRESS_INFO;

// 产品列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 网络层
@property (strong, nonatomic) Store_GetOutProductListService *service;

// 产品
@property (strong, nonatomic) StoreProductListModel *storeProductListM;

// 内容总高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;


// 出库

// 暂存请求支付方式的回调结果
@property (strong, nonatomic) NSMutableArray *payTypes;

@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) SelectGoodsService *selectGoodsService;

// 暂存请求产品类型的回调结果
@property (strong, nonatomic) NSMutableArray *productTypes;

@end

#define kCellHeight 80

#define kCellName @"Store_GetOutProductListTableViewCell"

@implementation StockManViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[Store_GetOutProductListService alloc] init];
        _service.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        _selectGoodsService = [[SelectGoodsService alloc] init];
        _selectGoodsService.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"库存管理";
    
    [self initUI];
    
    // 注册Cell
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    
    [_service GetOutProductList:[_partyM.IDX integerValue] andstrOutputIdx:0 andstrPartyAddressIdx:[_addressM.IDX integerValue] andstrPage:1 andstrPageCount:20];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - 事件

- (IBAction)didselectItem:(UIButton *)sender {
    
    NSUInteger tag = sender.tag;
    
    if(tag == 1001) {
        
        GetOupputListViewController *vc = [[GetOupputListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(tag == 1004) {
        
        [MBProgressHUD showHUDAddedTo:_app.window animated:YES];
        [_selectGoodsService getPayTypeData];
    }
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
    
    _CONTACT_PERSON.text = _addressM.CONTACT_PERSON;
    _ADDRESS_CODE.text = _addressM.ADDRESS_CODE;
    _ADDRESS_INFO.text = _addressM.ADDRESS_INFO;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _storeProductListM.storeProductModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreProductModel *storeProductM = _storeProductListM.storeProductModel[indexPath.row];

    return storeProductM.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    Store_GetOutProductListTableViewCell *cell = (Store_GetOutProductListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    StoreProductModel *storeProductM = _storeProductListM.storeProductModel[indexPath.row];
    
    cell.storeProductM = storeProductM;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Store_GetOutProductListServiceDelegate

- (void)successOfGetOutProductList:(StoreProductListModel *)storeProductListM {
    
    [MBProgressHUD hideHUDForView:_tableView animated:YES];
    
    _storeProductListM = storeProductListM;
    
    for (StoreProductModel *m in _storeProductListM.storeProductModel) {
        
        m.cellHeight = kCellHeight;
    }
    
    _scrollContentViewHeight.constant = 600 + _storeProductListM.storeProductModel.count * kCellHeight;
    
    [_tableView reloadData];
}


- (void)successOfGetOutProductList_NoData {
    
    [MBProgressHUD hideHUDForView:_tableView animated:YES];
    
    [_tableView noData:@"没有产品数据" andImageName:LM_NoResult_noOrder];
}


- (void)failureOfGetOutProductList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:_tableView animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - SelectGoodsServiceDelegate

// 获取支付类型回调
- (void)successOfGetPayTypeData:(NSMutableArray *)payTypes {
    
    _payTypes = payTypes;
    
    // 关闭上一个菊花
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    // 开启一个新菊花来请求网络，这两个菊花可以打平
    [MBProgressHUD showHUDAddedTo:_app.window animated:YES];
    
    [_selectGoodsService getProductTypesData];
}


- (void)failureOfGetPayTypeData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    [Tools showAlert:_app.window andTitle:msg ? msg : @"获取支付方式失败"];
}


// 获取产品类型回调
- (void)successOfGetProductTypeData:(NSMutableArray *)productTypes {
    
    _productTypes = productTypes;
    
    // 关闭上一个菊花
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    // 开启一个新菊花来请求网络，这两个菊花可以打平
    [MBProgressHUD showHUDAddedTo:_app.window animated:YES];
    
    [_selectGoodsService getProductsData:_partyM.IDX andOrderAddressIdx:_addressM.IDX andProductTypeIndex:0 andProductType:@"" andOrderBrand:@""];
}


- (void)failureOfGetProductTypeData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    [Tools showAlert:_app.window andTitle:msg ? msg : @"获取产品类型失败"];
}


// 获取产品数据回调
- (void)successOfGetProductData:(NSMutableArray *)products {
    
    
    //测试，寻找要考虑库存的产品
    //    for (int i = 0; i < products.count; i++) {
    //        ProductModel *m = products[i];
    //        if([m.ISINVENTORY isEqualToString:@"Y"]) {
    //            NSLog(@"%d, %@, %lld", i, m.PRODUCT_NAME, m.PRODUCT_INVENTORY);
    //        }
    //    }
    
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    
    
//    GetOupputInfoViewController *vc = [[GetOupputInfoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    StockOutViewController *vc = [[StockOutViewController alloc] init];
    vc.payTypes = _payTypes;
    vc.productTypes = _productTypes;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:products forKey:@(0)];
    vc.dictProducts = [NSMutableDictionary dictionaryWithObject:dict forKey:@(0)];
    vc.address = _addressM;
    vc.party = _partyM;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfGetProductData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    [Tools showAlert:_app.window andTitle:msg ? msg : @"获取产品列表失败"];
}

@end

//
//  GetToAddressListViewController.m
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetToAddressListViewController.h"
#import "Store_GetToAddressListService.h"
#import "GetToAddressListTableViewCell.h"
#import "UITableView+NoDataPrompt.h"
#import <MBProgressHUD.h>
#import "Tools.h"

@interface GetToAddressListViewController ()<Store_GetToAddressListServiceDelegate>


// 收货人地址列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 网络层
@property (strong, nonatomic) Store_GetToAddressListService *service;

// 收货人地址
@property (strong, nonatomic) GetToAddressListModel *getToAddressListM;

@end


#define kCellHeight 68

#define kCellName @"GetToAddressListTableViewCell"


@implementation GetToAddressListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[Store_GetToAddressListService alloc] init];
        _service.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"收货信息";
    
    // 注册Cell
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_service GetToAddressList:[_address_idx integerValue]];
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


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _getToAddressListM.getToAddressModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GetToAddressModel *getToAddressListM = _getToAddressListM.getToAddressModel[indexPath.row];
    
    return getToAddressListM.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    GetToAddressListTableViewCell *cell = (GetToAddressListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    GetToAddressModel *getToAddressM = _getToAddressListM.getToAddressModel[indexPath.row];
    
    cell.getToAddressM = getToAddressM;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GetToAddressModel *getToAddressListM = _getToAddressListM.getToAddressModel[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kStockOutViewController_receiveMsg object:nil userInfo:@{@"msg" : getToAddressListM.aDDRESSINFO}];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Store_GetToAddressListService

- (void)successOfGetToAddressList:(GetToAddressListModel *)getToAddressListM {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _getToAddressListM = getToAddressListM;
    
    for (GetToAddressModel *m in _getToAddressListM.getToAddressModel) {
        
        m.cellHeight = kCellHeight;
    }
    
    [_tableView reloadData];
}


- (void)successOfGetToAddressList_NoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tableView noData:@"没有收货人信息哦" andImageName:LM_NoResult_noResult];
}


- (void)failureOfGetToAddressList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tableView noData:msg andImageName:LM_NoResult_noResult];
}

@end

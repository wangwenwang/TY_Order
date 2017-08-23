//
//  GetAppBillFeeListViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBillFeeListViewController.h"
#import "GetAppBillFeeListService.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "GetAppBillFeeListTableViewCell.h"
#import "GetAppBusinessFeeListViewController.h"
#import "UITableView+NoDataPrompt.h"

@interface GetAppBillFeeListViewController ()<GetAppBillFeeListServiceDelegate>

@property (strong, nonatomic) GetAppBillFeeListService *service;

@property (strong, nonatomic) GetAppBillFeeListModel *GetAppBillFeeListM;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

#define kCellHeight 95

#define kCellName @"GetAppBillFeeListTableViewCell"

@implementation GetAppBillFeeListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[GetAppBillFeeListService alloc] init];
        _service.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"帐单列表";
    
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_service GetAppBillFeeList:1 andstrPageCount:200];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - 功能函数

- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _GetAppBillFeeListM.appBillFeeModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = kCellName;
    
    GetAppBillFeeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.appBillFeeM = _GetAppBillFeeListM.appBillFeeModel[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppBillFeeModel *m = _GetAppBillFeeListM.appBillFeeModel[indexPath.row];
    
    GetAppBusinessFeeListViewController *vc = [[GetAppBusinessFeeListViewController alloc] init];
    vc.MONTH_DATE = m.bILLDATE;
    vc.PARTY_IDX = _PARTY_IDX;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - GetAppBillFeeListServiceDelegate

- (void)successOfGetAppBillFeeList:(GetAppBillFeeListModel *)GetAppBillFeeListM {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _GetAppBillFeeListM = GetAppBillFeeListM;
    
    if(_GetAppBillFeeListM.appBillFeeModel.count == 0) {
        
        [_tableView noData:@"暂无帐单" andImageName:LM_NoResult_noResult];
    }
    
    [_tableView reloadData];
}


- (void)failureOfGetAppBillFeeList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_tableView noData:@"请求异常" andImageName:LM_NoResult_noResult];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

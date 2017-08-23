//
//  GetOupputListViewController.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputListViewController.h"
#import "Store_GetOupputListService.h"
#import "GetOupputListModel.h"
#import "GetOupputListTableViewCell.h"
#import <MBProgressHUD.h>
#import "UITableView+NoDataPrompt.h"
#import "Tools.h"
#import "GetOupputInfoViewController.h"

@interface GetOupputListViewController ()<Store_GetOupputListServiceDelegate>


// 出库列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 网络层
@property (strong, nonatomic) Store_GetOupputListService *service;

// 出库
@property (strong, nonatomic) GetOupputListModel *getOupputListM;

@end

#define kCellHeight 72

#define kCellName @"GetOupputListTableViewCell"

@implementation GetOupputListViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[Store_GetOupputListService alloc] init];
        _service.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"出库列表";
    
    // 注册Cell
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service GetOupputList:1 andstrPageCount:20];
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
    
    return _getOupputListM.getOupputModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GetOupputModel *getOupputM = _getOupputListM.getOupputModel[indexPath.row];
    
    return getOupputM.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    GetOupputListTableViewCell *cell = (GetOupputListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
     GetOupputModel *getOupputM = _getOupputListM.getOupputModel[indexPath.row];
    
    cell.getOupputM = getOupputM;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GetOupputModel *m = _getOupputListM.getOupputModel[indexPath.row];
    
    GetOupputInfoViewController *vc = [[GetOupputInfoViewController alloc] init];
    vc.storeIdx = [m.iDX integerValue];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Store_GetOupputListServiceDelegate

- (void)successOfGetOupputList:(GetOupputListModel *)getOupputListM {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _getOupputListM = getOupputListM;
    
    for (GetOupputModel *m in _getOupputListM.getOupputModel) {
        
        m.cellHeight = kCellHeight;
    }
    
    [_tableView reloadData];
}


- (void)successOfGetOupputList_NoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_tableView noData:@"没有数据哦" andImageName:LM_NoResult_noResult];
}


- (void)failureOfGetOupputList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

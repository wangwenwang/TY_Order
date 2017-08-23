//
//  GetPartyListViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/13.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetPartyListViewController.h"
#import "MakeOrderService.h"
#import <MBProgressHUD.h>
#import "PartyModel.h"
#import "Tools.h"
#import "AddStockViewController.h"
#import "CustomerListSearchResultsViewController.h"
//Class GetStockListViewController;
//Class MainViewController;
#import "GetStockListViewController.h"
#import "MainViewController.h"
#import "GetFeeListViewController.h"
#import "GetAppBillFeeListViewController.h"
#import "MineViewController.h"
#import "GetPartyListTableViewCell.h"
#import "DeleteAppUserPartyService.h"
#import "AppDelegate.h"

// 地址管理
#import "AddressListViewController.h"

// 创建客户
#import "AddPartyViewController.h"

@interface GetPartyListViewController ()<MakeOrderServiceDelegate, UISearchResultsUpdating, UISearchControllerDelegate, GetPartyListTableViewCellDelegate, UIActionSheetDelegate, DeleteAppUserPartyServiceDelegate> {
    
    CustomerListSearchResultsViewController *searchResultsViewController;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 客户资料列表 (已搜索过滤)
@property (strong, nonatomic) NSMutableArray *partysFilter;

// 客户资料列表 (原始)
@property (strong, nonatomic) NSMutableArray *partys_org;

// 网络层
@property (strong, nonatomic) MakeOrderService *service;

// 搜索VC
@property (nonatomic, retain) UISearchController *searchController;

// 新建客户
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

// 网络层
@property (strong, nonatomic) DeleteAppUserPartyService *service_delete;

// 全局变量
@property (strong, nonatomic) AppDelegate *app;

// 删除row
@property (assign, nonatomic) NSUInteger deleteRow;

@end

#define kCellHeight 125

#define kCellName @"GetPartyListTableViewCell"

@implementation GetPartyListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[MakeOrderService alloc] init];
        _service.delegate = self;
        
        _partysFilter = [[NSMutableArray alloc] init];
        
        _service_delete = [[DeleteAppUserPartyService alloc] init];
        _service_delete.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"客户列表";
    
    [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -16, 0.0, 0.0)];
    [_addBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -16)];
    
    [self addNotification];
    
    [self registerCell];
    
    //  UISearchController，并且把searchBar置为tableHeaderView
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.definesPresentationContext = YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service getCustomerData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    //    self = nil;
}


- (void)dealloc {
    
    NSLog(@"list dealloc");
    [self removeNotification];
    searchResultsViewController.superVC = nil;
}


#pragma mark - 通知

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:kGetPartyListViewController_receiveMsg object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGetPartyListViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify {
    
    NSString *msg = aNotify.userInfo[@"msg"];
    [Tools showAlert:self.view andTitle:msg andTime:3.5];
    
    [_service getCustomerData];
}


#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
    
    self.navigationController.navigationBar.translucent = YES;
}


- (void)willDismissSearchController:(UISearchController *)searchController {
    
    self.navigationController.navigationBar.translucent = NO;
    //    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - GET方法

/**
 懒加载搜索框控制器
 */
- (UISearchController *)searchController {
    if (!_searchController) {
        
        searchResultsViewController = [[CustomerListSearchResultsViewController alloc] init];
        //        searchResultsViewController.vcClass = _vcClass;
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController];
        searchResultsViewController.superVC = _searchController;
        
        //  接下来都是定义searchBar的样式
        _searchController.searchBar.frame = CGRectMake(0, 0, 0, 40);
        _searchController.searchBar.placeholder = @"客户名称搜索";
        return _searchController;
    }
    return _searchController;
}


/**
 更新
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //  创建一个临时数组，存放搜索到的联系人
    NSMutableArray *tempArray = [NSMutableArray array];
    //  得到searchBar中的text
    NSString *text = searchController.searchBar.text;
    //  遍历源数据中的联系人
    for (PartyModel *party in self.partysFilter) {
        NSString *name = party.PARTY_NAME;
        //  1、text不能为空，第二判断contact是否包括字符串text，是得话，加入到临时数组中
        if ([text length] != 0 && [name rangeOfString:text options:NSCaseInsensitiveSearch].location !=NSNotFound) {
            [tempArray addObject:party];
        }
    }
    
    //  给searchResultsViewController进行传值，并且reloadData
    //    CustomerListSearchResultsViewController *searchResultsViewController = (CustomerListSearchResultsViewController *)searchController.searchResultsController;
    searchResultsViewController.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
    [searchResultsViewController.tableView reloadData];
}



#pragma mark - 功能函数

- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _partysFilter.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = kCellName;
    
    GetPartyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    PartyModel *m = _partysFilter[indexPath.row];
    
    cell.partyM = m;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PartyModel *party = _partysFilter[indexPath.row];
    
    AddressListViewController *vc = [[AddressListViewController alloc] init];
    vc.party = party;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - MakeOrderServiceDelegate

- (void)successOfMakeOrder:(NSMutableArray *)partys {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _partysFilter = partys;
    _partys_org = partys;
    [_tableView reloadData];
}


- (void)failureOfMakeOrder:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - GetPartyListTableViewCellDelegate

- (void)deleteOnclick:(NSUInteger)row {
    
    if(_partys_org.count == 1) {
        
        [Tools showAlert:self.view andTitle:@"不能删除，帐号至少需要一个客户"];
        return;
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否确认删除该客户" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
    sheet.tag = row;
    [sheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld",buttonIndex);
    
    if(buttonIndex == 0) {
        
        PartyModel *m = _partysFilter[actionSheet.tag];
        
        [_service_delete DeleteAppUserParty:_app.user.IDX andstrPartyId:m.IDX];
        
        _deleteRow = actionSheet.tag;
    }
}


- (IBAction)addOnclick {
    
    AddPartyViewController *vc = [[AddPartyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - DeleteAppUserPartyServiceDelegate

- (void)successOfDeleteAppUserParty:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
    
    [_partys_org removeObjectAtIndex:_deleteRow];
    
    [_tableView reloadData];
}


- (void)failureOfDeleteAppUserParty:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

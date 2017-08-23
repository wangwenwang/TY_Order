//
//  AddressListViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/5.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddressListViewController.h"
#import "IB_UIButton.h"
#import "AddressListTableViewCell.h"
#import "Add_AddressViewController.h"
#import "AddressModel.h"
#import "Tools.h"
#import "LM_alert.h"
#import "MakeOrderService.h"
#import <MBProgressHUD.h>
#import "DeleteAddressService.h"
#import "UITableView+NoDataPrompt.h"

@interface AddressListViewController ()<AddressListTableViewCellDelegate, UIActionSheetDelegate, MakeOrderServiceDelegate, DeleteAddressServiceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet IB_UIButton *addBtn;

@property (strong, nonatomic) NSMutableArray *address;

@property (strong, nonatomic) MakeOrderService *service;

@property (strong, nonatomic) DeleteAddressService *service_delete;

@end


#define kCellName @"AddressListTableViewCell"

#define kCellHeight 137


@implementation AddressListViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _address = [[NSMutableArray alloc] init];
        
        _service = [[MakeOrderService alloc] init];
        _service.delegate = self;
        
        _service_delete = [[DeleteAddressService alloc] init];
        _service_delete.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"地址列表";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self requestAddressList];
    
//    [self createData];
    
    [self registerCell];
    
    [self addNotification];
    
    [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -16, 0.0, 0.0)];
    [_addBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -16)];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 通知

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:kAddressListViewController_receiveMsg object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddressListViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify {
    
    NSString *msg = aNotify.userInfo[@"msg"];
    [Tools showAlert:self.view andTitle:msg andTime:2.5];
    
    [self requestAddressList];
}


#pragma mark - 功能函数

- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
}


- (void)requestAddressList {
    
    [_service getPartygetAddressInfo:_party.IDX];
}


// 模拟数据
- (void)createData {
    
    AddressModel *m = [[AddressModel alloc] init];
    m.CONTACT_PERSON = @"王文望";
    m.CONTACT_TEL = @"13726027405";
    m.ADDRESS_REGION = @"广东深圳市龙华新区";
    m.ADDRESS_INFO = @"民治大道嘉熙业广场1033室";
    m.defaultAddress = YES;
    [_address addObject:m];
    
    
    m = [[AddressModel alloc] init];
    m.CONTACT_PERSON = @"张三";
    m.CONTACT_TEL = @"13726027406";
    m.ADDRESS_REGION = @"广东深圳市坪山新区";
    m.ADDRESS_INFO = @"龙岗大道1号";
    [_address addObject:m];
}


#pragma mark - 事件

- (IBAction)addOnclick:(IB_UIButton *)sender {
    
    Add_AddressViewController *vc = [[Add_AddressViewController alloc] init];
    vc.party = _party;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _address.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = kCellName;
    
    AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    cell.addressM = _address[indexPath.row];
    
    return cell;
}


#pragma mark - AddressListTableViewCellDelegate

- (void)editOnclick:(NSUInteger)row {
    
    Add_AddressViewController *vc = [[Add_AddressViewController alloc] init];
    
    vc.addressM = _address[row];
    vc.party = _party;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)defauleAddressOnclick:(NSUInteger)row {
    
    AddressModel *m = _address[row];
    
    for (AddressModel *LM in _address) {
        
        LM.defaultAddress = NO;
    }
    
    m.defaultAddress = YES;
    
    [_tableView reloadData];
}


- (void)deleteOnclick:(NSUInteger)row {
    
    Add_AddressViewController *vc = [[Add_AddressViewController alloc] init];
    
    vc.addressM = _address[row];
    
//    [LM_alert showLMAlertViewWithTitle:@"" message:@"是否确认删除该地址" cancleButtonTitle:@"取消" okButtonTitle:@"删除" okClickHandle:^{
//        
//        NSLog(@"删除%lu", (unsigned long)row);
//    } cancelClickHandle:^{
//        
//        nil;
//    }];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否确认删除该地址" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
    sheet.tag = row;
    [sheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld",buttonIndex);
    
    if(buttonIndex == 0) {
        
        AddressModel *m = _address[actionSheet.tag];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [_service_delete DeleteAddress:m.IDX];
    }
}


#pragma mark - MakeOrderServiceDelegate

- (void)successOfGetPartygetAddressInfo:(NSMutableArray *)address {
    
    _address = address;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_tableView removeNoOrderPrompt];
    
    [_tableView reloadData];
}


- (void)successOfGetPartygetAddressInfoNoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_address removeAllObjects];
    
    [_tableView reloadData];
    [_tableView noData:@"没有地址哦" andImageName:LM_NoResult_noResult];
}


- (void)failureOfGetPartygetAddressInfo:(NSString *)msg {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
    [_tableView noData:@"请求异常" andImageName:LM_NoResult_noResult];
}


#pragma mark - DeleteAddressServiceDelegate

- (void)successOfDeleteAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self requestAddressList];
}


- (void)failureOfDeleteAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

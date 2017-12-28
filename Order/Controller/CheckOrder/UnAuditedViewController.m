//
//  UnAuditedViewController.m
//  Order
//
//  Created by 凯东源 on 2017/9/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "UnAuditedViewController.h"
#import <MJRefresh.h>
#import "Tools.h"
#import "CheckOrderService.h"
#import "OrderModel.h"
#import "CheckOrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "OrderDetailService.h"
#import <MBProgressHUD.h>
#import "UITableView+NoDataPrompt.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import "AuditService.h"


@interface UnAuditedViewController ()<UITableViewDelegate, UITableViewDataSource, CheckOrderServiceDelegate, OrderDetailServiceDelegate, AuditServiceDelegate>

@property (strong, nonatomic)UITableView *myTableView;

/// 未交付订单业务类
@property (strong, nonatomic) CheckOrderService *service;

/// TableView数据
@property (strong, nonatomic) NSMutableArray *orders;

/// 加载第几页
@property (assign, nonatomic) int page;

@property (strong, nonatomic) OrderDetailService *odrDetailService;

@property (strong, nonatomic) AppDelegate *app;

// 不采用宏定义，保持三个类的代码一致
@property (copy, nonatomic) NSString *requestNetworkNotificationName;

@property (weak, nonatomic) UIButton *selectedBtn;

@property (weak, nonatomic) UIButton *deleteBtn;

@property (weak, nonatomic) UIImageView *editView;

@property (strong, nonatomic) NSMutableArray *deleteArr;

@property (strong, nonatomic) NSMutableArray *deleteArrIndexRow;

@property (strong, nonatomic) AuditService *service_audit;

// 批量审核总次数
@property (assign, nonatomic) NSUInteger sumAuditPassCount;

// 批量审核成功次数
@property (assign, nonatomic) NSUInteger successAuditPassCount;

@end

// 请求状态
#define REQUSTSTATUS @"UnAudited"

// 无数据提示
#define kPrompt @"您还没有未审核的订单"

// Cell Name
#define kCellName @"CheckOrderTableViewCell"

// Cell 原始高度
#define kCellHeight 75

@implementation UnAuditedViewController

- (instancetype)init {
    if(self = [super init]) {
        _orders = [[NSMutableArray alloc] init];
        _service = [[CheckOrderService alloc] init];
        _service.delegate = self;
        _odrDetailService = [[OrderDetailService alloc] init];
        _odrDetailService.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _requestNetworkNotificationName = [NSString stringWithFormat:@"k%@RequestNetwork", NSStringFromClass([self class])];
        _deleteArr = [[NSMutableArray alloc] init];
        _deleteArrIndexRow = [[NSMutableArray alloc] init];
        _service_audit = [[AuditService alloc] init];
        _service_audit.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.myTableView];
    
    [_myTableView.mj_header beginRefreshing];
    
    [self addNotification];
    
    if([_app.user.USER_TYPE isEqualToString:kMANAGER] || [_app.user.USER_TYPE isEqualToString:kADMIN]) {
        
        [self addEditView];
    }
}


/*--------------   我们是一个组合   --------------*/
// 框架有bug，viewDidAppear 在 viewWillAppear时执行了
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self viewDidAppear];
}


// 框架有bug，viewDidAppear 在 viewWillAppear时执行了
- (void)scrollViewDidEndDeceleratingMethod {
    
    NSLog(@"scrollViewDidEndDeceleratingMethod");
    [self viewDidAppear];
}


// 框架有bug，viewDidAppear 在 viewWillAppear时执行了
- (void)viewDidAppear {
    
    NSLog(@"viewDidAppear");
    //    _app.currCheckOrderClass = [self class];
    
    if([_app.user.USER_TYPE isEqualToString:kMANAGER] || [_app.user.USER_TYPE isEqualToString:kADMIN]) {
        
        [self addEditItem];
    } else {
        
        NSLog(@"tabBarController");
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
    }
}
/*--------------   我们是一个组合   --------------*/


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self cancelEditCell];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 事件

// 审核通过
- (void)auditPassOnclick:(NSString *)orderIDX {
    
    [_service_audit UpdateAudit:orderIDX andstrUserName:_app.user.USER_NAME];
}


- (void)selectedBtnClick {
    
    [self.deleteArr removeAllObjects];
    
    if (!self.selectedBtn.selected) {
        
        self.selectedBtn.selected = YES;
        
        for (int i = 0; i < _orders.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [_myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
        }
        
        [_deleteArr addObjectsFromArray:_orders];
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)",_deleteArr.count] forState:UIControlStateNormal];
    } else {
        
        self.selectedBtn.selected = NO;
        
        for (int i = 0; i < _orders.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [_myTableView deselectRowAtIndexPath:indexPath animated:NO];
            //            cell.selected = NO;
        }
        
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)",_deleteArr.count] forState:UIControlStateNormal];
    }
}


#pragma mark - 审核按钮

- (void)auditBtnClick {
    if (_myTableView.editing) {
        
        [MBProgressHUD showHUDAddedTo:_app.window animated:YES];
        _sumAuditPassCount = _deleteArr.count;
        _successAuditPassCount = 0;
        for(int i = 0; i < _deleteArr.count; i++) {
            
            OrderModel *m = _deleteArr[i];
            NSLog(@"exec:%@", m.ORD_NO);
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(i * 4);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self auditPassOnclick:m.IDX];
                });
            });
        }
        
        [self cancelEditCell];
    }
}


#pragma mark - 控件GET方法

- (UITableView *)myTableView {
    
    if(!_myTableView) {
        
        _myTableView = [[UITableView alloc] init];
    }
    
    _myTableView.separatorStyle = NO;
    //    _myTableView.allowsMultipleSelectionDuringEditing = YES;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - 64 - CheckOrderViewControllerMenuHeight)];
    
    [self registCell];
    
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataDown)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _myTableView.mj_header = header;
    
    // 上拉分页加载
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataUp)];
    _myTableView.mj_footer.hidden = YES;
    
    return _myTableView;
}


- (void)addEditView {
    
    // 编辑区域
    UIImageView *editView = [[UIImageView alloc]init];
    [self.view addSubview:editView];
    self.editView = editView;
    
    editView.userInteractionEnabled = YES;
    editView.hidden = YES;
    
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@43);
    }];
    self.editView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //    //    全选
    //    UIButton *selectedBtn = [[UIButton alloc] init];
    //    [selectedBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //    [selectedBtn setTitle:@"全选" forState:UIControlStateNormal];
    //    [selectedBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [selectedBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [editView addSubview:selectedBtn];
    //    self.selectedBtn = selectedBtn;
    //    self.selectedBtn.enabled = NO;
    //
    //    [selectedBtn setTitle:@"取消全选" forState:UIControlStateSelected];
    //
    //    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(80, 45));
    //        make.centerY.equalTo(editView);
    //        make.left.equalTo(editView);
    //    }];
    
    //    审核
    UIButton *deleteBtn = [[UIButton alloc] init];
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [deleteBtn setTitle:@"审核(0)" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:TYColor forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"delete_btn"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(auditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 45));
        make.centerY.equalTo(editView);
        make.centerX.equalTo(editView);
    }];
    
    //   上边框
    UIView *topBorder = [[UIView alloc] init];
    topBorder.backgroundColor = RGB(180, 180, 180);
    [editView addSubview:topBorder];
    [topBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
        make.top.equalTo(editView);
        make.left.equalTo(editView);
        make.right.equalTo(editView);
    }];
}


#pragma mark - 功能函数

- (void)registCell {
    
    [_myTableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
}


- (void)loadMoreDataUp {
    
    if([Tools isConnectionAvailable]) {
        
        _page ++;
        [_service getOrderData:REQUSTSTATUS andPage:_page];
    }else {
        
        [Tools showAlert:self.view andTitle:@"网络连接不可用"];
    }
}


- (void)loadMoreDataDown {
    
    if([Tools isConnectionAvailable]) {
        
        _page = 1;
        [_service getOrderData:REQUSTSTATUS andPage:_page];
    }else {
        
        [Tools showAlert:self.view andTitle:@"网络连接不可用"];
    }
}


- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestNetworkData) name:_requestNetworkNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewDidEndDeceleratingMethod) name:kWMPageController_ScrollViewDidEndDecelerating object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_requestNetworkNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWMPageController_ScrollViewDidEndDecelerating object:nil];
}


- (void)addEditItem {
    
    UIBarButtonItem *rigItem = [[UIBarButtonItem alloc] initWithTitle:@"多选" style:UIBarButtonItemStyleDone target:self action:@selector(editCell)];
    self.tabBarController.navigationItem.rightBarButtonItem = rigItem;
}


- (void)addCancelEditItem {
    
    UIBarButtonItem *rigItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEditCell)];
    self.tabBarController.navigationItem.rightBarButtonItem = rigItem;
}


#pragma mark - 网络请求

- (void)requestNetworkData {
    
    [_service getOrderData:REQUSTSTATUS andPage:1];
}


#pragma mark - Notification

- (void)editCell {
    
    [_myTableView setEditing:YES animated:YES];
    [self.editView setHidden:NO];
    
    CGRect rect = _myTableView.frame;
    rect.size.height -= 43;
    _myTableView.frame = rect;
    
    self.selectedBtn.selected = NO;
    
    [self addCancelEditItem];
}


- (void)cancelEditCell {
    
    if(_myTableView.editing == YES) {
        
        [_myTableView setEditing:NO animated:YES];
        [self.editView setHidden:YES];
        [_deleteArr removeAllObjects];
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)", _deleteArr.count] forState:UIControlStateNormal];
        
        CGRect rect = _myTableView.frame;
        rect.size.height += 43;
        _myTableView.frame = rect;
        
        if([_app.user.USER_TYPE isEqualToString:kMANAGER] || [_app.user.USER_TYPE isEqualToString:kADMIN]) {
            
            [self addEditItem];
        }
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _orders.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderModel *m = _orders[indexPath.row];
    return m.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellName forIndexPath:indexPath];
    OrderModel *order = _orders[indexPath.row];
    cell.tableClass = [self class];
    cell.order = order;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderModel *order = _orders[indexPath.row];
    
    // 编辑状态
    if(_myTableView.editing) {
        
        // 已确认才能编辑
        if([order.ORD_WORKFLOW isEqualToString:@"新建"]) {
            
            [self.deleteArr addObject:[_orders objectAtIndex:indexPath.row]];
            [_deleteArrIndexRow addObject:@(indexPath.row)];
            [self.deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)", _deleteArr.count] forState:UIControlStateNormal];
        } else {
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            [Tools showAlert:self.view andTitle:@"此订单未确认"];
        }
    }
    
    // 非编辑状态
    else {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_odrDetailService getOrderDetailsData:order.IDX];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 编辑状态
    if(_myTableView.editing) {
        
        [self.deleteArr removeObject:[_orders objectAtIndex:indexPath.row]];
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)", _deleteArr.count] forState:UIControlStateNormal];
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark - CheckOrderServiceDelegate

- (void)successOfCheckOrder:(NSMutableArray *)orders {
    
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    // 页数处理
    if(_page == 1) {
        
        _orders = orders;
    } else {
        
        for(int i = 0; i < orders.count; i++) {
            
            OrderModel *order = orders[i];
            [_orders addObject:order];
        }
    }
    
    // 是否隐藏上拉
    if(_orders.count > 19) {
        
        _myTableView.mj_footer.hidden = NO;
    } else {
        
        _myTableView.mj_footer.hidden = YES;
    }
    
    // 添加没订单提示
    if(_orders.count == 0) {
        
        [_myTableView noOrder:kPrompt];
    } else {
        
        [_myTableView removeNoOrderPrompt];
    }
    
    // Label 容器宽度
    CGFloat contentWidth = ScreenWidth - 15 - 71.5;
    // Label 单行高度
    CGFloat oneLine = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:MAXFLOAT];
    for(int i = 0; i < _orders.count; i++) {
        
        OrderModel *m = _orders[i];
        CGFloat mulLine = [Tools getHeightOfString:m.ORD_TO_NAME fontSize:14 andWidth:contentWidth];
        m.cellHeight = kCellHeight + (mulLine - oneLine);
    }
    [_myTableView reloadData];
    
    [_deleteArr removeAllObjects];
    
    [_deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)", _deleteArr.count] forState:UIControlStateNormal];
}


- (void)successOfCheckOrderNoData {
    
    [_myTableView.mj_header endRefreshing];
    
    // 添加没订单提示
    if(_page == 1) {
        
        [_myTableView noOrder:kPrompt];
        [_orders removeAllObjects];
    } else {
        
        [_myTableView removeNoOrderPrompt];
        [_myTableView.mj_footer endRefreshingWithNoMoreData];
        [_myTableView.mj_footer setCount_NoMoreData:_orders.count];
    }
    [_deleteArr removeAllObjects];
    [_deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)", _deleteArr.count] forState:UIControlStateNormal];
    [_myTableView reloadData];
}


- (void)failureOfCheckOrder:(NSString *)msg {
    
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    [Tools showAlert:self.view andTitle:msg];
    
    [_deleteArr removeAllObjects];
    [_deleteBtn setTitle:[NSString stringWithFormat:@"审核(%lu)", _deleteArr.count] forState:UIControlStateNormal];
    [_myTableView reloadData];
}


#pragma mark - OrderDetailServiceDelegate

- (void)successOfOrderDetail:(OrderModel *)order {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
    vc.popClass = [self class];
    vc.order = order;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfOrderDetail:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取失败"];
}


#pragma mark - AuditServiceDelegate

- (void)successOfAuditPass:(NSString *)msg {
    
    _successAuditPassCount ++;
    if(_successAuditPassCount == _sumAuditPassCount) {
        
        [MBProgressHUD hideHUDForView:_app.window animated:YES];
    }
    [Tools showAlert:_app.window andTitle:msg];
    
    [_myTableView.mj_header beginRefreshing];
}


- (void)failureOfAuditPass:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    [Tools showAlert:_app.window andTitle:msg];
}

@end

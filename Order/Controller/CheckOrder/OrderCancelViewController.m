//
//  OrderCancelViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderCancelViewController.h"
#import <MJRefresh.h>
#import "Tools.h"
#import "CheckOrderService.h"
#import "OrderModel.h"
#import "CheckOrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "OrderDetailService.h"
#import <MBProgressHUD.h>
#import "UITableView+NoDataPrompt.h"

@interface OrderCancelViewController ()<UITableViewDelegate, UITableViewDataSource, CheckOrderServiceDelegate, OrderDetailServiceDelegate>

@property (strong, nonatomic)UITableView *myTableView;

// TableView数据
@property (strong, nonatomic) NSMutableArray *orders;

// 加载第几页
@property (assign, nonatomic) int page;

// 网络层
@property (strong, nonatomic) OrderDetailService *odrDetailService;

// 网络层 已取消订单列表
@property (strong, nonatomic) CheckOrderService *service;

// 不采用宏定义，保持三个类的代码一致
@property (copy, nonatomic) NSString *requestNetworkNotificationName;

@end


// 请求状态
#define REQUSTSTATUS @"CANCEL"

#define kPrompt @"您还没有已取消的订单"

// Cell Name
#define kCellName @"CheckOrderTableViewCell"

// Cell 原始高度
#define kCellHeight 75


@implementation OrderCancelViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _orders = [[NSMutableArray alloc] init];
        _service = [[CheckOrderService alloc] init];
        _service.delegate = self;
        _odrDetailService = [[OrderDetailService alloc] init];
        _odrDetailService.delegate = self;
        _requestNetworkNotificationName = [NSString stringWithFormat:@"k%@RequestNetwork", NSStringFromClass([self class])];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.myTableView];
    
    [self addNotification];
    
    //延迟0.2秒，防止下拉刷新时出现 右下飘
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        usleep(200000);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_myTableView.mj_header beginRefreshing];
        });
    });
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


/*--------------   我们是一个组合   --------------*/
// 框架有bug，viewDidAppear 在 viewWillAppear时执行了
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self viewDidAppear];
}


// 框架有bug，viewDidAppear 在 viewWillAppear时执行了
- (void)scrollViewDidEndDeceleratingMethod {
    
    [self viewDidAppear];
}


// 框架有bug，viewDidAppear 在 viewWillAppear时执行了
- (void)viewDidAppear {
    
    //    _app.currCheckOrderClass = [self class];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
/*--------------   我们是一个组合   --------------*/


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 控件GET方法

- (UITableView *)myTableView {
    
    if(!_myTableView) {
        
        _myTableView = [[UITableView alloc] init];
    }
    _myTableView.separatorStyle = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - 64 - CheckOrderViewControllerMenuHeight)];
    
    [self registCell];
    
    /// 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataDown)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _myTableView.mj_header = header;
    
    /// 上拉分页加载
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataUp)];
    _myTableView.mj_footer.hidden = YES;
    
    return _myTableView;
}


#pragma mark - 功能函数

- (void)registCell {
    
    [_myTableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
}


- (void)loadMoreDataUp {
    
    if([Tools isConnectionAvailable]) {
        
        _page ++;
        [_service getOrderData:REQUSTSTATUS andPage:_page];
    } else {
        
        [Tools showAlert:self.view andTitle:@"网络连接不可用"];
    }
}


- (void)loadMoreDataDown {
    
    if([Tools isConnectionAvailable]) {
        
        _page = 1;
        [_service getOrderData:REQUSTSTATUS andPage:_page];
    } else {
        
        [Tools showAlert:self.view andTitle:@"网络连接不可用"];
    }
}


- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestNetworkData) name:_requestNetworkNotificationName object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_requestNetworkNotificationName object:nil];
}


#pragma mark - 网络请求

- (void)requestNetworkData {
    
    [_service getOrderData:REQUSTSTATUS andPage:1];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _orders.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderModel *m = _orders[indexPath.row];
    return m.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = kCellName;
    CheckOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    OrderModel *order = _orders[indexPath.row];
    cell.tableClass = [self class];
    cell.order = order;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    OrderModel *order = _orders[indexPath.row];
    [_odrDetailService getOrderDetailsData:order.IDX];
}


#pragma mark - CheckOrderServiceDelegate

- (void)successOfCheckOrder:(NSMutableArray *)orders {
    
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    // 页数处理
    if(_page == 1) {
        
        _orders = orders;
        
        // 添加没订单提示
        if(_orders.count == 0) {
            
            [_myTableView noData:kPrompt andImageName:LM_NoResult_noOrder];
        } else {
            
            [_myTableView removeNoOrderPrompt];
        }
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
    
    // Label 容器宽度
    CGFloat contentWidth = ScreenWidth - 15 - 71.5 + 2;
    // Label 单行高度
    CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:MAXFLOAT];
    for(int i = 0; i < _orders.count; i++) {
        
        OrderModel *m = _orders[i];
        CGFloat overflowHeight = [Tools getHeightOfString:m.ORD_TO_NAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
        m.cellHeight = (overflowHeight > 0) ? (overflowHeight + kCellHeight) : kCellHeight;
    }
    
    [_myTableView reloadData];
}


- (void)successOfCheckOrderNoData {
    
    [_myTableView.mj_header endRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if(_page == 1) { // 没有数据
        
        [_orders removeAllObjects];
        _myTableView.mj_footer.hidden = YES;
        [_myTableView noData:kPrompt andImageName:LM_NoResult_noOrder];
    } else {  // 已加载完毕
        
        [_myTableView.mj_footer endRefreshingWithNoMoreData];
        [_myTableView removeNoOrderPrompt];
        [_myTableView.mj_footer setCount_NoMoreData:_orders.count];
    }
    
    [_myTableView reloadData];
}


- (void)failureOfCheckOrder:(NSString *)msg {
    
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    //tableView上拉无更多数据时会进入这个回调
    if(_page == 1) {
        
        [_myTableView noData:kPrompt andImageName:LM_NoResult_noOrder];
    }
}


#pragma mark - OrderDetailServiceDelegate

- (void)successOfOrderDetail:(OrderModel *)order {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
    vc.order = order;
    vc.popClass = [self class];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfOrderDetail:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取失败"];
}

@end

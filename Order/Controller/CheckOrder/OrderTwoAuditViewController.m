//
//  OrderTwoAuditViewController.m
//  Order
//
//  Created by 凯东源 on 2017/9/13.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "OrderTwoAuditViewController.h"

@interface OrderTwoAuditViewController ()<UITableViewDelegate, UITableViewDataSource, CheckOrderServiceDelegate, OrderDetailServiceDelegate>

@property (strong, nonatomic)UITableView *myTableView;

/// 未交付订单业务类
@property (strong, nonatomic) CheckOrderService *service;

/// TableView数据
@property (strong, nonatomic) NSMutableArray *orders;

/// 加载第几页
@property (assign, nonatomic) int page;

@property (strong, nonatomic) OrderDetailService *odrDetailService;

@property (strong, nonatomic) UIView *noOrderView;

@property (strong, nonatomic) AppDelegate *app;

// 不采用宏定义，保持三个类的代码一致
@property (copy, nonatomic) NSString *requestNetworkNotificationName;

@end

//请求状态
#define REQUSTSTATUS @"Permitted"

// 无数据提示
#define kPrompt @"您还没有已完成的订单"

// Cell Name
#define kCellName @"CheckOrderTableViewCell"

// Cell 原始高度
#define kCellHeight 75

@implementation OrderTwoAuditViewController

- (instancetype)init {
    if(self = [super init]) {
        _orders = [[NSMutableArray alloc] init];
        _service = [[CheckOrderService alloc] init];
        _service.delegate = self;
        _odrDetailService = [[OrderDetailService alloc] init];
        _odrDetailService.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
        
        usleep(250000);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_myTableView.mj_header beginRefreshing];
        });
    });
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


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 网络请求

- (void)requestNetworkData {
    
    [_service getOrderData:REQUSTSTATUS andPage:1];
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
    
    [_myTableView registerNib:[UINib nibWithNibName:@"CheckOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"CheckOrderTableViewCell"];
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    OrderModel *order = _orders[indexPath.row];
    [_odrDetailService getOrderDetailsData:order.IDX];
}


#pragma mark - CheckOrderServiceDelegate

- (void)successOfCheckOrder:(NSMutableArray *)orders {
    
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    //页数处理
    if(_page == 1) {
        
        _orders = orders;
    } else {
        
        for(int i = 0; i < orders.count; i++) {
            
            OrderModel *order = orders[i];
            [_orders addObject:order];
        }
    }
    
    //是否隐藏上拉
    if(_orders.count > 19) {
        
        _myTableView.mj_footer.hidden = NO;
    }else {
        
        _myTableView.mj_footer.hidden = YES;
    }
    
    //添加没订单提示
    if(_orders.count == 0) {
        
        [_myTableView noOrder:kPrompt];
    } else {
        
        [_myTableView removeNoOrderPrompt];
    }
    
    // Label 容器宽度
    CGFloat contentWidth = ScreenWidth - 15 - 72;
    // Label 单行高度
    CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:999.9];
    for(int i = 0; i < _orders.count; i++) {
        
        OrderModel *m = _orders[i];
        CGFloat overflowHeight = [Tools getHeightOfString:m.ORD_TO_NAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
        m.cellHeight = overflowHeight ? (overflowHeight + kCellHeight + 8) : kCellHeight;
    }
    
    [_myTableView reloadData];
}


- (void)successOfCheckOrderNoData {
    
    [_myTableView.mj_header endRefreshing];
    
    //添加没订单提示
    if(_page == 1) {
        
        [_myTableView noOrder:kPrompt];
        [_orders removeAllObjects];
    } else {
        
        [_myTableView removeNoOrderPrompt];
        [_myTableView.mj_footer endRefreshingWithNoMoreData];
        [_myTableView.mj_footer setCount_NoMoreData:_orders.count];
    }
    [_myTableView reloadData];
}


- (void)failureOfCheckOrder:(NSString *)msg {
    
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    [Tools showAlert:self.view andTitle:msg];
    [_myTableView reloadData];
}


#pragma mark - OrderDetailServiceDelegate

- (void)successOfOrderDetail:(OrderModel *)order {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
    vc.order = order;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfOrderDetail:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取失败"];
}

@end

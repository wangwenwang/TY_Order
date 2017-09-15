//
//  MakeOrderViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/27.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "MakeOrderViewController.h"
#import "MakeOrderTableViewCell.h"
#import "MakeOrderService.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "PartyModel.h"
#import "AddressModel.h"
#import "CustomerAddressTableViewCell.h"
#import "NSString+Trim.h"
#import "SelectGoodsViewController.h"
#import "UITableView+NoDataPrompt.h"
#import <Masonry.h>
#import "AppDelegate.h"
#import "UIViewController+LLAdd.h"

// 跳下个页面使用
#import "SelectGoodsService.h"
#import "PayTypeModel.h"

#import "LMBlurredView.h"


/*
 *
 *   本类设计思路：
 *
 *   获取产品类型，成功回调后 --> 获取产品类型成功回调后 --> 获取产品数据成功回调后push下一页
 *
 *
 */
@interface MakeOrderViewController ()<UITableViewDelegate, UITableViewDataSource, MakeOrderServiceDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, SelectGoodsServiceDelegate, LMBlurredViewDelegate>

//客户资料tableView
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//网络请求服务
@property (strong, nonatomic)MakeOrderService *service;

//客户资料列表数据(总的)
@property (strong, nonatomic)NSMutableArray *partys;

//客户资料列表数据(搜索过滤后的)
@property (strong, nonatomic)NSMutableArray *partysFilter;

//客户地址列表数据
@property (strong, nonatomic)NSMutableArray *address;

//遮挡层
@property (weak, nonatomic) IBOutlet UIView *coverView;

//地址View
@property (weak, nonatomic) IBOutlet UIView *addressView;

//地址tableView
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@property (strong, nonatomic) SelectGoodsService *selectGoodsService;

//暂存请求支付方式的回调结果
@property (strong, nonatomic) NSMutableArray *payTypes;

//暂存请求产品类型的回调结果
@property (strong, nonatomic) NSMutableArray *productTypes;

//点击的Cell下标
//@property (assign, nonatomic) int indexRow;

//选择的party
@property (strong, nonatomic) PartyModel *currentParty;

//选择的address
@property (strong, nonatomic) AddressModel *currentAddress;

@property (strong, nonatomic) AppDelegate *app;

// window遮罩
@property (strong, nonatomic) UIView *windowCover;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBar_Top;

//@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) LMBlurredView *blurredView;

@end

#define kSearchBar_Top 20

#define kCellHeight 95.0

#define kAddressCellHeight 72

@implementation MakeOrderViewController

- (instancetype)init {
    if(self = [super init]) {
        self.title = @"下单";
        self.tabBarItem.image = [UIImage imageNamed:@"menu_order_unpay_unselected"];
        
        _service = [[MakeOrderService alloc] init];
        _service.delegate = self;
        
        _partysFilter = [[NSMutableArray alloc] init];
        
        _selectGoodsService = [[SelectGoodsService alloc] init];
        _selectGoodsService.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service getCustomerData];
    
    _coverView.hidden = YES;
    _addressView.hidden = YES;
    
    [self addTap];
    
    [self addTableViewHeadView];
    
    _searchBar.backgroundImage = [UIImage new];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"下单";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self endEditingWithCoverView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)addTableViewHeadView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    
    //    [view addSubview:self.searchBar];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请选择下单客户";
    [label setFont:[UIFont systemFontOfSize:16.0]];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(8));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    _myTableView.tableHeaderView = view;
}


#pragma mark - 功能函数

- (void)registerCell {
    
    [_myTableView registerNib:[UINib nibWithNibName:@"MakeOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MakeOrderTableViewCell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_addressTableView registerNib:[UINib nibWithNibName:@"CustomerAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomerAddressTableViewCell"];
    _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/// 计算Label的Size
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

// 给coverView添加单击手势
- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingWithCoverView)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [_coverView addGestureRecognizer:tap];
}


- (void)topConstant_0 {
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _searchBar_Top.constant = 0;
        
        [self.view layoutIfNeeded];
    }];
}

// 收回键盘
- (void)endEditingWithCoverView {
    
    [self topConstant_0];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view endEditing:YES];
    _coverView.hidden = YES;
    
    [_addressView setHidden:YES];
}


- (void)getPayTypeData {
    
    [MBProgressHUD showHUDAddedTo:_app.window animated:YES];
    [_selectGoodsService getPayTypeData];
}


#pragma mark - 手势

- (void)windowTapOnclick {
    
    [self.view endEditing:YES];
    [_windowCover setHidden:YES];
}


#pragma mark - GET方法

- (UIView *)windowCover {
    
    if(!_windowCover) {
        
        _windowCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _windowCover.backgroundColor = [UIColor blackColor];
        _windowCover.alpha = 0.3;
        //        [_app.window insertSubview:_windowCover belowSubview:_searchBar];
        [_app.window addSubview:_windowCover];
        [_app.window addSubview:_searchBar];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowTapOnclick)];
        tap.numberOfTapsRequired = 1;
        [_windowCover addGestureRecognizer:tap];
    }
    return _windowCover;
}


#pragma mark - 点击事件

- (IBAction)cancelAddressOnclick{
    
    [_blurredView clear];
    
    [self LMBlurredViewClear];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView.tag == 1001) {
        
        return _partysFilter.count;
    } else if(tableView.tag == 1002) {
        
        return _address.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        
        PartyModel *m = _partysFilter[indexPath.row];
        
        return m.cellHeight;
    } else if(tableView.tag == 1002) {
        
        AddressModel *m = _address[indexPath.row];
        
        return m.cellHeight;
    } else {
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        static NSString *cellId = @"MakeOrderTableViewCell";
        MakeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        PartyModel *m = _partysFilter[indexPath.row];
        cell.customerTypeLabel.text = m.PARTY_TYPE;
        cell.customerCodeLabel.text = m.PARTY_CODE;
        cell.customerCityLabel.text = m.PARTY_CITY;
        cell.customerNameLabel.text = m.PARTY_NAME;
        return cell;
        
    } else if(tableView.tag == 1002) {
        static NSString *cellId = @"CustomerAddressTableViewCell";
        CustomerAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        AddressModel *m = _address[indexPath.row];
        
        cell.nameLabel.text = m.CONTACT_PERSON;
        cell.telLabel.text = m.CONTACT_TEL;
        cell.addressCodeLabel.text = m.ADDRESS_CODE;
        cell.addressDetailLabel.text = m.ADDRESS_INFO;
        NSLog(@"%@", [NSValue valueWithCGRect:cell.addressDetailLabel.frame]);
        
        return cell;
        
    } else {
        
        return [[UITableViewCell alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    _indexRow = (int)indexPath.row;
    
    [self.view endEditing:YES];
    
    if(tableView.tag == 1001) {
        
        PartyModel *m = _partysFilter[indexPath.row];
        _currentParty = m;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_service getPartygetAddressInfo:m.IDX];
        
    } else if(tableView.tag == 1002) {
        
        _currentAddress = _address[indexPath.row];
        
        [_blurredView clear];
        [self LMBlurredViewClear];
        
        [self getPayTypeData];
        
    } else {
        
        nil;
    }
    
}


#pragma mark - MakeOrderServiceDelegate

//获取客户资料列表回调
- (void)successOfMakeOrder:(NSMutableArray *)partys {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _partys = partys;
    _partysFilter = [partys mutableCopy];
    
    if(_partys.count == 0) {
        
        [_myTableView noData:@"您还没有客户，赶紧去找小伙伴吧" andImageName:LM_NoResult_noOrder];
    } else {
        
        /*************  客户名称换行  *************/
        
        // tableView 总高度
        for (int i = 0; i < _partysFilter.count; i++) {
            
            PartyModel *m = _partysFilter[i];
            
            
            // Label 容器宽度
            CGFloat contentWidth = ScreenWidth - 15 - 71.5 - 8;
            // Label 单行高度
            CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:999.9];
            
            CGFloat overflowHeight = [Tools getHeightOfString:m.PARTY_NAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
            
            if(overflowHeight > 0) {
                
                m.cellHeight = kCellHeight + overflowHeight;
            } else {
                
                m.cellHeight = kCellHeight;
            }
        }
        /*************  地址信息换行  *************/
        
        [_myTableView reloadData];
    }
}


- (void)failureOfMakeOrder:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_myTableView noData:@"请求失败，请重新加载" andImageName:LM_NoResult_noOrder];
    //    [_myTableView noOrder:@"获取客户资料失败，请重新登录"];
}


// 获取客户地址列表回调
- (void)successOfGetPartygetAddressInfo:(NSMutableArray *)address {
    
    _address = address;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if(address.count > 1) {
        
        CGFloat allCellHeight = 0;
        CGFloat threeCellHeight = 0;
        
        for(int i = 0; i < _address.count; i++) {
            
            AddressModel *m = _address[i];
            
            // Label 容器宽度
            CGFloat contentWidth = ScreenWidth - 8 - 66.5 - 5 - 35 * 2;
            // Label 单行高度
            CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:13 andWidth:999.9];
            
            // 地址详情的Label高度，根据文字计算出来
            CGFloat overflowHeight = [Tools getHeightOfString:m.ADDRESS_INFO fontSize:13 andWidth:contentWidth] - oneLineHeight;
            
            if(overflowHeight > 0) {
                
                m.cellHeight = kAddressCellHeight + overflowHeight;
            } else {
                
                m.cellHeight = kAddressCellHeight;
            }
            
            // 计算3个Cell的高度，方便给地址容器使用
            if(i < 3) {
                
                threeCellHeight += m.cellHeight;
            }
            allCellHeight += m.cellHeight;
        }
        
        // 虚化背景
        LMBlurredView *blurredView = [[LMBlurredView alloc] init];
        blurredView.delegate = self;
        [blurredView blurry:5.1];
        _blurredView = blurredView;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = @"请选择下单客户地址";
        CGFloat labelHeight = [Tools getHeightOfString:label.text fontSize:label.font.pointSize andWidth:MAXFLOAT];
        CGFloat label_top = 5;
        CGFloat tableView_top = 5;
        CGFloat btn_top = 20;
        CGFloat btn_height = 35;
        CGFloat btn_bottom = 10;
        
        // 地址容器
        UIView *view = [[UIView alloc] init];
        view.tag = 1089;
        view.layer.cornerRadius = 2.0f;
        view.backgroundColor = RGB(239, 239, 244);
        [_app.window addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            
            CGFloat viewHeight = (allCellHeight + label_top + labelHeight + tableView_top + btn_top + btn_height + btn_bottom);
            if(_address.count <= 3) {
                
                make.height.mas_equalTo(viewHeight);
            } else {
                
                make.height.mas_equalTo(threeCellHeight + kCellHeight / 2);
            }
        }];
        
        // 提示Label
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_top);
            make.left.mas_equalTo(8);
        }];
        
        // 取消按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2.0f;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        btn.backgroundColor = TYColor;
        [btn addTarget:self action:@selector(cancelAddressOnclick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(btn_height);
            make.bottom.mas_equalTo(-btn_bottom);
        }];
        
        // tableView
        UITableView *tableView = [[UITableView alloc] init];
        tableView.layer.cornerRadius = 2.0f;
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerNib:[UINib nibWithNibName:@"CustomerAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomerAddressTableViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 1002;
        [view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom).offset(tableView_top);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(btn.mas_top).offset(-btn_top);
        }];
        
        [tableView reloadData];
    } else if(_address.count == 1) {
        
        _currentAddress = _address[0];
        
        [self getPayTypeData];
    } else {
        
        [Tools showAlert:self.view andTitle:@"没有可用地址"];
    }
}


- (void)successOfGetPartygetAddressInfoNoData {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:@"无地址"];
}


- (void)failureOfGetPartygetAddressInfo:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取客户地址失败"];
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
    
    [_selectGoodsService getProductsData:_currentParty.IDX andOrderAddressIdx:_currentAddress.IDX andProductTypeIndex:0 andProductType:@"" andOrderBrand:@""];
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
    
    SelectGoodsViewController *vc = [[SelectGoodsViewController alloc] init];
    vc.payTypes = _payTypes;
    vc.productTypes = _productTypes;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:products forKey:@(0)];
    vc.dictProducts = [NSMutableDictionary dictionaryWithObject:dict forKey:@(0)];
    vc.address = _currentAddress;
    vc.party = _currentParty;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfGetProductData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:_app.window animated:YES];
    
    [Tools showAlert:_app.window andTitle:msg ? msg : @"获取产品列表失败"];
}


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSLog(@"textDidChange : %@", searchText);
    [_partysFilter removeAllObjects];
    
    if([[searchText trim] isEqualToString:@""]) {
        
        _partysFilter = [_partys mutableCopy];
    } else {
        
        for (int i = 0; i < _partys.count; i++) {
            
            PartyModel *m = _partys[i];
            if([m.PARTY_NAME rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0) {
                
                [_partysFilter addObject:m];
            } else {
                
            }
        }
    }
    [_myTableView reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    _searchBar_Top.constant = kSearchBar_Top;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    _coverView.hidden = NO;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self topConstant_0];
    [searchBar resignFirstResponder];
    _coverView.hidden = YES;
}


#pragma mark - LMBlurredViewDelegate

- (void)LMBlurredViewClear {
    
    for (UIView *view in _app.window.subviews) {
        
        if(view.tag == 1089) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                view.alpha = 0;
            } completion:^(BOOL finished) {
                
                [view removeFromSuperview];
            }];
        }
    }
}

@end

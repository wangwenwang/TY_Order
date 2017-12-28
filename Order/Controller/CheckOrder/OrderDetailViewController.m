//
//  OrderDetailViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/30.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "Tools.h"
#import "OrderDetailTableViewCell.h"
#import "TransportInformationViewController.h"
#import "TransportInformationService.h"
#import <MBProgressHUD.h>
#import "OrderCancelService.h"
#import "AppDelegate.h"
#import "LM_alert.h"
#import "UnAuditedViewController.h"
#import "AuditService.h"
#import "OrderOneAuditViewController.h"
#import "OrderingViewController.h"
#import "LMBlurredView.h"
#import <Masonry.h>
#import "SetProductQtyService.h"
#import "OrderDetailService.h"
#import "UpdateRemarkService.h"
#import "OrderCancelViewController.h"


@interface NumberButton : UIButton
@property (copy, nonatomic) NSString *OD_IDX;
@end

@implementation NumberButton
@end


@interface OrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource, TransportInformationServiceDelegate, OrderCancelServiceDelegate, AuditServiceDelegate, OrderDetailTableViewCellDelegate, LMBlurredViewDelegate, SetProductQtyServiceDelegate, OrderDetailServiceDelegate, UpdateRemarkServiceDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

// 订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

// 订单创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

// 订单客户名称
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;

//订单客户地址
@property (weak, nonatomic) IBOutlet UILabel *customerAddressLabel;

// 订单客户地址 距下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customerAddressLabel_bottom;

// 订单起始地址
@property (weak, nonatomic) IBOutlet UILabel *beginAddressLabel;

// 下单数量
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

// 订单总重
@property (weak, nonatomic) IBOutlet UILabel *orderTotalWeigthLabel;

// 订单体积
@property (weak, nonatomic) IBOutlet UILabel *orderVolumeLabel;

// 订单流程
@property (weak, nonatomic) IBOutlet UILabel *orderProcessLabel;

// 订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

// 付款方式
@property (weak, nonatomic) IBOutlet UILabel *payMethodLabel;

// 货物信息
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

// ScrollView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

// 头部View高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;

// 货物信息TableView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderTableViewHeight;

// 赠品TableView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftsTableViewHeight;

// 尾部View高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tailViewHeight;

// 货物信息
@property (strong, nonatomic) NSMutableArray *arrGoods;

// 提示无赠品
@property (weak, nonatomic) IBOutlet UILabel *giftsPromptLabel;

// 赠品TableView
@property (weak, nonatomic) IBOutlet UITableView *giftTableView;

// 赠品
@property (strong, nonatomic) NSMutableArray *arrGitfs;

// 现价
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;

// 满减
@property (weak, nonatomic) IBOutlet UILabel *OnSaleLabel;

// 付款价
@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

// 部门
@property (weak, nonatomic) IBOutlet UILabel *OL_REFERENCE01;

// 备注
@property (weak, nonatomic) IBOutlet UILabel *reMarkLabel;

// 获取物流信息
@property (strong, nonatomic) TransportInformationService *transortService;

// 底部按钮视图
@property (weak, nonatomic) IBOutlet UIView *bottomView;

// 底部按钮视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@property (strong, nonatomic) OrderCancelService *service;

@property (strong, nonatomic) AppDelegate *app;

// 审核通过按钮
@property (strong, nonatomic) UIButton *auditPassBtn;

// 取消订单按钮
@property (strong, nonatomic) UIButton *cancelOrderBtn;

// 审核网络层
@property (strong, nonatomic) AuditService *service_audit;

// 虚化背景
@property (strong, nonatomic) LMBlurredView *blurredView;

// 输入产品数量
@property (strong, nonatomic) UIView *enterNumView;

// 输入产品数量视图 距下
@property (nonatomic, strong) MASConstraint *enterNumView_bottom;

// 键盘高度
@property (assign, nonatomic) CGFloat keyboardHeight;

// 修改产品数量
@property (strong, nonatomic) UITextField *customsizeProductNumberF;

// 修改备注信息
@property (strong, nonatomic) UITextView *CONSIGNEE_REMARK;

@property (weak, nonatomic) IBOutlet UIButton *updateMarkBtn;

@property (strong, nonatomic) OrderDetailService *odrDetailService;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkLabel_trailing;

// 发运方式
@property (weak, nonatomic) IBOutlet UILabel *REFERENCE02;

@end


#define kCellHeight 100.0

#define kBlue RGB(0, 129, 238)

#define kPassGree RGB(0, 163, 0)

#define kPassHeight 32

/**
 
 * 枚举类型命名规则：命名时使用驼峰命名法，勿使用下划线命名法
 */
typedef NS_ENUM(NSUInteger, ConfirmformType){
    /**
     * 备注
     */
    KDYConfirmformTypeRemark = 1,
    /**
     * 审核退回
     */
    KDYConfirmformTypeAudit = 2,
};


@implementation OrderDetailViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _arrGoods = [[NSMutableArray alloc] init];
        _arrGitfs = [[NSMutableArray alloc] init];
        _transortService = [[TransportInformationService alloc] init];
        _transortService.delegate = self;
        _service = [[OrderCancelService alloc] init];
        _service.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _service_audit = [[AuditService alloc] init];
        _service_audit.delegate = self;
        _odrDetailService = [[OrderDetailService alloc] init];
        _odrDetailService.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self dealWithData];
    
    [self initUI];
    
    [self fullData];
    
    [self registerCell];
    
    [self addAnimationForLabel];
}


- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
}


- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    // 赠品Table高度
    CGFloat allHeight = 0;
    if(_arrGitfs.count > 0) {
        
        for (OrderDetailModel *m in _arrGitfs) {
            
            allHeight += m.cellHeight;
        }
        _giftsTableViewHeight.constant = allHeight;
    } else {
        
        // 如果没有赠品，留30的高度给Label （提示无赠品）
        _giftsTableViewHeight.constant = 30;
    }
    
    // 产品高度
    allHeight = 0;
    for (OrderDetailModel *m in _arrGoods) {
        
        allHeight += m.cellHeight;
    }
    _orderTableViewHeight.constant = allHeight;
    
    // 未审核订单可以修改备注
    if(_popClass == [UnAuditedViewController class]) {
        
    } else {
        
        [_updateMarkBtn setHidden:YES];
        _remarkLabel_trailing.constant = - 57;
    }
    
    // 总高度
    _scrollViewHeight.constant = _headViewHeight.constant + 40 + _orderTableViewHeight.constant + 50 + _giftsTableViewHeight.constant + _tailViewHeight.constant;
}


#pragma mark - 功能函数

// 初始化UI
- (void)initUI {
    
    // 底部按钮视图
    // 审核权限 经理或管理员
    if([_app.user.USER_TYPE isEqualToString:kMANAGER] || [_app.user.USER_TYPE isEqualToString:kADMIN]) {
        
        // 未审核列表进来
        if(_popClass == [UnAuditedViewController class]) {
            
            UIButton *pass = [[UIButton alloc] init];
            UIButton *cancel = [[UIButton alloc] init];
            [_bottomView addSubview:pass];
            [_bottomView addSubview:cancel];
            _auditPassBtn = pass;
            _cancelOrderBtn = cancel;
            
            pass.layer.cornerRadius = 2.0f;
            pass.backgroundColor = kPassGree;
            [pass setTitle:@"审核通过" forState:UIControlStateNormal];
            [pass.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [pass addTarget:self action:@selector(auditPassOnclick) forControlEvents:UIControlEventTouchUpInside];
            [pass mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(25);
                make.right.mas_equalTo(cancel.mas_left).offset(-25);
                make.width.mas_equalTo(cancel.mas_width);
                make.centerY.offset(0);
                make.height.mas_equalTo(kPassHeight);
            }];
            
            cancel.layer.cornerRadius = 2.0f;
            cancel.backgroundColor = [UIColor redColor];
            [cancel setTitle:@"取消订单" forState:UIControlStateNormal];
            [cancel.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [cancel addTarget:self action:@selector(cancelOrderOnclick) forControlEvents:UIControlEventTouchUpInside];
            [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-25);
                make.centerY.offset(0);
                make.height.mas_equalTo(pass.mas_height);
            }];
        } else if(_popClass == [OrderOneAuditViewController class]) {
            
            UIButton *pass = [[UIButton alloc] init];
            UIButton *refuse = [[UIButton alloc] init];
            [_bottomView addSubview:pass];
            [_bottomView addSubview:refuse];
            _auditPassBtn = pass;
            _cancelOrderBtn = refuse;
            
            pass.layer.cornerRadius = 2.0f;
            pass.backgroundColor = kPassGree;
            [pass setTitle:@"审核通过" forState:UIControlStateNormal];
            [pass.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [pass addTarget:self action:@selector(auditPassOnclick) forControlEvents:UIControlEventTouchUpInside];
            [pass mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(25);
                make.right.mas_equalTo(refuse.mas_left).offset(-25);
                make.width.mas_equalTo(refuse.mas_width);
                make.centerY.offset(0);
                make.height.mas_equalTo(kPassHeight);
            }];
            
            refuse.layer.cornerRadius = 2.0f;
            refuse.backgroundColor = [UIColor redColor];
            [refuse setTitle:@"审核退回" forState:UIControlStateNormal];
            [refuse.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [refuse addTarget:self action:@selector(auditRefuseOnclick) forControlEvents:UIControlEventTouchUpInside];
            [refuse mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-25);
                make.centerY.offset(0);
                make.height.mas_equalTo(pass.mas_height);
            }];
        } else if(_popClass == [OrderCancelViewController class]) {
            
            _bottomViewHeight.constant = YES;
        } else {
            
            [self showWL];
        }
    } else {
        
        if(_popClass == [UnAuditedViewController class]) {
            
            UIButton *showWL = [[UIButton alloc] init];
            [_bottomView addSubview:showWL];
            
            showWL.layer.cornerRadius = 2.0f;
            showWL.backgroundColor = [UIColor redColor];
            [showWL setTitle:@"取消订单" forState:UIControlStateNormal];
            [showWL.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [showWL addTarget:self action:@selector(cancelOrderOnclick) forControlEvents:UIControlEventTouchUpInside];
            [showWL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(129);
                make.height.mas_equalTo(kPassHeight);
                make.centerX.offset(0);
                make.centerY.offset(0);
            }];
        } else if(_popClass == [OrderOneAuditViewController class] || _popClass == [OrderCancelViewController class]) {
            
            _bottomViewHeight.constant = YES;
        } else {
            
            [self showWL];
        }
    }
}


// 只显示物流按钮
- (void)showWL {
    
    UIButton *showWL = [[UIButton alloc] init];
    [_bottomView addSubview:showWL];
    
    showWL.layer.cornerRadius = 2.0f;
    showWL.backgroundColor = kBlue;
    [showWL setTitle:@"查看物流信息" forState:UIControlStateNormal];
    [showWL.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [showWL addTarget:self action:@selector(checkTransportinfoOnclick) forControlEvents:UIControlEventTouchUpInside];
    [showWL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(129);
        make.height.mas_equalTo(kPassHeight);
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
}


// 处理数据
- (void)dealWithData {
    
    [_arrGoods removeAllObjects];
    for(int i = 0; i < _order.OrderDetails.count; i++) {
        
        OrderDetailModel *m = _order.OrderDetails[i];
        
        if([m.PRODUCT_TYPE isEqualToString:@"NR"]) {
            
            [_arrGoods addObject:m];
        } else if([m.PRODUCT_TYPE isEqualToString:@"GF"]) {
            
            [_arrGitfs addObject:m];
        }
    }

    if(_arrGitfs.count > 0) {
        
        _giftTableView.hidden = NO;
        _giftsPromptLabel.hidden = YES;
    } else {
        
        _giftTableView.hidden = NO;
        _giftsPromptLabel.hidden = NO;
    }
    
    // Cell高度
    for(int i = 0; i < _order.OrderDetails.count; i++) {
        
        OrderDetailModel *m = _order.OrderDetails[i];
        
        CGFloat contentWidth = ScreenWidth - 4 - 6 - 60 - 60 - 2 - 3 - 4;
        
        // Label 单行高度
        CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:13 andWidth:999.9];
        
        CGFloat overflowHeight = [Tools getHeightOfString:m.PRODUCT_NAME fontSize:13 andWidth:contentWidth] - oneLineHeight;
        
        if(overflowHeight > 0) {
            
            m.cellHeight = kCellHeight + overflowHeight;
        } else {
            
            m.cellHeight = kCellHeight;
        }
    }
}


// 填充数据
- (void)fullData {
    _orderNoLabel.text = _order.ORD_NO;
    _createTimeLabel.text = _order.ORD_DATE_ADD;
    _customerNameLabel.text = _order.ORD_TO_NAME;
    _customerAddressLabel.text = _order.ORD_TO_ADDRESS;
    _beginAddressLabel.text = _order.ORD_FROM_NAME;
    _orderNumberLabel.text = [NSString stringWithFormat:@"%@箱", [Tools formatFloat:_order.ORD_QTY]];
    _orderTotalWeigthLabel.text = [NSString stringWithFormat:@"%@吨", _order.ORD_WEIGHT];
    _orderVolumeLabel.text = [NSString stringWithFormat:@"%@m³", _order.ORD_VOLUME];
    _orderProcessLabel.text = _order.ORD_WORKFLOW;
    _orderStatusLabel.text = [Tools getOrderStatus:_order.ORD_STATE];
    _payMethodLabel.text = [Tools getPaymentType:_order.PAYMENT_TYPE];
    _nowPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _order.ACT_PRICE];
    
    if(_order.MJ_REMARK == nil || [_order.MJ_REMARK isEqualToString:@""] || [_order.MJ_REMARK isEqualToString:@"+|+"]) {
        _OnSaleLabel.text = @"无";
        _payPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _order.ACT_PRICE];
    }else {
        _OnSaleLabel.text = [NSString stringWithFormat:@"满减总计 - ￥%.f", _order.MJ_PRICE];
        _payPriceLabel.text = [NSString stringWithFormat:@"￥%.f", _order.ACT_PRICE - _order.MJ_PRICE];
    }
    
    _reMarkLabel.text = _order.ORD_REMARK_CONSIGNEE;
    _OL_REFERENCE01.text = _order.OL_REFERENCE01;
    _REFERENCE02.text = _order.REFERENCE02;
}


// 注册Cell
- (void)registerCell {
    
    [_orderTableView registerNib:[UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailTableViewCell"];
    _orderTableView.separatorStyle = NO;
    
    [_giftTableView registerNib:[UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailTableViewCell"];
    _giftTableView.separatorStyle = NO;
}


// Label换行
- (void)addAnimationForLabel {
    
    // 客户名称换行
    [_customerNameLabel sizeToFit];
    CGFloat oneLine = [Tools getHeightOfString:@"fds" fontSize:_customerNameLabel.font.pointSize andWidth:MAXFLOAT];
    CGFloat mulLine = [Tools getHeightOfString:_customerNameLabel.text fontSize:_customerNameLabel.font.pointSize andWidth:(ScreenWidth - 15 - 66.5 - 3)];
    _headViewHeight.constant += (mulLine - oneLine);
    
    // 客户地址换行
    mulLine = [Tools getHeightOfString:_customerAddressLabel.text fontSize:_customerAddressLabel.font.pointSize andWidth:(ScreenWidth - 15 - 66.5 - 3)];
    _headViewHeight.constant += (mulLine - oneLine);
    
    // 备注信息换行
    mulLine = [Tools getHeightOfString:_reMarkLabel.text fontSize:_reMarkLabel.font.pointSize andWidth:(ScreenWidth - 15 - 71.5 - 3)];
    mulLine = mulLine ? mulLine : oneLine;  // 备注可能为空
    _tailViewHeight.constant += (mulLine - oneLine);
    
    [self updateViewConstraints];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView.tag == 1001) {
        
        return _arrGoods.count;
    } else if(tableView.tag == 1002) {
        
        return _arrGitfs.count;
    } else {
        
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellID = @"OrderDetailTableViewCell";
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    
    // 处理数据
    OrderDetailModel *m = nil;
    if(tableView.tag == 1001) {
        
        m = _arrGoods[indexPath.row];
    } else if(tableView.tag == 1002) {
        
        m = _arrGitfs[indexPath.row];
    }
    
    
    // 修改数量 经理或管理员
    if((_popClass == [UnAuditedViewController class] && ([_app.user.USER_TYPE isEqualToString:kMANAGER] || [_app.user.USER_TYPE isEqualToString:kADMIN]))) {
        
        // 显示修改数量
    } else {
        
        // 不显示修改数量
        [cell.quantityF setHidden:YES];
    }
    
    
    // 填充数据
    cell.orderDetailM = m;
    
    // 返回Cell
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理数据
    OrderDetailModel *m = nil;
    if(tableView.tag == 1001) {
        
        m = _arrGoods[indexPath.row];
    } else if(tableView.tag == 1002) {
        
        m = _arrGitfs[indexPath.row];
    }
    return m.cellHeight;
}


#pragma mark - 事件

- (void)checkTransportinfoOnclick {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_transortService getTransInformationData:_order.IDX];
}


// 审核通过
- (void)auditPassOnclick {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service_audit UpdateAudit:_order.IDX andstrUserName:_app.user.USER_NAME];
}


// 审核打回
- (void)auditRefuseOnclick {
    
    [self addTextView:@"不通过理由" andType:KDYConfirmformTypeAudit];
}


// 取消订单
- (void)cancelOrderOnclick {
    
    [LM_alert showLMAlertViewWithTitle:@"" message:@"确认取消此订单？" cancleButtonTitle:@"我再想想" okButtonTitle:@"确认" okClickHandle:^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_service OrderCancel:_order.IDX andstrUserIdx:_app.user.IDX];
    } cancelClickHandle:nil];
}


// 修改备注信息
- (IBAction)updateMarkOnclick {
    
    [self addTextView:@"修改备注信息" andType:KDYConfirmformTypeRemark];
    _CONSIGNEE_REMARK.text = _order.ORD_REMARK_CONSIGNEE;
}

#pragma mark - TransportInformationServiceDelegate

- (void)successOfTransportInformation:(OrderTmsModel *)product {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    TransportInformationViewController *vc = [[TransportInformationViewController alloc] init];
    vc.tmsInformtions = product;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfTransportInformation:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取信息失败"];
}


#pragma mark - AuditServiceDelegate

- (void)successOfAuditPass:(NSString *)msg {
    
    [self successOfAudit:msg];
}


- (void)failureOfAuditPass:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}


- (void)successOfAuditRefuse:(NSString *)msg {
    
    [self successOfAudit:msg];
}


- (void)failureOfAuditRefuse:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}


- (void)successOfAudit:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
    _auditPassBtn.enabled = NO;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *UnAudited = [NSString stringWithFormat:@"k%@RequestNetwork", [UnAuditedViewController class]];
        NSString *OrderOneAudit = [NSString stringWithFormat:@"k%@RequestNetwork", [OrderOneAuditViewController class]];
        NSString *Ordering = [NSString stringWithFormat:@"k%@RequestNetwork", [OrderingViewController class]];
        
        // 审核成功后 刷新TableView
        [[NSNotificationCenter defaultCenter] postNotificationName:UnAudited object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:OrderOneAudit object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:Ordering object:nil];
        
        usleep(1700000);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}


#pragma mark - OrderDetailTableViewCellDelegate

- (void)textFieldShouldBeginEditing:(NSString *)OD_IDX {
    
    [self addEnterNumView:OD_IDX];
}


- (void)addEnterNumView:(NSString *)OD_IDX {
    
    _blurredView = [[LMBlurredView alloc] init];
    _blurredView.delegate = self;
    [_blurredView blurry:5.1];
    
    // 输入数量
    _enterNumView = [[UIView alloc] init];
    _enterNumView.layer.cornerRadius = 2.0f;
    _enterNumView.backgroundColor = [UIColor whiteColor];
    UIView *window = self.view.window;
    [window addSubview:_enterNumView];
    [_enterNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(160);
        _enterNumView_bottom = make.bottom.mas_equalTo(-((ScreenHeight / 2) - (160 / 2)));
        make.centerX.offset(0);
    }];
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请输入产品数量";
    [_enterNumView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.offset(0);
    }];
    
    // 输入框
    UITextField *textF = [[UITextField alloc] init];
    textF.borderStyle = UITextBorderStyleRoundedRect;
    textF.keyboardType = UIKeyboardTypeDecimalPad;
    textF.textAlignment = NSTextAlignmentCenter;
    [_enterNumView addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(33);
    }];
    _customsizeProductNumberF = textF;
    
    // 声明取消按钮
    UIButton *btnCancel = [[UIButton alloc] init];
    [_enterNumView addSubview:btnCancel];
    
    // 确定
    NumberButton *btnComplete = [[NumberButton alloc] init];
    btnComplete.backgroundColor = TYColor;
    btnComplete.OD_IDX = OD_IDX;
    [btnComplete addTarget:self action:@selector(CompleteCustomsizeProductNumOnclick:) forControlEvents:UIControlEventTouchUpInside];
    btnComplete.layer.cornerRadius = 2.0f;
    [btnComplete setTitle:@"确定" forState:UIControlStateNormal];
    [_enterNumView addSubview:btnComplete];
    [btnComplete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textF.mas_bottom).offset(25);
        make.left.mas_equalTo(btnCancel.mas_right).offset(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(btnCancel.mas_width);
    }];
    
    // 取消
    btnCancel.backgroundColor = TYColor;
    [btnCancel addTarget:self action:@selector(CancelCustomsizeProductNumOnclick) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    btnCancel.layer.cornerRadius = btnComplete.layer.cornerRadius;
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnComplete.mas_top);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(btnComplete.mas_left).offset(-30);
        make.height.mas_equalTo(btnComplete.mas_height);
        make.width.mas_equalTo(btnComplete.mas_width);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _enterNumView.alpha = 1.0;
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        usleep(100000);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [textF becomeFirstResponder];
        });
    });
}


- (void)CompleteCustomsizeProductNumOnclick:(NumberButton *)sender {
    
    [LM_alert showLMAlertViewWithTitle:@"" message:@"确认修改产品数量？" cancleButtonTitle:@"取消" okButtonTitle:@"确认" okClickHandle:^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        SetProductQtyService *service = [[SetProductQtyService alloc] init];
        service.delegate = self;
        [service SetProductQty:sender.OD_IDX andstrQty:_customsizeProductNumberF.text];
    } cancelClickHandle:^{
        
        nil;
    }];
    
    [self CancelCustomsizeProductNumOnclick];
}


- (void)CancelCustomsizeProductNumOnclick {
    
    [self LMBlurredViewClear];
    
    [_blurredView clear];
}


#pragma mark - 修改备注UI

- (void)addTextView:(NSString *)title andType:(ConfirmformType)type {
    
    _blurredView = [[LMBlurredView alloc] init];
    _blurredView.delegate = self;
    [_blurredView blurry:5.1];
    
    // 输入数量
    _enterNumView = [[UIView alloc] init];
    _enterNumView.layer.cornerRadius = 2.0f;
    _enterNumView.backgroundColor = [UIColor whiteColor];
    UIView *window = self.view.window;
    [window addSubview:_enterNumView];
    [_enterNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(160);
        _enterNumView_bottom = make.bottom.mas_equalTo(-((ScreenHeight / 2) - (160 / 2)));
        make.centerX.offset(0);
    }];
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    [_enterNumView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.offset(0);
    }];
    
    // 输入框边框
    UIView *border = [[UIView alloc] init];
    border.backgroundColor = [UIColor grayColor];
    border.layer.cornerRadius = 2.0;
    [_enterNumView addSubview:border];
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
    }];
    
    // 输入框
    UITextView *textF = [[UITextView alloc] init];
    textF.layer.cornerRadius = 2.0;
    textF.font = [UIFont systemFontOfSize:14];
//    textF.text = _order.ORD_REMARK_CONSIGNEE;
    [border addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.mas_equalTo(1);
        make.right.mas_equalTo(-1);
        make.bottom.mas_equalTo(-1);
    }];
    _CONSIGNEE_REMARK = textF;
    
    // 声明取消按钮
    UIButton *btnCancel = [[UIButton alloc] init];
    [_enterNumView addSubview:btnCancel];
    
    // 确定
    NumberButton *btnComplete = [[NumberButton alloc] init];
    btnComplete.backgroundColor = TYColor;
    btnComplete.tag = type;
    [btnComplete addTarget:self action:@selector(CompleteCONSIGNEE_REMARKOnclick:) forControlEvents:UIControlEventTouchUpInside];
    btnComplete.layer.cornerRadius = 2.0f;
    [btnComplete setTitle:@"确定" forState:UIControlStateNormal];
    [_enterNumView addSubview:btnComplete];
    [btnComplete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(border.mas_bottom).offset(25);
        make.left.mas_equalTo(btnCancel.mas_right).offset(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(btnCancel.mas_width);
    }];
    
    // 取消
    btnCancel.backgroundColor = TYColor;
    [btnCancel addTarget:self action:@selector(CancelCONSIGNEE_REMARKOnclick) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    btnCancel.layer.cornerRadius = btnComplete.layer.cornerRadius;
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnComplete.mas_top);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(btnComplete.mas_left).offset(-30);
        make.height.mas_equalTo(btnComplete.mas_height);
        make.width.mas_equalTo(btnComplete.mas_width);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _enterNumView.alpha = 1.0;
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        usleep(100000);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [textF becomeFirstResponder];
        });
    });
}


- (void)CompleteCONSIGNEE_REMARKOnclick:(UIButton *)sender {
    
    if(sender.tag == KDYConfirmformTypeRemark) {
        [LM_alert showLMAlertViewWithTitle:@"" message:@"确认修改备注？" cancleButtonTitle:@"取消" okButtonTitle:@"确认" okClickHandle:^{
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            UpdateRemarkService *service_remark = [[UpdateRemarkService alloc] init];
            service_remark.delegate = self;
            [service_remark UpdateRemark:_order.IDX andstrRemark:_CONSIGNEE_REMARK.text];
        } cancelClickHandle:^{
            
            nil;
        }];
    } else if(sender.tag == KDYConfirmformTypeAudit) {
        
        if([_CONSIGNEE_REMARK.text isEqualToString:@""]) {
            
            [LM_alert showLMAlertViewWithTitle:@"" message:@"请填写退回理由" cancleButtonTitle:nil okButtonTitle:@"确认" okClickHandle:nil cancelClickHandle:^{
                
                [self CancelCONSIGNEE_REMARKOnclick];
            }];
        } else {
            
            [LM_alert showLMAlertViewWithTitle:@"" message:@"确认退回订单？" cancleButtonTitle:@"取消" okButtonTitle:@"确认" okClickHandle:^{
                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [_service_audit RuturnAudit:_order.IDX andstrUserName:_app.user.USER_NAME andstrReason:_CONSIGNEE_REMARK.text];
            } cancelClickHandle:nil];
            [self CancelCONSIGNEE_REMARKOnclick];
        }
    }
}


- (void)CancelCONSIGNEE_REMARKOnclick {
    
    [self LMBlurredViewClear];
    [_blurredView clear];
}


#pragma mark - LMBlurredViewDelegate

- (void)LMBlurredViewClear {
    
    [_app.window endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _enterNumView.alpha = 0;
    }];
}


#pragma mark - 通知回调

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    _keyboardHeight = keyboardRect.size.height;
    
    if(_keyboardHeight == 0) return;
    
    [self.enterNumView_bottom uninstall];
    
    [_enterNumView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-(_keyboardHeight + 20));
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [_enterNumView layoutIfNeeded];
    }];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    _keyboardHeight = 0;
}


#pragma mark - SetProductQtyServiceDelegate

- (void)successOfSetProductQty:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
    
    [_odrDetailService getOrderDetailsData:_order.IDX];
}


- (void)failureOfSetProductQty:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - OrderDetailServiceDelegate

- (void)successOfOrderDetail:(OrderModel *)order {
    
    _order = order;
    
    [self fullData];
    
    [self dealWithData];
    
    [_orderTableView reloadData];
}


- (void)failureOfOrderDetail:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取失败"];
}


#pragma mark - UpdateRemarkServiceDelegate

- (void)successOfUpdateRemark:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
    
    [_odrDetailService getOrderDetailsData:_order.IDX];
}


- (void)failureOfUpdateRemark:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - OrderCancelServiceDelegate

- (void)successOfOrderCancel:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
    _cancelOrderBtn.enabled = NO;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *UnAudited = [NSString stringWithFormat:@"k%@RequestNetwork", [UnAuditedViewController class]];
        NSString *cancelOrder = [NSString stringWithFormat:@"k%@RequestNetwork", [OrderCancelViewController class]];
        
        // 取消订单后 刷新TableView
        [[NSNotificationCenter defaultCenter] postNotificationName:UnAudited object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:cancelOrder object:nil];
        
        usleep(1700000);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}


- (void)failureOfOrderCancel:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}

@end

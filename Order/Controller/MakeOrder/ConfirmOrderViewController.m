//
//  ConfirmOrderViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/21.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "ProductModel.h"
#import "PromotionDetailModel.h"
#import "Tools.h"
#import "AppDelegate.h"
#import "AddGiftsViewController.h"
#import "AddGiftsService.h"
#import "MBProgressHUD.h"
#import "OrderGiftModel.h"
#import "ConfirmOrderGiftsTableViewCell.h"
#import "NSString+Trim.h"
#import "OrderConfirmService.h"
#import <Masonry.h>
#import "LMPickerView.h"
#import "LMBlurredView.h"
#import "GetToBusinessTypeLabel.h"

@interface ConfirmOrderViewController ()<UITableViewDelegate, UITableViewDataSource, ConfirmOrderTableViewCellDelegate, AddGiftsServiceDelegate, OrderConfirmServiceDelegate, LMPickerViewDelegate, LMBlurredViewDelegate, UIAlertViewDelegate>

#define ProductTableViewCellHeight 89
#define GiftTableViewCellHeight 69

//  虚化值 0 - 10
#define kBlurryLevel 5.1

// datePickerContainerView alpha渐变时间
#define kDatePickerContainerView_alpha_Duration 0.47f


//订单TableView
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

//订单TableView的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderTableViewHeight;

//提示无赠品
@property (weak, nonatomic) IBOutlet UILabel *noGiftPromptLabel;

//赠品TableView
@property (weak, nonatomic) IBOutlet UITableView *giftTableView;

//添加赠品
@property (weak, nonatomic) IBOutlet UIButton *addGiftButton;

//指定赠品
@property (strong, nonatomic) NSArray *assignGifts;

//手动赠品
@property (strong, nonatomic) NSArray *manualGifts;

//已选择的赠品
@property (strong, nonatomic) NSMutableArray *selectedGifts;

// 自定义价格输入框
@property (strong, nonatomic) UITextField *customizePriceF;

//当前弹出自定义价格框的indexRow
@property (assign, nonatomic) NSInteger customizePriceIndexRow;

//产品总数
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;

//产品原价
@property (weak, nonatomic) IBOutlet UILabel *orgPriceLabel;

//付款方式
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;

//促销策略提示
@property (weak, nonatomic) IBOutlet UILabel *promotionPromptLabel;

//促销策略
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;

//满减总计提示
@property (weak, nonatomic) IBOutlet UILabel *mjTotalPromptLabel;

//满减总计
@property (weak, nonatomic) IBOutlet UILabel *mjTotalLabel;

//实际付款
@property (weak, nonatomic) IBOutlet UILabel *actPriceLabel;

@property (strong, nonatomic) AppDelegate *app;

//备注
@property (weak, nonatomic) IBOutlet UITextView *remarkTextV;

@property (strong, nonatomic) AddGiftsService *addGiftsService;

//scrollView里的视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

//赠品TableView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftsTableViewHeight;

/// 赠品(PromotionDetailModel)，从下个界面获取
//@property (strong, nonatomic) NSMutableArray *gifts;

//textView的placeholder
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

// 显示时间选择器控件
@property (strong, nonatomic) UIView *datePickerContainerView;

// 时间格式
@property (strong, nonatomic) NSDateFormatter *formatter;

// 送货时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/// 已经选择的时间
@property (strong, nonatomic) NSDate *selectedDate;

/// 是否点击了时间的确定按钮。如果没点击，代表用户没选择时间，即使selectedDate有值也不使用
@property (assign, nonatomic) BOOL isOnclickDateSure;

// 选择时间事件
- (IBAction)timeOnclick:(UITapGestureRecognizer *)sender;

// 订单确认服务
@property (strong, nonatomic) OrderConfirmService *orderConfirmService;

- (IBAction)confirmOnclick:(UIButton *)sender;

// 时间选择
@property (strong, nonatomic)LMPickerView *LM;

// 确认
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

// 输入产品现价
@property (strong, nonatomic) UIView *enterNumView;

// 虚化背景
@property (strong, nonatomic) LMBlurredView *blurredView;

// 输入产品现价视图 距下
@property (nonatomic, strong) MASConstraint *enterNumView_bottom;

// 键盘高度
@property (assign, nonatomic) CGFloat keyboardHeight;

// 配送方式
@property (weak, nonatomic) IBOutlet UILabel *deliveryWayLabel;

// 部门字段
@property (weak, nonatomic) IBOutlet UITextField *REFERENCE01;

// 订单类型
@property (weak, nonatomic) IBOutlet GetToBusinessTypeLabel *getToBusinessTypeLabel;

@end


// 关闭时间选择器类型
typedef enum _CloseDatePicker {
    
    CloseDatePicker_TYPE_SURE  = 0,         // 确定
    CloseDatePicker_TYPE_CANCEL,            // 取消
} DateType;


@implementation ConfirmOrderViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _selectedGifts = [[NSMutableArray alloc] init];
        _customizePriceIndexRow = 0;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _addGiftsService = [[AddGiftsService alloc] init];
        _addGiftsService.delegate = self;
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
        _selectedDate = [NSDate date];
        _orderConfirmService = [[OrderConfirmService alloc] init];
        _orderConfirmService.delegate = self;
        _isOnclickDateSure = NO;
        
        _LM = [[LMPickerView alloc] init];
        _LM.delegate = self;
        [_LM initDatePicker];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    [self registerCell];
    
    [self dealWithData];
    
    [self alertDelieryWay];
    
    if(_app.getToBusinessTypeList.getToBusinessTypeItemModel.count >= 1) {
        GetToBusinessTypeItemModel *m = _app.getToBusinessTypeList.getToBusinessTypeItemModel[0];
        _getToBusinessTypeLabel.text = m.bUSINESSIDX;
        _getToBusinessTypeLabel.BUSINESS_TYPE = [m.iDX integerValue];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initUI];
    
    [self addNotification];
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    CGFloat giftTableViewHeight = 0;
    for (int i = 0; i < _selectedGifts.count; i++) {
        
        PromotionDetailModel *m = _selectedGifts[i];
        
        // Label 容器宽度
        CGFloat contentWidth = ScreenWidth - (3 + 35 + 3 + 30 + 10 + 10);
        // Label 单行高度
        CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:13 andWidth:999.9];
        
        CGFloat overflowHeight = [Tools getHeightOfString:m.PRODUCT_NAME fontSize:13 andWidth:contentWidth] - oneLineHeight;
        
        if(overflowHeight > 0) {
            
            m.cellHeight = GiftTableViewCellHeight + overflowHeight;
        } else {
            
            m.cellHeight = GiftTableViewCellHeight;
        }
        
        giftTableViewHeight += m.cellHeight;
    }
    //设置赠品TableView高度
    _giftsTableViewHeight.constant = giftTableViewHeight;
    
    
    _scrollContentViewHeight.constant = 480 + _orderTableViewHeight.constant + (_giftTableView.hidden ? 0 : _giftsTableViewHeight.constant);
}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
    [self removeNotification];
}


#pragma mark - SET方法

- (void)setPromotionDetailGiftsOfServer:(NSMutableArray *)promotionDetailGiftsOfServer {
    
    _promotionDetailGiftsOfServer = promotionDetailGiftsOfServer;
    _assignGifts = [_promotionDetailGiftsOfServer copy];
}


#pragma mark - 私有方法

- (void)dealWithData {
    
    CGFloat tableViewHeight = 0;
    for (int i = 0; i < _promotionDetailsOfServer.count; i++) {
        
        PromotionDetailModel *m = _promotionDetailsOfServer[i];
        
        // Label 容器宽度
        CGFloat contentWidth = ScreenWidth - 17 - 118;
        
        // Label 单行高度
        CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:13 andWidth:999.9];
        
        CGFloat overflowHeight = [Tools getHeightOfString:m.PRODUCT_NAME fontSize:13 andWidth:contentWidth] - oneLineHeight;
        
        if(overflowHeight > 0) {
            
            m.cellHeight = ProductTableViewCellHeight + overflowHeight;
        } else {
            
            m.cellHeight = ProductTableViewCellHeight;
        }
        
        m.cellHeight = m.cellHeight + ([m.SALE_REMARK isEqualToString:@""] ? 0 : 15);
        
        tableViewHeight += m.cellHeight;
    }
    
    //设置产品TableView高度
    _orderTableViewHeight.constant = tableViewHeight;
}


- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshGifts:) name:kConfirmOrderViewControllerRefreshGifts object:nil];
}


- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kConfirmOrderViewControllerRefreshGifts object:nil];
}


- (void)refreshGifts:(NSNotification *)aNotification {
    
    _manualGifts = [aNotification.userInfo[@"gifts"] copy];
    
    // 清空赠品列表
    [_selectedGifts removeAllObjects];
    
    // 添加指定赠品
    for (int i = 0; i < _assignGifts.count; i++) {
        
        [_selectedGifts addObject:_assignGifts[i]];
    }
    
    // 添加手选赠品
    for (int i = 0; i < _manualGifts.count; i++) {
        
        [_selectedGifts addObject:_manualGifts[i]];
    }
    NSLog(@"");
}


- (void)initUI {
    
    NSString *bussinessCode = _app.business.BUSINESS_CODE;
    
    // 既有指定赠品，也有手选赠品
    if(_promotionDetailGiftsOfServer.count > 0 && ([bussinessCode rangeOfString:@"YIB"].length == 0 && [_promotionOrder.HAVE_GIFT isEqualToString:@"Y"])) {
        _selectedGifts = _promotionDetailGiftsOfServer;
        _noGiftPromptLabel.hidden = YES;
        _giftTableView.hidden = NO;
        _addGiftButton.hidden = NO;
    } else {
        
        // 指定赠品
        if(_promotionDetailGiftsOfServer.count > 0) {
            _selectedGifts = _promotionDetailGiftsOfServer;
            _noGiftPromptLabel.hidden = YES;
            _giftTableView.hidden = NO;
            _addGiftButton.hidden = YES;
        }
        // 手选赠品或没有
        else {
            //没有赠品
            _noGiftPromptLabel.hidden = _selectedGifts.count;
            _giftTableView.hidden = !_selectedGifts.count;
            //设置添加赠品按钮是否可见
            if([_promotionOrder.HAVE_GIFT isEqualToString:@"Y"]) {
                _addGiftButton.hidden = NO;
            } else {
                _addGiftButton.hidden = YES;
            }
        }
        [self refreshCollectDada];
        [_orderTableView reloadData];
        [_giftTableView reloadData];
    }
}


- (void)alertDelieryWay {
    
    DeliveryWayItemModel *m = nil;
    if(_deliveryWayListM.deliveryWayItemModel.count == 1) {
        m = _deliveryWayListM.deliveryWayItemModel[0];
        _deliveryWayLabel.text = m.itemName;
    } else if(_deliveryWayListM.deliveryWayItemModel.count > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择配送方式" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        alert.tag = 10085;
        alert.delegate = self;
        
        for(int i = 0; i < _deliveryWayListM.deliveryWayItemModel.count; i++) {
            m = _deliveryWayListM.deliveryWayItemModel[i];
            [alert addButtonWithTitle:m.itemName];
        }
        [alert show];
    } else {
        [Tools showAlert:self.view andTitle:@"没有配送方式哦"];
    }
}


- (void)alertGetToBusinessType {
    
    GetToBusinessTypeItemModel *m = nil;
    GetToBusinessTypeListModel *list = _app.getToBusinessTypeList;
    if(list.getToBusinessTypeItemModel.count >= 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选订单类型" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        alert.tag = 10086;
        alert.delegate = self;
        
        for(int i = 0; i < list.getToBusinessTypeItemModel.count; i++) {
            m = list.getToBusinessTypeItemModel[i];
            [alert addButtonWithTitle:m.bUSINESSIDX];
        }
        [alert show];
    } else {
        [Tools showAlert:self.view andTitle:@"没有订单类型哦"];
    }
}


// 结算，汇总信息
- (void)refreshCollectDada {
    CGFloat totalCount = 0;
    double orgPrice = 0;
    double actPrice = 0;
    for(int i = 0; i < _promotionDetailsOfServer.count; i++) {
        PromotionDetailModel *m = _promotionDetailsOfServer[i];
        totalCount += m.PO_QTY;
        orgPrice += m.ORG_PRICE * m.PO_QTY;
        actPrice += m.ACT_PRICE * m.PO_QTY;
    }
    _promotionOrder.ACT_PRICE = actPrice;
    for(int i = 0; i < _selectedGifts.count; i++) {
        PromotionDetailModel *m = _selectedGifts[i];
        totalCount += m.PO_QTY;
    }
    _promotionOrder.TOTAL_QTY = totalCount;
    
    // 总数
    _totalCountLabel.text = [Tools formatFloat:_promotionOrder.TOTAL_QTY];
    
    // 原价
    _orgPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", orgPrice];
    
    // 付款方式
    _payTypeLabel.text = [Tools getPaymentType:_orderPayType];
    if(_selectedGifts.count > 0) {
        [_addGiftButton setTitle:@"重新添加" forState:UIControlStateNormal];
    } else {
        [_addGiftButton setTitle:@"添加赠品" forState:UIControlStateNormal];
    }
    if([_promotionOrder.MJ_REMARK isEqualToString:@""] || [_promotionOrder.MJ_REMARK isEqualToString:@"+|+"]) {
        _promotionPromptLabel.text = nil;
        _mjTotalPromptLabel.text = nil;
        _promotionLabel.text = nil;
        _mjTotalLabel.text = nil;
        _actPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _promotionOrder.ACT_PRICE];
    } else {
        _promotionPromptLabel.text = @"促销策略：";
        _mjTotalPromptLabel.text = @"满减总计：";
        _promotionLabel.text = _promotionOrder.MJ_REMARK;
        _mjTotalLabel.text = [NSString stringWithFormat:@"￥%.1f", _promotionOrder.MJ_PRICE];
        _actPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _promotionOrder.ACT_PRICE - _promotionOrder.MJ_PRICE];
    }
}


- (void)registerCell {
    
    [_orderTableView registerNib:[UINib nibWithNibName:@"ConfirmOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"ConfirmOrderTableViewCell"];
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_giftTableView registerNib:[UINib nibWithNibName:@"ConfirmOrderGiftsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ConfirmOrderGiftsTableViewCell"];
    _giftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)setNewPrice:(PromotionDetailModel *)m andPrice:(CGFloat)price {
    m.ACT_PRICE = price;
    for (int i = 0; i < _productsOfLocal.count; i++) {
        ProductModel *product = _productsOfLocal[i];
        if(m.PRODUCT_IDX == product.IDX) {
            product.PRODUCT_CURRENT_PRICE += 0.1;
        }
    }
    [_orderTableView reloadData];
}


#pragma mark - 点击事件

- (IBAction)addGiftOnclick:(UIButton *)sender {
    
    if([_promotionOrder.HAVE_GIFT isEqualToString:@"Y"] && _promotionOrder.OrderDetails.count > 0) {
        if(_promotionOrder.GiftClasses.count > 0) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            OrderGiftModel *m = _promotionOrder.GiftClasses[0];
            [_addGiftsService getAddGiftsData:_app.business.BUSINESS_IDX andPartyIdx:_partyId andPartyAddressIdx:_orderAddressIdx andProductName:m.TYPE_NAME];
        } else {
            
            [Tools showAlert:self.view andTitle:@"没有可用产品类别"];
        }
    }
}

// 获取选择赠品开始的 LINE_NO
- (int)getPromotionNumber {
    
    @try {
        
        int lineNumber = 0;
        
        for(int i = 0; i < _promotionOrder.OrderDetails.count; i++) {
            
            PromotionDetailModel *m = _promotionOrder.OrderDetails[i];
            if(m.LINE_NO > lineNumber) {
                
                lineNumber = (int)m.LINE_NO;
            }
        }
        return lineNumber;
    } @catch (NSException *exception) {
        
        return 0;
    }
}


- (void)confirmCustomizePriceOnclick {
    
    [self.view endEditing:YES];
    
    double price = [_customizePriceF.text doubleValue];
    price = [Tools getDouble:price];
    PromotionDetailModel *m = _promotionDetailsOfServer[_customizePriceIndexRow];
    
    [self setNewPrice:m andPrice:price];
    [self refreshCollectDada];
    
    [self LMBlurredViewClear];
    
    [_blurredView clear];
}

- (void)cancelCustomizePriceOnclick {
    
    [self LMBlurredViewClear];
    
    [_blurredView clear];
}

// 选择时间
- (IBAction)timeOnclick:(UITapGestureRecognizer *)sender {
    
    [_LM showDatePicker];
}


- (IBAction)deliveryWayOnclick:(UITapGestureRecognizer *)sender {
    
    [self alertDelieryWay];
}

- (IBAction)GetToBusinessTypeOnclick:(UITapGestureRecognizer *)sender {
    
    [self alertGetToBusinessType];
}


// 确认订单，最后一步提交到服务器
- (IBAction)confirmOnclick:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString *remark = [_remarkTextV.text trim];
    NSDate *date = _isOnclickDateSure ? _selectedDate : nil;
    
    [_orderConfirmService setConfirmData:_selectedGifts andProducts:_productsOfLocal andTempTotalQTY:_promotionOrder.TOTAL_QTY andDate:date andRemark:remark andPromotionOrder:_promotionOrder andSelectPronotionDetails:_promotionDetailsOfServer];
    
    NSString *promotionOrderStr = [self promotionOrderModelTransfromNSString:_promotionOrder];
    
    if([promotionOrderStr isEqualToString:@""]) {
        [Tools showAlert:self.view andTitle:@"订单处理异常"];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_orderConfirmService confirm:promotionOrderStr];
    }
}

- (NSString *)promotionOrderModelTransfromNSString:(PromotionOrderModel *)p {
    
    NSMutableArray *OrderDetails = [self promotionDetailModelTransfromNSString:p.OrderDetails];
    NSMutableArray *GiftClasses = [self GiftClassesModelTransfromNSString:p.GiftClasses];
    
    @try {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @(p.ACT_PRICE), @"ACT_PRICE",
                              p.ADD_DATE, @"ADD_DATE",
                              p.BUSINESS_IDX, @"BUSINESS_IDX",
                              @(_getToBusinessTypeLabel.BUSINESS_TYPE), @"BUSINESS_TYPE",
                              p.CONSIGNEE_REMARK, @"CONSIGNEE_REMARK",
                              p.EDIT_DATE, @"EDIT_DATE",
                              @(p.ENT_IDX), @"ENT_IDX",
                              p.FROM_ADDRESS, @"FROM_ADDRESS",
                              p.FROM_CITY, @"FROM_CITY",
                              p.FROM_CNAME, @"FROM_CNAME",
                              p.FROM_CODE, @"FROM_CODE",
                              p.FROM_COUNTRY, @"FROM_COUNTRY",
                              p.FROM_CSMS, @"FROM_CSMS",
                              p.FROM_CTEL, @"FROM_CTEL",
                              @(p.FROM_IDX), @"FROM_IDX",
                              p.FROM_NAME, @"FROM_NAME",
                              p.FROM_PROPERTY, @"FROM_PROPERTY",
                              p.FROM_PROVINCE, @"FROM_PROVINCE",
                              p.FROM_REGION, @"FROM_REGION",
                              p.FROM_ZIP, @"FROM_ZIP",
                              p.GROUP_NO, @"GROUP_NO",
                              GiftClasses, @"GiftClasses",
                              p.HAVE_GIFT, @"HAVE_GIFT",
                              @(p.IDX), @"IDX",
                              @(p.MJ_PRICE), @"MJ_PRICE",
                              p.MJ_REMARK, @"MJ_REMARK",
                              @(p.OPERATOR_IDX), @"OPERATOR_IDX",
                              p.ORD_NO, @"ORD_NO",
                              p.ORD_NO_CLIENT, @"ORD_NO_CLIENT",
                              p.ORD_NO_CONSIGNEE, @"ORD_NO_CONSIGNEE",
                              p.ORD_STATE, @"ORD_STATE",
                              @(p.ORG_IDX), @"ORG_IDX",
                              @(p.ORG_PRICE), @"ORG_PRICE",
                              OrderDetails, @"OrderDetails",
                              p.PARTY_IDX, @"PARTY_IDX",
                              p.PAYMENT_TYPE, @"PAYMENT_TYPE",
                              p.REQUEST_DELIVERY, @"REQUEST_DELIVERY",
                              p.REQUEST_ISSUE, @"REQUEST_ISSUE",
                              @(p.TOTAL_QTY), @"TOTAL_QTY",
                              @(p.TOTAL_VOLUME), @"TOTAL_VOLUME",
                              @(p.TOTAL_WEIGHT), @"TOTAL_WEIGHT",
                              p.TO_ADDRESS, @"TO_ADDRESS",
                              p.TO_CITY, @"TO_CITY",
                              p.TO_CNAME, @"TO_CNAME",
                              p.TO_CODE, @"TO_CODE",
                              p.TO_COUNTRY, @"TO_COUNTRY",
                              p.TO_CSMS, @"TO_CSMS",
                              p.TO_CTEL, @"TO_CTEL",
                              @(p.TO_IDX), @"TO_IDX",
                              p.TO_NAME, @"TO_NAME",
                              p.TO_PROPERTY, @"TO_PROPERTY",
                              p.TO_PROVINCE, @"TO_PROVINCE",
                              p.TO_REGION, @"TO_REGION",
                              p.TO_ZIP, @"TO_ZIP",
                              _REFERENCE01.text, @"REFERENCE01",
                              _deliveryWayLabel.text, @"REFERENCE02",
                              nil];
        
        NSString *s = [Tools JsonStringWithDictonary:dict];
        return s;
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSMutableArray *)GiftClassesModelTransfromNSString:(NSMutableArray *)ms {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    @try {
        for(int i = 0; i < ms.count; i++) {
            OrderGiftModel *m = ms[i];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @(m.isChecked), @"isChecked",
                                  @(m.choiceCount), @"choiceCount",
                                  @(m.PRICE), @"PRICE",
                                  @(m.QTY), @"QTY",
                                  m.TYPE_NAME, @"TYPE_NAME",
                                  nil];
            NSString *s = [Tools JsonStringWithDictonary:dict];
            [array addObject:s];
        }
    } @catch (NSException *exception) {
        return [[NSMutableArray alloc] init];
    }
    
    return array;
}

- (NSMutableArray *)promotionDetailModelTransfromNSString:(NSMutableArray *)ps {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    @try {
        for(int i = 0; i < ps.count; i++) {
            PromotionDetailModel *p = ps[i];
            NSDictionary *dict = nil;
            
            // 本地数据
            ProductModel *product = _productsOfLocal[i];
            
            if([p.PRODUCT_TYPE isEqualToString:@"NR"]) {
                dict = [NSDictionary dictionaryWithObjectsAndKeys:
                        @(p.ACT_PRICE), @"ACT_PRICE",
                        p.ADD_DATE, @"ADD_DATE",
                        p.EDIT_DATE, @"EDIT_DATE",
                        @(p.ENT_IDX), @"ENT_IDX",
                        @(p.IDX), @"IDX",
                        @(p.LINE_NO), @"LINE_NO",
                        p.LOTTABLE01, @"LOTTABLE01",
                        p.LOTTABLE02, @"LOTTABLE02",
                        p.LOTTABLE03, @"LOTTABLE03",
                        p.LOTTABLE04, @"LOTTABLE04",
                        p.LOTTABLE05, @"LOTTABLE05",
                        p.LOTTABLE06, @"LOTTABLE06",
                        p.LOTTABLE07, @"LOTTABLE07",
                        p.LOTTABLE08, @"LOTTABLE08",
                        p.LOTTABLE09, @"LOTTABLE09",
                        p.LOTTABLE10, @"LOTTABLE10",
                        @(p.LOTTABLE11), @"LOTTABLE11",
                        @(p.LOTTABLE12), @"LOTTABLE12",
                        @(p.LOTTABLE13), @"LOTTABLE13",
                        @(p.MJ_PRICE), @"MJ_PRICE",
                        p.MJ_REMARK, @"MJ_REMARK",
                        @(p.OPERATOR_IDX), @"OPERATOR_IDX",
                        @(p.ORDER_IDX), @"ORDER_IDX",
                        @(p.ORG_PRICE), @"ORG_PRICE",
                        @(p.PO_QTY), @"PO_QTY",
                        p.PO_UOM, @"PO_UOM",
                        @(p.PO_VOLUME), @"PO_VOLUME",
                        @(p.PO_WEIGHT), @"PO_WEIGHT",
                        @(p.PRODUCT_IDX), @"PRODUCT_IDX",
                        p.PRODUCT_NAME, @"PRODUCT_NAME",
                        p.PRODUCT_NO, @"PRODUCT_NO",
                        p.PRODUCT_TYPE, @"PRODUCT_TYPE",
                        p.PRODUCT_URL, @"PRODUCT_URL",
                        p.SALE_REMARK, @"SALE_REMARK",
                        @(product.QTYAVAILABLE), @"stock_qty",
                        nil];
            } else if([p.PRODUCT_TYPE isEqualToString:@"GF"]) {
                dict = [NSDictionary dictionaryWithObjectsAndKeys:
                        @(p.ACT_PRICE), @"ACT_PRICE",
                        @(p.ENT_IDX), @"ENT_IDX",
                        @(p.IDX), @"IDX",
                        @(p.LINE_NO), @"LINE_NO",
                        p.LOTTABLE02, @"LOTTABLE02",
                        p.LOTTABLE06, @"LOTTABLE06",
                        p.LOTTABLE09, @"LOTTABLE09",
                        @(p.LOTTABLE11), @"LOTTABLE11",
                        @(p.LOTTABLE12), @"LOTTABLE12",
                        @(p.LOTTABLE13), @"LOTTABLE13",
                        @(p.MJ_PRICE), @"MJ_PRICE",
                        @(p.OPERATOR_IDX), @"OPERATOR_IDX",
                        @(p.ORDER_IDX), @"ORDER_IDX",
                        @(p.ORG_PRICE), @"ORG_PRICE",
                        @(p.PO_QTY), @"PO_QTY",
                        @(p.PO_VOLUME), @"PO_VOLUME",
                        @(p.PO_WEIGHT), @"PO_WEIGHT",
                        @(p.PRODUCT_IDX), @"PRODUCT_IDX",
                        p.PRODUCT_NAME, @"PRODUCT_NAME",
                        p.PRODUCT_NO, @"PRODUCT_NO",
                        p.PRODUCT_TYPE, @"PRODUCT_TYPE",
                        p.SALE_REMARK, @"SALE_REMARK",
                        @(product.QTYAVAILABLE), @"stock_qty",
                        nil];
            } else {
                
                dict = [[NSDictionary alloc] init];
            }
            
            NSString *s = [Tools JsonStringWithDictonary:dict];
            [array addObject:s];
        }
    } @catch (NSException *exception) {
        
        return [[NSMutableArray alloc] init];
    }
    
    return array;
}


#pragma mark - OrderConfirmServiceDelegate

- (void)successOfOrderConfirmWithCommit {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:@"提交成功!"];
    [_commitBtn setEnabled:NO];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    });
}


- (void)failureOfOrderConfirmWithCommit:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg ? msg : @"提交失败"];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView.tag == 1001) {
        
        return _promotionDetailsOfServer.count;
    } else if(tableView.tag == 1002) {
        
        return _selectedGifts.count;
    } else {
        
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        
        // 获取数据
        PromotionDetailModel *m = _promotionDetailsOfServer[indexPath.row];
        
        return m.cellHeight;
    } else if(tableView.tag == 1002) {
        
        PromotionDetailModel *m = _selectedGifts[indexPath.row];
        return m.cellHeight;
    } else {
        
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        
        // 界面处理
        static NSString *cellId = @"ConfirmOrderTableViewCell";
        ConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.tag = indexPath.row;
        cell.delegate = self;
        
        // 本地数据
        ProductModel *product = _productsOfLocal[indexPath.row];
        
        // 获取数据
        PromotionDetailModel *m = _promotionDetailsOfServer[indexPath.row];
        
        // 填充数据
        cell.nameLabel.text = m.PRODUCT_NAME;
        cell.promotionNameLabel.text = [m.SALE_REMARK isEqualToString:@""] ? nil : m.SALE_REMARK;
        cell.originalPriceLabel.text = [NSString stringWithFormat:@"%.1f", m.ORG_PRICE];
        [cell.nowPriceButton setTitle:[NSString stringWithFormat:@"%.1f", m.ACT_PRICE] forState:UIControlStateNormal];
        cell.numberLabel.text = [Tools formatFloat:m.PO_QTY];
        cell.QTYAVAILABLE.text = [Tools formatFloat:product.QTYAVAILABLE];
        
        cell.addButtonWidth.constant = 30;
        cell.delButtonWidth.constant = 30;
        cell.nowPriceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        // 返回Cell
        return cell;
        
    } else if(tableView.tag == 1002) {
        
        // 界面处理
        static NSString *cellId = @"ConfirmOrderGiftsTableViewCell";
        ConfirmOrderGiftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.tag = indexPath.row;
        
        // 获取数据
        PromotionDetailModel *m = _selectedGifts[indexPath.row];
        
        // 填充数据
        cell.name1Label.text = m.PRODUCT_NAME;
        if([[m.SALE_REMARK trim] isEqualToString:@""]) {
            cell.name2Label.text = nil;
        } else {
            cell.name2Label.text = m.SALE_REMARK;
        }
        cell.orgPriceLabel.text = [NSString stringWithFormat:@"%.1f", m.ORG_PRICE];
        cell.actPriceLabel.text = [NSString stringWithFormat:@"%.1f", m.ACT_PRICE];
        cell.numberLabel.text = [Tools formatFloat:m.PO_QTY];
        
        // 返回Cell
        return cell;
    } else {
        
        return [[UITableViewCell alloc] init];
    }
}

#pragma mark - ConfirmOrderTableViewCellDelegate

- (void)delOnclickOfConfirmOrderTableViewCell:(NSInteger)indexRow {
    
    PromotionDetailModel *m = _promotionDetailsOfServer[indexRow];
    double price = m.ACT_PRICE - 0.1;
    
    [self setNewPrice:m andPrice:price];
    [self refreshCollectDada];
}

- (void)addOnclickOfConfirmOrderTableViewCell:(NSInteger)indexRow {
    
    PromotionDetailModel *m = _promotionDetailsOfServer[indexRow];
    CGFloat price = m.ACT_PRICE + 0.1;
    
    [self setNewPrice:m andPrice:price];
    [_orderTableView reloadData];
    [self refreshCollectDada];
}

- (void)customizePriceOfConfirmOrderTableViewCell:(NSInteger)indexRow {
    
    [self addEnterNumView];
    _customizePriceIndexRow = indexRow;
    
    [self refreshCollectDada];
}


#pragma mark - 键盘回收

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    
    return YES;
}


#pragma mark - AddGiftsServiceDelegate

- (void)successOfAddGifts:(NSMutableArray *)promotionDetails {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //防止变量被下个控制器修改
    NSMutableArray *giftsType = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < _promotionOrder.GiftClasses.count; i++) {
        
        OrderGiftModel *m1 = [_promotionOrder.GiftClasses[i] copy];
        [giftsType addObject:m1];
    }
    
    if(giftsType.count > 0) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:promotionDetails forKey:@(0)];
        
        AddGiftsViewController *vc = [[AddGiftsViewController alloc] init];
        vc.partyId = _partyId;
        vc.addressIdx = _orderAddressIdx;
        vc.beginLine = [self getPromotionNumber];
        vc.giftTypes = giftsType;
        //    vc.orderDetails = _promotionOrder.OrderDetails;
        vc.dictPromotionDetails = dict;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
        [Tools showAlert:self.view andTitle:@"无赠品可添加"];
    }
}


- (void)failureOfAddGifts:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:@"获取赠品失败"];
}


#pragma mark - LMPickerViewDelegate

- (void)PickerViewComplete:(NSDate *)date {
    
    _timeLabel.text = [_formatter stringFromDate:date];
    _isOnclickDateSure = YES;
    _selectedDate = date;
}


#pragma mark - Masny

- (void)addEnterNumView {
    
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
    label.text = @"请输入产品价格";
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
    _customizePriceF = textF;
    
    // 声明取消按钮
    UIButton *btnCancel = [[UIButton alloc] init];
    [_enterNumView addSubview:btnCancel];
    
    // 确定
    UIButton *btnComplete = [[UIButton alloc] init];
    btnComplete.backgroundColor = TYColor;
    [btnComplete addTarget:self action:@selector(confirmCustomizePriceOnclick) forControlEvents:UIControlEventTouchUpInside];
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
    [btnCancel addTarget:self action:@selector(cancelCustomizePriceOnclick) forControlEvents:UIControlEventTouchUpInside];
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


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag == 10085) {
        
        DeliveryWayItemModel *m = _deliveryWayListM.deliveryWayItemModel[buttonIndex];
        _deliveryWayLabel.text = m.itemName;
    }else if(alertView.tag == 10086) {
        
        GetToBusinessTypeItemModel *m =  _app.getToBusinessTypeList.getToBusinessTypeItemModel[buttonIndex];
        _getToBusinessTypeLabel.text = m.bUSINESSIDX;
        _getToBusinessTypeLabel.BUSINESS_TYPE = [m.iDX integerValue];
    }
}

@end

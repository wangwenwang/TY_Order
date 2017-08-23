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

@interface ConfirmOrderViewController ()<UITableViewDelegate, UITableViewDataSource, ConfirmOrderTableViewCellDelegate, AddGiftsServiceDelegate, OrderConfirmServiceDelegate, LMPickerViewDelegate>

#define ProductTableViewCellHeight 69
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

//已选择的赠品
@property (strong, nonatomic) NSMutableArray *selectedGifts;

//自定义价格视图
@property (weak, nonatomic) IBOutlet UIView *customizePriceView;

//价格上限
@property (weak, nonatomic) IBOutlet UILabel *upperLimi;

//价格下限
@property (weak, nonatomic) IBOutlet UILabel *lowerLimi;

//自定义价格输入框
@property (weak, nonatomic) IBOutlet UITextField *customizePriceF;

//取消自定义价格
- (IBAction)cancelCustomizePriceOnclick:(UIButton *)sender;

//确定自定义价格
- (IBAction)confirmCustomizePriceOnclick:(UIButton *)sender;

//当前弹出自定义价格框的indexRow
@property (assign, nonatomic) NSInteger customizePriceIndexRow;

//遮罩视图
@property (weak, nonatomic) IBOutlet UIView *coverView;

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
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initUI];
    
    [self addNotification];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    //设置赠品TableView高度
    _giftsTableViewHeight.constant = GiftTableViewCellHeight * _selectedGifts.count;
    
    _scrollContentViewHeight.constant = 450 + _orderTableViewHeight.constant + (_giftTableView.hidden ? 0 : _giftsTableViewHeight.constant);
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    [self removeNotification];
}


#pragma mark - 私有方法

- (void)dealWithData {
    
    CGFloat tableViewHeight = 0;
    for (int i = 0; i < _promotionDetailsOfServer.count; i++) {
        
        PromotionDetailModel *m = _promotionDetailsOfServer[i];
        
        // Label 容器宽度
        CGFloat contentWidth = 0;
        if([m.LOTTABLE06 isEqualToString:@"Y"]) {
            
            contentWidth = ScreenWidth - 17 - 118;
        } else {
            
            contentWidth = ScreenWidth - 17 - 88;
        }
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
    
    _selectedGifts = aNotification.userInfo[@"gifts"];
}


- (void)initUI {
    
    //没有赠品
    _noGiftPromptLabel.hidden = _selectedGifts.count;
    
    _giftTableView.hidden = !_selectedGifts.count;
    
    _customizePriceView.hidden = YES;
    _coverView.hidden = YES;
    
    //设置添加赠品按钮是否可见
    NSString *bussinessCode = _app.business.BUSINESS_CODE;
    if([bussinessCode rangeOfString:@"QH"].length > 0 && [_promotionOrder.HAVE_GIFT isEqualToString:@"Y"]) {
        //  if([bussinessName isEqualToString:@"凯东源前海项目"] && [_promotionOrder.HAVE_GIFT isEqualToString:@"Y"]) {
        
        _addGiftButton.hidden = NO;
    } else {
        
        _addGiftButton.hidden = YES;
    }
    
    [self refreshCollectDada];
    
    [_orderTableView reloadData];
    [_giftTableView reloadData];
}


// 结算，汇总信息
- (void)refreshCollectDada {
    long long totalCount = 0;
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
    _totalCountLabel.text = [NSString stringWithFormat:@"%lld", _promotionOrder.TOTAL_QTY];
    
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


- (IBAction)confirmCustomizePriceOnclick:(UIButton *)sender {
    [self.view endEditing:YES];
    _customizePriceView.hidden = YES;
    _coverView.hidden = YES;
    
    double price = [_customizePriceF.text doubleValue];
    price = [Tools getDouble:price];
    PromotionDetailModel *m = _promotionDetailsOfServer[_customizePriceIndexRow];
    
    if([Tools getDouble:price] <= [Tools getDouble:m.LOTTABLE12]) {
        
        if([Tools getDouble:price] >= [Tools getDouble:m.LOTTABLE13]) {
            
            [self setNewPrice:m andPrice:price];
            [self refreshCollectDada];
        } else {
            
            [Tools showAlert:self.view andTitle:@"价格超出下限"];
        }
    } else {
        
        [Tools showAlert:self.view andTitle:@"价格超出上限"];
    }
}

- (IBAction)cancelCustomizePriceOnclick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    _customizePriceView.hidden = YES;
    _coverView.hidden = YES;
}

// 选择时间
- (IBAction)timeOnclick:(UITapGestureRecognizer *)sender {
    
    [_LM showDatePicker];
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
                              @(p.BUSINESS_TYPE), @"BUSINESS_TYPE",
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
        
        return GiftTableViewCellHeight;
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
        
        // 获取数据
        PromotionDetailModel *m = _promotionDetailsOfServer[indexPath.row];
        
        // 填充数据
        cell.nameLabel.text = m.PRODUCT_NAME;
        cell.promotionNameLabel.text = [m.SALE_REMARK isEqualToString:@""] ? nil : m.SALE_REMARK;
        cell.originalPriceLabel.text = [NSString stringWithFormat:@"%.1f", m.ORG_PRICE];
        [cell.nowPriceButton setTitle:[NSString stringWithFormat:@"%.1f", m.ACT_PRICE] forState:UIControlStateNormal];
        cell.numberLabel.text = [NSString stringWithFormat:@"%lld", m.PO_QTY];
        if([m.LOTTABLE06 isEqualToString:@"Y"]) {
            
            cell.addButtonWidth.constant = 30;
            cell.delButtonWidth.constant = 30;
            cell.nowPriceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        } else {
            
            cell.addButtonWidth.constant = 0;
            cell.delButtonWidth.constant = 0;
            cell.nowPriceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        
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
        cell.numberLabel.text = [NSString stringWithFormat:@"%lld", m.PO_QTY];
        
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
    if([Tools getDouble:price] >= [Tools getDouble:m.LOTTABLE13]) {
        [self setNewPrice:m andPrice:price];
        [self refreshCollectDada];
    } else {
        
        [Tools showAlert:self.view andTitle:@"价格超出下限"];
    }
}

- (void)addOnclickOfConfirmOrderTableViewCell:(NSInteger)indexRow {
    
    PromotionDetailModel *m = _promotionDetailsOfServer[indexRow];
    CGFloat price = m.ACT_PRICE + 0.1;
    
    if([Tools getDouble:price] <= [Tools getDouble:m.LOTTABLE12]) {
        [self setNewPrice:m andPrice:price];
        [_orderTableView reloadData];
        [self refreshCollectDada];
    } else {
        
        [Tools showAlert:self.view andTitle:@"价格超出上限"];
    }
}

- (void)customizePriceOfConfirmOrderTableViewCell:(NSInteger)indexRow {
    
    PromotionDetailModel *m = _promotionDetailsOfServer[indexRow];
    
    if([m.LOTTABLE06 isEqualToString:@"Y"]) {
        
        _upperLimi.text = [NSString stringWithFormat:@"%.1f", m.LOTTABLE12];
        _lowerLimi.text = [NSString stringWithFormat:@"%.1f", m.LOTTABLE13];
        _customizePriceView.hidden = NO;
        _coverView.hidden = NO;
        _customizePriceIndexRow = indexRow;
        
        [self refreshCollectDada];
    } else {
        
    }
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

@end

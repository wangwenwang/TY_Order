//
//  SelectGoodsViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SelectGoodsViewController.h"
#import "SelectGoodsTableViewCell.h"
#import "SelectGoodsService.h"
#import "PayTypeModel.h"
#import "ProductModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Trim.h"
#import "ShoppingCartTableViewCell.h"
#import "ProductTypeTableViewCell.h"
#import "ProductTbModel.h"
#import "BrandTableViewCell.h"
#import "payTypeTableViewCell.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "ConfirmOrderViewController.h"
#import "OrderConfirmService.h"
#import "PromotionOrderModel.h"
#import "AppDelegate.h"
#import "PromotionDetailModel.h"
#import <Masonry.h>
#import "LMBlurredView.h"

/*
 *
 *   获取数据思路：
 *
 *   获取产品类型，成功回调后 --> 获取产品类型成功回调后 --> 获取产品数据成功回调后push下一页
 *
 *
 */


/// 促销Cell的高度
#define PolicyCellHeight 25

/// 支付方式Cell的高度
#define PayTypeCellHeight 27

/// 产品Cell的高度
#define kProductCellHeight 89

CGFloat const gestureMinimumTranslation = 5.0 ;

typedef enum : NSInteger {
    
    kCameraMoveDirectionNone,
    
    kCameraMoveDirectionUp,
    
    kCameraMoveDirectionDown,
    
    kCameraMoveDirectionRight,
    
    kCameraMoveDirectionLeft
    
} CameraMoveDirection;


@interface SelectGoodsViewController () <UITableViewDelegate, UITableViewDataSource, SelectGoodsTableViewCellDelegate, ShoppingCartTableViewCellDelegate, SelectGoodsServiceDelegate, OrderConfirmServiceDelegate, LMBlurredViewDelegate, UISearchBarDelegate> {
    
    CameraMoveDirection direction;
    BOOL aniFlg;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

// 品类选择View
- (IBAction)productTypeOnclick:(UITapGestureRecognizer *)sender;

// 品牌选择View

// 促销信息View


// 品类选择View的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeViewWidth;

// 品牌选择View的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brandViewWidth;

// 促销信息View的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onSalesView;

// 品类Label
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

// 品牌Label
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

// 下单总量
@property (weak, nonatomic) IBOutlet UILabel *makeOrderTotalNumber;

// 下单总价
@property (weak, nonatomic) IBOutlet UILabel *makeOrderTotalPriceLabel;

// 当前的下单总数量
@property (assign, nonatomic) CGFloat currentMakeOrderTotalCount;

// 当前的下单总价
@property (assign, nonatomic) double currentMakeOrderTotalPrice;

@property (strong, nonatomic) NSMutableArray *selectedProducts;

// 购物车点击事件
- (IBAction)shoppingCartOnclick:(UITapGestureRecognizer *)sender;

// 购物车TableView
@property (weak, nonatomic) IBOutlet UITableView *shoppingCarTableView;

// 购物车高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shoppingCarHeight;

// 是否弹出购物车
@property (assign, nonatomic) BOOL isShowSoppingCar;

// 是否付款类型
@property (assign, nonatomic) BOOL isShowPayType;

// 是否弹品类视图
@property (assign, nonatomic) BOOL isShowProductType;

// 是否完成弹出品牌视图
@property (assign, nonatomic) BOOL isDealWithProductTypeViewOk;

// 购物车上下拖动手势
- (IBAction)shoppingCarUpDownPan:(UIPanGestureRecognizer *)sender;

// 当前购物车高度，拖动购物车时使用
@property (assign, nonatomic) CGFloat currShoppingCarHeiht;

// 记住上次购物车高度，点击购物车时使用
@property (assign, nonatomic) CGFloat lastShoppingCarHeiht;

// 产品类型左视图
@property (weak, nonatomic) IBOutlet UIView *leftView;

// 产品类型左视图的X
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewX;

// 产品类型左视图的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewWidth;

// 产品类型TableView
@property (weak, nonatomic) IBOutlet UITableView *productTypeTableView;

// 遮罩View
@property (strong, nonatomic) UIView *coverView;

// 品牌TableView
@property (weak, nonatomic) IBOutlet UITableView *brandTableView;

// 品牌数据
@property (strong, nonatomic) NSMutableArray *brands;

// 品牌单击手势
- (IBAction)brandOnclick:(UITapGestureRecognizer *)sender;

// 品牌视图的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewWidth;

// 品牌视图离右边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewTrailing;

// 是否弹出品牌视图
@property (assign, nonatomic) BOOL isShowBrandView;

// 是否完成弹出品牌视图
@property (assign, nonatomic) BOOL isDealWithBrandViewOk;

// 支付方式TableView
@property (weak, nonatomic) IBOutlet UITableView *payTypeTableView;

// 支付方式TableView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payTypeTableViewHeight;

// 选择支付方式按钮
@property (weak, nonatomic) IBOutlet UIButton *payTypeSelectButton;

// 点击选择支付方式
- (IBAction)payTypeSelectOnclick:(UIButton *)sender;

// 其它信息视图
@property (weak, nonatomic) IBOutlet UIView *otherMsgView;

//其它信息单击手势
- (IBAction)otherMsgOnclick:(UITapGestureRecognizer *)sender;

// 是否弹出其它信息视图
@property (assign, nonatomic)BOOL isShowOtherMsgView;

// Main视图遮罩
@property (strong, nonatomic) UIView *coverMainView;

// 支付类型 --> 目标客户
@property (weak, nonatomic) IBOutlet UILabel *payTypeCustomerLabel;

// 支付类型 --> 目标地址
@property (weak, nonatomic) IBOutlet UILabel *payTypeAddressLabel;

// 支付类型 --> 付款方式
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;

- (IBAction)payTypeView:(UITapGestureRecognizer *)sender;

// 确认其它信息
- (IBAction)otherMsgConfirmOnclick:(UIButton *)sender;

// 当前选择的品牌
@property (copy, nonatomic) NSString *selectedBrand;

// 当前选择的品类
@property (copy, nonatomic) NSString *selectedProductType;

@property (strong, nonatomic) SelectGoodsService *selectGoodsService;

// 提交订单
- (IBAction)confirmOrderOnclick:(UITapGestureRecognizer *)sender;


/*************      自定义下单产品数量专区      *************/

// 自定义下单产品数量输入框
@property (strong, nonatomic) UITextField *customsizeProductNumberF;

// 自定义下单数据的Cell indexRow
@property (assign, nonatomic) int customsizeProductNumberIndexRow;

// 自定义下单数据的单价
@property (assign, nonatomic) double customsizeProductNumberPrice;

// 在自定义下单数据之前，已选择的下单数量
@property (assign, nonatomic) CGFloat selectedProductNumber;

// 订单确认服务
@property (strong, nonatomic) OrderConfirmService *orderConfirmService;

@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) PayTypeModel *currentPayType;

// 是否第一次viewWillAppear，如YES弹出“其它信息”视图，NO不弹视图
@property (assign, nonatomic) BOOL isFirstViewWillAppear;

// 当前选择的品类indexRow，对于产品来说是section
@property (assign, nonatomic) NSInteger currentSection;

@property (assign, nonatomic) NSInteger brandRow;

// 默认 5
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customerLabel_bottom;

// 其它信息 top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherMsg_top;

// 收货人名称
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_PERSON;

// 收货人联系电话
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_TEL;

// 输入产品数量
@property (strong, nonatomic) UIView *enterNumView;

// 虚化背景
@property (strong, nonatomic) LMBlurredView *blurredView;

// 键盘高度
@property (assign, nonatomic) CGFloat keyboardHeight;

// 输入产品数量视图 距下
@property (nonatomic, strong) MASConstraint *enterNumView_bottom;

// 购物车
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *shoppingCarView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *mainView;

// 产品信息列表数据(搜索过滤后的)
@property (strong, nonatomic)NSMutableDictionary *productsFilter;

// 遮罩上部分 有添加手势
@property (strong, nonatomic) UIView *searchCoverTopView;

// 遮罩下部分 有添加手势
@property (strong, nonatomic) UIView *searchCoverBottomView;

// 遮罩视觉部分 没手势
@property (strong, nonatomic) CAShapeLayer *searchCoverCALayer;
@property (strong, nonatomic) UIView *searchCoverView;

// 顶部筛选View 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

@end

@implementation SelectGoodsViewController


#pragma mark - 生命周期

- (instancetype)init {
    
    if(self = [super init]) {
        
        _selectGoodsService = [[SelectGoodsService alloc] init];
        _selectGoodsService.delegate = self;
        _selectedProducts = [[NSMutableArray alloc] init];
        _isShowSoppingCar = NO;
        _currShoppingCarHeiht = 0;
        _lastShoppingCarHeiht = 150;
        _isShowProductType = NO;
        _brands = [[NSMutableArray alloc] init];
        _isShowBrandView = NO;
        _isDealWithBrandViewOk = YES;
        _isDealWithProductTypeViewOk = YES;
        
        //默认选择全部品牌
        _selectedBrand = @"";
        _selectedProductType = @"";
        
        _orderConfirmService = [[OrderConfirmService alloc] init];
        _orderConfirmService.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _isFirstViewWillAppear = YES;
        _currentSection = 0;
        _brandRow = 0;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择商品";
    
    //注册Cell
    [self registerCell];
    
    [self.view layoutIfNeeded];
    
    [self addCoverMainView];
    
    [self addCoverView];
    
    //初始化UI参数
    [self initUI];
    
    //获取品牌数据
    [self getBrandData];
    
    //填充数据
    [self fullData];
    
    [self.view layoutIfNeeded];
    
    _otherMsg_top.constant = ScreenHeight / 2 - CGRectGetHeight(_otherMsgView.frame) / 2 - 64 - 20;
    
    [self addTableViewSearch];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _leftView.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 初始化其它信息视图
    [self initOtherMsgView:!_isFirstViewWillAppear];
    _isFirstViewWillAppear = NO;
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
    
    float width = (ScreenWidth - 2 * 5) / 4;
    
    _typeViewWidth.constant = width;
    
    _brandViewWidth.constant = width;
    
    _onSalesView.constant = width;
    
    _leftViewX.constant = -_leftViewWidth.constant;
    
    _rightViewTrailing.constant = -_rightViewWidth.constant;
    
    //先让payTypeTableView出来加载Cell,避免第一次加载Cell时会从(0, 0, 0, 0)到正常Frame的动画
    _payTypeTableViewHeight.constant = 0;
}


#pragma mark - GET方法

- (CALayer *)searchCoverCALayer {
    
    if(!_searchCoverCALayer) {
        
        _searchCoverCALayer = [CAShapeLayer layer];
        _searchCoverCALayer.fillColor = [UIColor blackColor].CGColor;
        _searchCoverCALayer.opacity = 0.2;
        [self.view.window.layer addSublayer:_searchCoverCALayer];
        
        // 镂空
        UIBezierPath *pPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(8, 64 + _topViewHeight.constant + 8, ScreenWidth - 16, 44 - 16) cornerRadius:5.0f];
        _searchCoverCALayer.path = pPath.CGPath;
        
        // 底部
        UIBezierPath *pOtherPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _searchCoverCALayer.path = pOtherPath.CGPath;
        
        // 底部 添加 镂空
        [pOtherPath appendPath:pPath];
        _searchCoverCALayer.path = pOtherPath.CGPath;
        
        // 重点
        _searchCoverCALayer.fillRule = kCAFillRuleEvenOdd;
        
        // 添加手势 View
        [self addSearchCoverBgView];
    }
    return _searchCoverCALayer;
}


#pragma mark - 功能函数

- (void)addTableViewSearch {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    searchBar.backgroundImage = [[UIImage alloc] init];
    searchBar.barTintColor = [UIColor clearColor];
    
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _myTableView.tableHeaderView = searchBar;
    [searchBar setPlaceholder:@"按名称搜索"];
    searchBar.delegate = self;
}

// 初始化其它信息视图
- (void)initOtherMsgView:(BOOL)first {
    
    _payTypeTableViewHeight.constant = 0;
    _otherMsgView.alpha = first ? 0 : 1;
    _coverMainView.alpha = first ? 0 : 0.3;
}


// 初始化UI
- (void)initUI {
    
    // 修改品类Label的部分文字颜色
    [self NSForegroundColorAttributeName:_typeLabel.text andRange:NSMakeRange(3,_typeLabel.text.length - 3) andLabel:_typeLabel];
    
    // 修改品牌Label的部分文字颜色
    [self NSForegroundColorAttributeName:_brandLabel.text andRange:NSMakeRange(3,_brandLabel.text.length - 3) andLabel:_brandLabel];
    
    [_payTypeSelectButton setImage:[UIImage imageNamed:@"button_drop_down"] forState:UIControlStateSelected];
    [_payTypeSelectButton setImage:[UIImage imageNamed:@"button_drop_left"] forState:UIControlStateNormal];
    
    _coverView.alpha = 0;
    _coverMainView.alpha = 0;
    _otherMsgView.alpha = 0;
}


// 给UI填充数据
- (void)fullData {
    
    /*************  目标客户换行  *************/
    
    // Label 容器宽度
    CGFloat contentWidth = ScreenWidth - 20 - 20 - 10 - 57 - 3;
    // Label 单行高度
    CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:999.9];
    
    CGFloat overflowHeight = [Tools getHeightOfString:_party.PARTY_NAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
    
    if(overflowHeight > 0) {
        
        _customerLabel_bottom.constant = 5 + overflowHeight;
    }
    /*************  目标客户换行  *************/
    
    _payTypeAddressLabel.text = _address.ADDRESS_INFO;
    _payTypeCustomerLabel.text = _party.PARTY_NAME;
    _CONTACT_PERSON.text = _address.CONTACT_PERSON;
    _CONTACT_TEL.text = _address.CONTACT_TEL;
}


// 获取品牌数据
- (void)getBrandData {
    
    for(int i = 0; i < _productTypes.count; i++) {
        ProductTbModel *m = _productTypes[i];
        
        // 剔除重复的品牌，添加到_brands
        int k = 0;
        int j;
        for(j = 0; j < _brands.count; j++) {
            ProductTbModel *mOfArr = _brands[j];
            if([[m.PRODUCT_CLASS trim] isEqualToString:@""] || [m.PRODUCT_CLASS isEqualToString:mOfArr.PRODUCT_CLASS]) {
                break;
            }else {
                k++;
            }
        }
        if(k == _brands.count) {
            [_brands addObject:m];
        }
    }
}


// 注册Cell
- (void)registerCell {
    
    [_myTableView registerNib:[UINib nibWithNibName:@"SelectGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectGoodsTableViewCell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_shoppingCarTableView registerNib:[UINib nibWithNibName:@"ShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShoppingCartTableViewCell"];
    
    [_productTypeTableView registerNib:[UINib nibWithNibName:@"ProductTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProductTypeTableViewCell"];
    
    [_brandTableView registerNib:[UINib nibWithNibName:@"BrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"BrandTableViewCell"];
    
    [_payTypeTableView registerNib:[UINib nibWithNibName:@"payTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"payTypeTableViewCell"];
    //    _payTypeTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _payTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


// 修改Label部分文字颜色
// text 文字
// range 修改范围
// label UILabel
- (void)NSForegroundColorAttributeName:(NSString *)text andRange:(NSRange)range andLabel:(UILabel *)label{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    label.attributedText = str;
}


// 获取产品名称，传入参数：ProductModel模型，PRODUCT_NAME变量
- (NSString *)getProductName:(NSString *)str {
    NSArray *array = [str componentsSeparatedByString:@","];
    
    if(array.count > 0) {
        return array[0];
    } else {
        return @"";
    }
}


// This method will determine whether the direction of the user's swipe
- ( CameraMoveDirection )determineCameraDirectionIfNeeded:( CGPoint )translation {
    
    if (direction != kCameraMoveDirectionNone)
        
        return direction;
    // determine if horizontal swipe only if you meet some minimum velocity
    if (fabs(translation.x) > gestureMinimumTranslation) {
        
        BOOL gestureHorizontal = NO;
        if (translation.y == 0.0 )
            
            gestureHorizontal = YES;
        else
            
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
        if (gestureHorizontal) {
            
            if (translation.x > 0.0 )
                
                return kCameraMoveDirectionRight;
            
            else
                return kCameraMoveDirectionLeft;
        }
    }
    
    // determine if vertical swipe only if you meet some minimum velocity
    else if (fabs(translation.y) > gestureMinimumTranslation) {
        
        BOOL gestureVertical = NO;
        
        if (translation.x == 0.0 )
            
            gestureVertical = YES;
        else
            
            gestureVertical = (fabs(translation.y / translation.x) > 5.0 );
        if (gestureVertical) {
            
            if (translation.y > 0.0 )
                
                return kCameraMoveDirectionDown;
            else
                
                return kCameraMoveDirectionUp;
        }
    }
    return direction;
}


// 添加遮罩 View，当用户搜索的时候弹出
- (void)addSearchCoverBgView {
    
    // 上部分 手势
    UITapGestureRecognizer *TopTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchCoverViewOnclick)];
    TopTap.numberOfTapsRequired = 1;
    
    // 下部分 手势
    UITapGestureRecognizer *BottomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchCoverViewOnclick)];
    BottomTap.numberOfTapsRequired = 1;
    
    // 上部分
    _searchCoverTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64 + _topViewHeight.constant)];
    [_searchCoverTopView addGestureRecognizer:TopTap];
    [self.view.window addSubview:_searchCoverTopView];
    
    // 下部分
    _searchCoverBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchCoverTopView.frame) + 44, ScreenWidth, ScreenHeight - CGRectGetMaxY(_searchCoverTopView.frame) - 44)];
    [_searchCoverBottomView addGestureRecognizer:BottomTap];
    [self.view.window addSubview:_searchCoverBottomView];
}

- (UIView *)searchCoverView {
    
    if(!_searchCoverView) {
        
        _searchCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _searchCoverView.userInteractionEnabled = NO;
        [self.view.window addSubview:_searchCoverView];
        
        
        CAShapeLayer *pShapeLayer = [CAShapeLayer layer];
        pShapeLayer.fillColor = [UIColor blackColor].CGColor;
        pShapeLayer.opacity = 0.2;
        [_searchCoverView.layer addSublayer:pShapeLayer];
        
        // 镂空
        UIBezierPath *pPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(8, 64 + _topViewHeight.constant + 8, ScreenWidth - 16, 44 - 16) cornerRadius:5.0f];
        pShapeLayer.path = pPath.CGPath;
        
        // 底部
        UIBezierPath *pOtherPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        pShapeLayer.path = pOtherPath.CGPath;
        
        // 底部 添加 镂空
        [pOtherPath appendPath:pPath];
        pShapeLayer.path = pOtherPath.CGPath;
        
        // 重点
        pShapeLayer.fillRule = kCAFillRuleEvenOdd;
        
        // 添加手势 View
        [self addSearchCoverBgView];
    }
    return _searchCoverView;
}


#pragma mark - 点击事件

// 提交
- (IBAction)confirmOrderOnclick:(UITapGestureRecognizer *)sender {
    
    if(_selectedProducts.count > 0) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self setProductCurrentPrice];
        [_orderConfirmService getPromotionData:[self getSubitString:_selectedProducts]];
        
    } else {
        
        [Tools showAlert:self.view andTitle:@"至少选择一种产品！"];
    }
}


- (void)CancelCustomsizeProductNumOnclick {
    
    [self LMBlurredViewClear];
    
    [_blurredView clear];
}


- (void)CompleteCustomsizeProductNumOnclick {
    
    CGFloat number = [_customsizeProductNumberF.text floatValue] ;
    
    // 改变的单一产品下单数量，有可能是负数
    CGFloat modifyNumber = number - _selectedProductNumber;
    
    // 如果填写后的数量与填写前的一样，则不操作
    if(modifyNumber == 0) {
        
        [Tools showAlert:_app.window andTitle:@"数量无更改"];
    } else {
        
        // 下单总数量
        _currentMakeOrderTotalCount += modifyNumber;
        
        ProductModel *m = _productsFilter[@(_brandRow)][@(_currentSection)][_customsizeProductNumberIndexRow];
        m.CHOICED_SIZE = number;
        
        _currentMakeOrderTotalPrice += _customsizeProductNumberPrice * modifyNumber;
        
        _makeOrderTotalNumber.text = [self formatFloat:_currentMakeOrderTotalCount];
        
        _makeOrderTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _currentMakeOrderTotalPrice];
        
        // 保存已选的产品
        if([_selectedProducts indexOfObject:_productsFilter[@(_brandRow)][@(_currentSection)][_customsizeProductNumberIndexRow]] == NSNotFound) {
            
            [_selectedProducts addObject:m];
        }
        
        // 删除已选的产品
        if(m.CHOICED_SIZE == 0) {
            
            [_selectedProducts removeObject:m];
        }
        
        _isShowSoppingCar ? [_shoppingCarTableView reloadData] : nil;
        [_myTableView reloadData];
        
        [self LMBlurredViewClear];
        
        [_blurredView clear];
        
        [_shoppingCarTableView reloadData];
    }
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView.tag == 1001) {
        
        NSMutableArray *products = _productsFilter[@(_brandRow)][@(_currentSection)];
        return products.count;
    } else if(tableView.tag == 1002) {
        
        return _selectedProducts.count;
    } else if(tableView.tag == 1003) {
        
        return _productTypes.count;
    } else if(tableView.tag == 1004) {
        
        return _brands.count;
    } else if(tableView.tag == 1005) {
        
        return _payTypes.count;
    } else {
        
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        ProductModel *m = _productsFilter[@(_brandRow)][@(_currentSection)][indexPath.row];
        
        // 产品基本信息高度69.0， 促销提示30.0， 促销信息44.0*条数
        if(m.PRODUCT_POLICY.count > 0) {
            
            if(m.isClickCell) {
                
                return m.cellHeight + 30.0 + PolicyCellHeight * m.PRODUCT_POLICY.count;
            } else {
                
                return m.cellHeight + 30.0;
            }
        } else {
            
            return m.cellHeight;
        }
    } else if(tableView.tag == 1002) {
        
        return 44;
    } else if(tableView.tag == 1003) {
        
        return 37;
    } else if(tableView.tag == 1004) {
        
        return 37;
    } else if(tableView.tag == 1005) {
        
        return PayTypeCellHeight;
    } else {
        
        return 0;
    }
}


- (NSString *)formatFloat:(float)f {
    
    if (fmodf(f, 1)==0) {
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else if (fmodf(f*100, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.2f",f];
    } else if (fmodf(f*1000, 1)==0) {
        return [NSString stringWithFormat:@"%.3f",f];
    } else if (fmodf(f*10000, 1)==0) {
        return [NSString stringWithFormat:@"%.4f",f];
    } else {
        return [NSString stringWithFormat:@"%.5f",f];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        
        // 获取数据
        ProductModel *m = _productsFilter[@(_brandRow)][@(_currentSection)][indexPath.row];
        
        // 处理界面
        static NSString *cellId = @"SelectGoodsTableViewCell";
        SelectGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.delegate = self;
        cell.tag = indexPath.row;
        cell.section = _currentSection;
        cell.cellHeight = PolicyCellHeight;
        cell.selfHeight = m.cellHeight;
        
        NSString *imageURL = [NSString stringWithFormat:@"%@/%@", API_ServerAddress, m.PRODUCT_URL];
        
        // 填充基本数据
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"ic_information_picture"] options:SDWebImageRefreshCached];
        cell.productNameLabel.text = [self getProductName:m.PRODUCT_NAME];
        cell.productFormatLabel.text = m.PRODUCT_DESC;
        cell.productPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", m.PRODUCT_PRICE];
        cell.QTYAVAILABLE.text = [Tools formatFloat:m.QTYAVAILABLE];
        [cell.productNumberButton setTitle:[self formatFloat:m.CHOICED_SIZE] forState:UIControlStateNormal];
        
        // 促销信息的处理
        cell.policyPromptView.hidden = !m.PRODUCT_POLICY.count;
        cell.PolicyPromptImageView.image = m.isClickCell ? [UIImage imageNamed:@"button_drop_down"] : [UIImage imageNamed:@"button_drop_up"];
        cell.product = m;
        
        if(m.isClickCell) {
            
            cell.policys = m.PRODUCT_POLICY;
        }
        cell.policyTableviewSuperView.hidden = !m.isClickCell;
        
        // 库存是否显示
        if([[m.ISINVENTORY trim] isEqualToString:@"Y"]) {
            cell.inventoryLabel.hidden = NO;
            cell.inventoryLabel.text = [NSString stringWithFormat:@"库存: %lld", m.PRODUCT_INVENTORY];
        } else {
            cell.inventoryLabel.hidden = YES;
        }
        
        cell.productFormatLabel_bottom.constant = 3 + m.cellHeight - kProductCellHeight;
        
        return cell;
        
    } else if(tableView.tag == 1002) {
        
        // 处理界面
        static NSString *cellId = @"ShoppingCartTableViewCell";
        ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.delegate = self;
        cell.tag = indexPath.row;
        
        // 获取数据
        ProductModel *m = _selectedProducts[indexPath.row];
        
        cell.product = m;
        
        // 填充基本数据
        cell.productNameLabel.text = m.PRODUCT_NAME;
        [cell.productNumberButton setTitle:[self formatFloat:m.CHOICED_SIZE] forState:UIControlStateNormal];
        
        return cell;
        
    } else if(tableView.tag == 1003) {
        
        // 处理界面
        static NSString *cellId = @"ProductTypeTableViewCell";
        ProductTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        // 获取数据
        ProductTbModel *m = _productTypes[indexPath.row];
        
        // 填充基本数据
        cell.productTypeLabel.text = m.PRODUCT_TYPE;
        
        return cell;
    } else if(tableView.tag == 1004) {
        
        // 处理界面
        static NSString *cellId = @"BrandTableViewCell";
        BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        // 获取数据
        ProductTbModel *m = _brands[indexPath.row];
        
        // 填充基本数据
        cell.nameLabel.text = m.PRODUCT_CLASS;
        
        return cell;
    }  else if(tableView.tag == 1005) {
        
        // 处理界面
        static NSString *cellId = @"payTypeTableViewCell";
        payTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        // 获取数据
        PayTypeModel *m = _payTypes[indexPath.row];
        
        // 填充基本数据
        cell.payTypeLabel.text = m.Text;
        cell.selectedImageView.image = m.selected ? [UIImage imageNamed:@"xw_selected"] : nil;
        
        return cell;
    } else {
        
        return [[UITableViewCell alloc] init];
    }
}


- (void)aniEnd {
    
    [UIView beginAnimations:@"fds" context:nil];
    [UIView commitAnimations];
    
    if (aniFlg) {
        
        [_typeLabel.layer removeAllAnimations];
    }
}


- (void)selectProductType:(NSInteger)indexRow andRefreshTableView:(BOOL)refresh {
    
    _currentSection = indexRow;
    ProductTbModel *m = _productTypes[indexRow];
    
    NSString *brand = @"";
    
    // 如果已经选择了品牌，就不用产品类型里的品牌
    if(![_selectedBrand isEqualToString:@""]) {
        
        brand = _selectedBrand;
    } else {
        
        brand = @""; //m.PRODUCT_CLASS;
    }
    
    _selectedProductType = [m.PRODUCT_TYPE isEqualToString:@"全部"] ? @"" : m.PRODUCT_TYPE;
    
    if(_dictProducts[@(_brandRow)][@(indexRow)]) {
        
        for (int i = 0; i < _selectedProducts.count; i++) {
            
            ProductModel *sm = _selectedProducts[i];
            NSMutableArray *array = _dictProducts[@(_brandRow)][@(_currentSection)];
            
            for(int j = 0; j < array.count; j++) {
                
                ProductModel *am = array[j];
                if(sm.IDX == am.IDX) {
                    
                    [array replaceObjectAtIndex:j withObject:sm];
                    break;
                }
            }
        }
        if(refresh) {
            
            [_myTableView reloadData];
        }
    } else {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_selectGoodsService getProductsData:_party.IDX andOrderAddressIdx:_address.IDX andProductTypeIndex:0 andProductType:_selectedProductType andOrderBrand:brand];
    }
    
    // 操作UI
    _typeLabel.text = [NSString stringWithFormat:@"类型:%@", [_selectedProductType isEqualToString:@""] ? @"全部" : _selectedProductType];
    // 修改品类Label的部分文字颜色
    [self NSForegroundColorAttributeName:_typeLabel.text andRange:NSMakeRange(3,_typeLabel.text.length - 3) andLabel:_typeLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectRowAtIndexPath");
    
    if(tableView.tag == 1001) {
        ProductModel *m = _dictProducts[@(_brandRow)][@(_currentSection)][indexPath.row];;
        m.isClickCell = m.isClickCell ? NO : YES;
        
        [_myTableView reloadData];
    } else if(tableView.tag == 1003) {
        
        // 选择品类
        [self selectProductType:indexPath.row andRefreshTableView:YES];
        
    }  else if(tableView.tag == 1004) {
        _brandRow = indexPath.row;
        
        // 选择品牌
        ProductTbModel *m = _brands[indexPath.row];
        _selectedBrand = [m.PRODUCT_CLASS isEqualToString:@"全部"] ? @"" : m.PRODUCT_CLASS;
        
        // 选择分类
        [self selectProductType:0 andRefreshTableView:YES];
        [_productTypeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
        
        //操作UI
        _brandLabel.text = [NSString stringWithFormat:@"分类:%@", [_selectedBrand isEqualToString:@""] ? @"全部" : _selectedBrand];
        //修改品牌Label的部分文字颜色
        [self NSForegroundColorAttributeName:_brandLabel.text andRange:NSMakeRange(3,_brandLabel.text.length - 3) andLabel:_brandLabel];
        
    } else if(tableView.tag == 1005) {
        
        PayTypeModel *m = _payTypes[indexPath.row];
        
        _currentPayType = m;
        
        _payTypeLabel.text = m.Text;
        for(int i = 0; i < _payTypes.count; i++) {
            PayTypeModel *mTemp = _payTypes[i];
            mTemp.selected = NO;
        }
        m.selected = YES;
        [_payTypeTableView reloadData];
        
        [self payTypeSelectOnclick:_payTypeSelectButton];
    }
}


- (void)msgChange:(CGFloat)x {
    CGRect frame = self.typeLabel.frame;
    frame.origin.x = 0;
    self.typeLabel.frame = frame;
    
    [UIView beginAnimations:@"scrollLabelTest" context:NULL];
    [UIView setAnimationDuration:-x / 10];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:999];
    
    frame = self.typeLabel.frame;
    frame.origin.x = x;
    self.typeLabel.frame = frame;
    [UIView commitAnimations];
}


#pragma mark - SelectGoodsTableViewCellDelegate

// 在产品列表里删除产品回调
- (void)delNumberOnclick:(double)price andIndexRow:(int)indexRow andSection:(NSInteger)section {
    
    _currentMakeOrderTotalCount -= 1;
    _currentMakeOrderTotalPrice -= price;
    
    _makeOrderTotalNumber.text = [self formatFloat:_currentMakeOrderTotalCount];
    
    NSString *priceStr = [NSString stringWithFormat:@"￥%.1f", _currentMakeOrderTotalPrice];
    
    _makeOrderTotalPriceLabel.text = priceStr;
    
    // 防止减后的价格出现0.000000000232，然后Label显示-0.0
    if([priceStr isEqualToString:@"￥-0.0"]) {
        _makeOrderTotalPriceLabel.text = @"￥0";
    }
    
    // 删除已选的产品
    ProductModel *delModel = _dictProducts[@(_brandRow)][@(section)][indexRow];
    if(delModel.CHOICED_SIZE == 0) {
        [_selectedProducts removeObject:delModel];
    }
    
    [_shoppingCarTableView reloadData];
}


// 在产品列表里添加产品回调
- (void)addNumberOnclick:(double)price andIndexRow:(int)indexRow andSection:(NSInteger)section {
    
    _currentMakeOrderTotalCount += 1;
    _currentMakeOrderTotalPrice += price;
    
    _makeOrderTotalNumber.text = [self formatFloat:_currentMakeOrderTotalCount];
    
    _makeOrderTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _currentMakeOrderTotalPrice];
    
    // 保存已选的产品
    if([_selectedProducts indexOfObject:_productsFilter[@(_brandRow)][@(section)][indexRow]] == NSNotFound) {
        [_selectedProducts addObject:_productsFilter[@(_brandRow)][@(section)][indexRow]];
    }
    
    [_shoppingCarTableView reloadData];
}


- (void)productNumberOnclick:(double)price andIndexRow:(int)indexRow andSelectedNumber:(CGFloat)selectedNumber andSection:(NSInteger)section {
    
    _customsizeProductNumberIndexRow = indexRow;
    _customsizeProductNumberPrice = price;
    _selectedProductNumber = selectedNumber;
    
    [self addEnterNumView];
}


- (void)noStockOfSelectGoodsTableViewCell {
    
    [Tools showAlert:self.view andTitle:@"产品数量超过库存数量"];
}


#pragma mark - ShoppingCartTableViewCellDelegate

// 在购物车列表里删除产品回调
- (void)delOnclickOfShoppingCartTableViewCell:(double)price andIndexRow:(int)indexRow {
    
    _currentMakeOrderTotalCount -= 1;
    _currentMakeOrderTotalPrice -= price;
    
    _makeOrderTotalNumber.text = [self formatFloat:_currentMakeOrderTotalCount];
    
    NSString *priceStr = [NSString stringWithFormat:@"￥%.1f", _currentMakeOrderTotalPrice];
    
    _makeOrderTotalPriceLabel.text = priceStr;
    
    // 防止减后的价格出现0.000000000232，然后Label显示-0.0
    if([priceStr isEqualToString:@"￥-0.0"]) {
        _makeOrderTotalPriceLabel.text = @"￥0";
    }
    
    // 删除已选的产品
    ProductModel *delModel = _selectedProducts[indexRow];
    if(delModel.CHOICED_SIZE == 0) {
        [_selectedProducts removeObject:delModel];
    }
    
    _isShowSoppingCar ? [_shoppingCarTableView reloadData] : nil;
    [_myTableView reloadData];
}


// 在购物车列表里添加产品回调
- (void)addOnclickShoppingCartTableViewCell:(double)price andIndexRow:(int)indexRow {
    
    _currentMakeOrderTotalCount += 1;
    _currentMakeOrderTotalPrice += price;
    
    _makeOrderTotalNumber.text = [self formatFloat:_currentMakeOrderTotalCount];
    
    _makeOrderTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", _currentMakeOrderTotalPrice];
    
    _isShowSoppingCar ? [_shoppingCarTableView reloadData] : nil;
    [_myTableView reloadData];
}


- (void)noStockOfShoppingCartTableViewCell {
    
    [Tools showAlert:self.view andTitle:@"产品数量超过库存数量"];
}


#pragma mark - 手势监听

- (IBAction)shoppingCarUpDownPan:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView: self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan ) {
        
        _currShoppingCarHeiht =  _shoppingCarHeight.constant;
        direction = kCameraMoveDirectionNone;
    } else if (sender.state == UIGestureRecognizerStateChanged && direction == kCameraMoveDirectionNone) {
        
        direction = [ self determineCameraDirectionIfNeeded:translation];
        switch (direction) {
                
            case kCameraMoveDirectionDown: NSLog (@"Start moving down"); break ;
            case kCameraMoveDirectionUp: NSLog (@"Start moving up"); break ;
            case kCameraMoveDirectionRight: NSLog (@"Start moving right"); break ;
            case kCameraMoveDirectionLeft: NSLog (@"Start moving left"); break ;
            default : break ;
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        _lastShoppingCarHeiht = _shoppingCarHeight.constant;
        _isShowSoppingCar = _lastShoppingCarHeiht ? YES : NO;
    }
    
    _shoppingCarHeight.constant = _currShoppingCarHeiht - translation.y;
}


// 点击购物车事件
- (IBAction)shoppingCartOnclick:(UITapGestureRecognizer *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _shoppingCarHeight.constant = _isShowSoppingCar ? 0 : _lastShoppingCarHeiht;
        
        if(SystemVersion >= 10.0) {
            
            [self.view layoutIfNeeded];
        } else {
            
            [_bottomView layoutIfNeeded];
            [_shoppingCarView layoutIfNeeded];
            _isShowSoppingCar ? nil : [_myTableView layoutIfNeeded];
        }
        
    } completion:^(BOOL finished) {
        
        _isShowSoppingCar = _isShowSoppingCar ? NO : YES;
    }];
    !_isShowSoppingCar ? [_shoppingCarTableView reloadData] : nil;
}


- (IBAction)productTypeOnclick:(UITapGestureRecognizer *)sender {
    
    _leftView.hidden = NO;
    
    [self hiddenProductTypeView];
}


- (void)hiddenProductTypeView {
    
    if(_isDealWithProductTypeViewOk) {
        if(_isShowBrandView) {
            
            [UIView animateWithDuration:0.5 animations:^{
                _isDealWithBrandViewOk = NO;
                
                _rightViewTrailing.constant = _isShowBrandView ? -_rightViewWidth.constant : 0;
                [self.view layoutIfNeeded];
                
                _coverView.alpha = _isShowBrandView ? 0 : 0.3;
            } completion:^(BOOL finished) {
                
                _isShowBrandView = _isShowBrandView ? NO : YES;
                _isDealWithBrandViewOk = YES;
            }];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _isDealWithProductTypeViewOk = NO;
            
            _leftViewX.constant = _isShowProductType ? -_leftViewWidth.constant : 0;
            [self.view layoutIfNeeded];
            
            _coverView.alpha = _isShowProductType ? 0 : 0.3;
        } completion:^(BOOL finished) {
            
            _isShowProductType = _isShowProductType ? NO : YES;
            _isDealWithProductTypeViewOk = YES;
        }];
    }
}


- (void)coverViewOnclick {
    
    if(_isShowProductType) {
        
        [self hiddenProductTypeView];
    } else if(_isShowBrandView) {
        
        [self hiddenBrandView];
    }
}


- (IBAction)brandOnclick:(UITapGestureRecognizer *)sender {
    
    [self hiddenBrandView];
}


- (void)hiddenBrandView {
    
    if(_isDealWithBrandViewOk) {
        if(_isShowProductType) {
            [UIView animateWithDuration:0.5 animations:^{
                
                _isDealWithProductTypeViewOk = NO;
                
                _leftViewX.constant = _isShowProductType ? -_leftViewWidth.constant : 0;
                [self.view layoutIfNeeded];
                
                _coverView.alpha = _isShowProductType ? 0 : 0.3;
            } completion:^(BOOL finished) {
                
                _isShowProductType = _isShowProductType ? NO : YES;
                _isDealWithProductTypeViewOk = YES;
            }];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            _isDealWithBrandViewOk = NO;
            
            _rightViewTrailing.constant = _isShowBrandView ? -_rightViewWidth.constant : 0;
            [self.view layoutIfNeeded];
            
            _coverView.alpha = _isShowBrandView ? 0 : 0.3;
        } completion:^(BOOL finished) {
            
            _isShowBrandView = _isShowBrandView ? NO : YES;
            _isDealWithBrandViewOk = YES;
        }];
    }
}


- (IBAction)payTypeSelectOnclick:(UIButton *)sender {
    
    sender.selected = sender.selected ? NO : YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _payTypeTableViewHeight.constant = sender.selected ? PayTypeCellHeight * _payTypes.count + 8 : 0;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        _isShowPayType = _isShowPayType ? NO : YES;
    }];
    
    !_isShowPayType ? [_payTypeTableView reloadData] : nil;
}


- (IBAction)otherMsgOnclick:(UITapGestureRecognizer *)sender {
    
    // 先让payTypeTableView出来加载Cell,避免第一次加载Cell时会从(0, 0, 0, 0)到正常Frame的动画
    _payTypeTableViewHeight.constant = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _otherMsgView.alpha = 1.0;
        _coverMainView.alpha = 0.3;
    }];
}


- (IBAction)payTypeView:(UITapGestureRecognizer *)sender {
    
    [self payTypeSelectOnclick:_payTypeSelectButton];
}


- (IBAction)otherMsgConfirmOnclick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _coverMainView.alpha = 0;
        _otherMsgView.alpha = 0;
    }];
}


#pragma SET方法

- (void)setDictProducts:(NSMutableDictionary *)dictProducts {
    
    _dictProducts = dictProducts;
    
    _productsFilter = [_dictProducts mutableCopy];
    
    [self fd];
}


- (void)fd {
    
    /*************  计算产品名称换行  *************/
    
    NSMutableArray *array = _productsFilter[@(_brandRow)][@(_currentSection)];
    
    for(int j = 0; j < array.count; j++) {
        
        ProductModel *m = array[j];
        // Label 容器宽度
        CGFloat contentWidth = ScreenWidth - 50 - 6 - 40 - 105;
        // Label 单行高度
        CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:999.9];
        
        CGFloat overflowHeight = [Tools getHeightOfString:m.PRODUCT_NAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
        
        if(overflowHeight > 0) {
            
            m.cellHeight = kProductCellHeight + overflowHeight;
        } else {
            
            m.cellHeight = kProductCellHeight;
        }
    }
    /*************  地址信息换行  *************/
}


#pragma mark - SelectGoodsServiceDelegate

//获取产品数据回调
- (void)successOfGetProductData:(NSMutableArray *)products {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:products forKey:@(_currentSection)];
    [_dictProducts setObject:dict forKey:@(_brandRow)];
    
    _productsFilter = [_dictProducts mutableCopy];
    
    for (int i = 0; i < _selectedProducts.count; i++) {
        ProductModel *sm = _selectedProducts[i];
        NSMutableArray *array = _productsFilter[@(_brandRow)][@(_currentSection)];
        for(int j = 0; j < array.count; j++) {
            ProductModel *am = array[j];
            if(sm.IDX == am.IDX) {
                [array replaceObjectAtIndex:j withObject:sm];
                break;
            }
        }
    }
    
    [self fd];
    
    [_myTableView reloadData];
}


- (void)failureOfGetProductData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //    [_products removeAllObjects];
    
    [_myTableView reloadData];
    
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取产品列表失败"];
    
}


// 产品模型转促销详情模型
- (PromotionDetailModel *)getPromotionDetailByProduct:(ProductModel *)product andProductType:(NSString *)PRODUCT_TYPE andLineNo:(long long)LINE_NO andPoQty:(CGFloat)PO_QTY andOperatorIdx:(long long) OPERATOR_IDX andActPrice:(double)ACT_PRICE {
    
    PromotionDetailModel *p = [[PromotionDetailModel alloc] init];
    if(product) {
        
        p.LOTTABLE10 = product.PRODUCT_TYPE;
        p.ENT_IDX = kENT_IDX;
        p.PRODUCT_TYPE = PRODUCT_TYPE;
        p.PRODUCT_IDX = product.IDX;
        p.PRODUCT_NO = product.PRODUCT_NO;
        p.PRODUCT_NAME = product.PRODUCT_NAME;
        p.PRODUCT_URL = product.PRODUCT_URL;
        p.LINE_NO = LINE_NO;
        p.PO_QTY = PO_QTY;
        p.ORG_PRICE = product.PRODUCT_PRICE;
        p.OPERATOR_IDX = OPERATOR_IDX;
        p.ACT_PRICE = ACT_PRICE;
        p.PO_VOLUME = product.PRODUCT_VOLUME * PO_QTY;
        p.PO_WEIGHT = product.PRODUCT_WEIGHT * PO_QTY;
        return p;
    } else {
        
        return nil;
    }
}


- (NSString *)getSubitString:(NSMutableArray *)products {
    
    NSMutableArray *selectedPromotionDetails = [[NSMutableArray alloc] init];
    
    long long idx = [_app.user.IDX longLongValue];
    
    for(int i = 0; i < products.count; i++) {
        
        ProductModel *product = products[i];
        
        PromotionDetailModel *promotionDetail = [self getPromotionDetailByProduct:product andProductType:kPRODUCT_TYPE_NORMAL andLineNo:i + 1 andPoQty:product.CHOICED_SIZE andOperatorIdx:idx andActPrice:product.PRODUCT_CURRENT_PRICE];
        
        [selectedPromotionDetails addObject:promotionDetail];
    }
    
    PromotionOrderModel *promotionOrder = [[PromotionOrderModel alloc] init];
    promotionOrder.OrderDetails = selectedPromotionDetails;
    promotionOrder.PAYMENT_TYPE = _currentPayType.Key;
    promotionOrder.PARTY_IDX = _party.IDX;
    promotionOrder.TO_CODE = _address.ADDRESS_CODE;
    promotionOrder.TO_IDX = [_address.IDX longLongValue];
    promotionOrder.ENT_IDX = kENT_IDX;
    promotionOrder.BUSINESS_IDX = _app.business.BUSINESS_IDX;
    promotionOrder.OPERATOR_IDX = [_app.user.IDX longLongValue];
    
    NSMutableArray *promotionDetailModels = [[NSMutableArray alloc] init];
    for(int i = 0; i < promotionOrder.OrderDetails.count; i++) {
        
        PromotionDetailModel *productTemp = promotionOrder.OrderDetails[i];
        NSDictionary *dict = [Tools setPromotionDetailModel:productTemp];
        [promotionDetailModels addObject:dict];
    }
    
    @try {
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              promotionDetailModels, @"OrderDetails",
                              promotionOrder.PAYMENT_TYPE, @"PAYMENT_TYPE",
                              promotionOrder.PARTY_IDX, @"PARTY_IDX",
                              promotionOrder.TO_CODE, @"TO_CODE",
                              @(promotionOrder.TO_IDX), @"TO_IDX",
                              @(promotionOrder.ENT_IDX), @"ENT_IDX",
                              promotionOrder.BUSINESS_IDX, @"BUSINESS_IDX",
                              @(promotionOrder.OPERATOR_IDX), @"OPERATOR_IDX",
                              @(0), @"ACT_PRICE",
                              @(0), @"BUSINESS_TYPE",
                              @(0), @"FROM_IDX",
                              @(0), @"IDX",
                              @(0), @"MJ_PRICE",
                              @(0), @"ORG_IDX",
                              @(0), @"ORG_PRICE",
                              @(0), @"TOTAL_QTY",
                              @(0), @"TOTAL_VOLUME",
                              @(0), @"TOTAL_WEIGHT",
                              nil];
        
        NSString *str = [Tools JsonStringWithDictonary:dict];
        return str;
    } @catch (NSException *exception) {
        
        return @"";
    }
}


// 根据用户选择的付款方式设置已选产品的产品现价
- (void)setProductCurrentPrice {
    
    NSString *currentPayKey = _currentPayType.Key;
    for(int i = 0; i < _selectedProducts.count; i++) {
        ProductModel *product = _selectedProducts[i];
        NSMutableArray *policys = product.PRODUCT_POLICY;
        NSMutableArray *payTypes = [self getPaymentList:policys];
        BOOL isPayTypeListHasPrice = NO;
        
        for(int i = 0; i < payTypes.count; i++) {
            
            PayTypeModel *paytype = payTypes[i];
            if([currentPayKey isEqualToString:@""] && [currentPayKey isEqualToString:paytype.Key]) {
                
                product.PRODUCT_CURRENT_PRICE = paytype.SALE_PRICE;
                isPayTypeListHasPrice = YES;
            }
        }
        
        if(!isPayTypeListHasPrice) {
            
            product.PRODUCT_CURRENT_PRICE = product.PRODUCT_PRICE;
        }
    }
}


/**
 * 获取付款方式
 * "POLICY_NAME": "怡宝饮料先付款再发货优惠",
 * "POLICY_TYPE": "101_FPAD",
 * <p/>
 * "POLICY_NAME": "怡宝饮料货到付款优惠",
 * "POLICY_TYPE": "102_FDAP",
 * <p/>
 * "POLICY_NAME": "怡宝饮料月结",
 * "POLICY_TYPE": "103_MP"
 *
 * * <p/>
 * "POLICY_NAME": "兑奖",
 * "POLICY_TYPE": DJ 暂无设置
 *
 * @param policies 产品的产品策略集合
 * @return 支付类型集合
 */
- (NSMutableArray *)getPaymentList:(NSMutableArray *)policys {
    
    @try {
        NSMutableArray *payTypes = [[NSMutableArray alloc] init];
        for(int i = 0; i < policys.count; i++) {
            
            ProductPolicyModel *productPolicy = policys[i];
            NSString *policyType = productPolicy.POLICY_TYPE;
            
            if([policyType hasPrefix:@"1"]) {
                
                PayTypeModel *payType = [[PayTypeModel alloc] init];
                NSArray *tmp = [productPolicy.POLICY_TYPE componentsSeparatedByString:@"_"];
                payType.Key = tmp[1];
                payType.Text = [Tools getPayTypeText:tmp[1]];
                payType.SALE_PRICE = [productPolicy.SALE_PRICE doubleValue];
                [payTypes addObject:payType];
            }
        }
        return payTypes;
    } @catch (NSException *exception) {
        
        return [[NSMutableArray alloc] init];
    }
}


#pragma mark - OrderConfirmServiceDelegate 提交订单，获取促销回调

- (void)successOfOrderConfirm:(PromotionOrderModel *)promotionOrder {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //请求的PromotionOrderModel，只取OrderDetails属性，取回后根据PRODUCT_TYPE是NR还是GF来分拣到两个数组，传到下一个控制器
    NSMutableArray *promotionDetailOfNR = [[NSMutableArray alloc] init];
    NSMutableArray *promotionDetailOfGF = [[NSMutableArray alloc] init];
    for(int i = 0; i < promotionOrder.OrderDetails.count; i++) {
        
        PromotionDetailModel *temp = promotionOrder.OrderDetails[i];
        if([temp.PRODUCT_TYPE isEqualToString:@"NR"]) {
            
            [promotionDetailOfNR addObject:temp];
        } else if([temp.PRODUCT_TYPE isEqualToString:@"GF"]) {
            
            [promotionDetailOfGF addObject:temp];
        }
    }
    
    ConfirmOrderViewController *vc = [[ConfirmOrderViewController alloc] init];
    vc.productsOfLocal = _selectedProducts;
    vc.promotionOrder = promotionOrder;
    vc.promotionDetailsOfServer = promotionDetailOfNR;
    //    vc.promotionDetailGiftsOfServer = promotionDetailOfGF;
    vc.orderAddressCode = _address.ADDRESS_CODE;
    vc.orderAddressIdx = _address.IDX;
    vc.orderPayType = _currentPayType.Key;
    vc.orderAddressIdx = _address.IDX;
    vc.partyId = _party.IDX;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)failureOfOrderConfirm:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - 重写SET方法

- (void)setPayTypes:(NSMutableArray *)payTypes {
    
    _payTypes = payTypes;
    if(payTypes.count > 0) {
        
        _currentPayType = payTypes[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _payTypeLabel.text = _currentPayType.Text;
        });
    }
}


#pragma mark - Masny

- (void)addCoverMainView {
    
    _coverMainView = [[UIView alloc] init];
    _coverMainView.backgroundColor = [UIColor blackColor];
    [_mainView insertSubview:_coverMainView belowSubview:_otherMsgView];
    [_coverMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


- (void)addCoverView {
    
    _coverView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewOnclick)];
    tap.numberOfTouchesRequired = 1;
    [_coverView addGestureRecognizer:tap];
    _coverView.backgroundColor = [UIColor blackColor];
    [_mainView insertSubview:_coverView belowSubview:_leftView];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

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
    UIButton *btnComplete = [[UIButton alloc] init];
    btnComplete.backgroundColor = TYColor;
    [btnComplete addTarget:self action:@selector(CompleteCustomsizeProductNumOnclick) forControlEvents:UIControlEventTouchUpInside];
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


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSLog(@"textDidChange : %@", searchText);
    [_productsFilter removeAllObjects];
    NSMutableArray *products = [[NSMutableArray alloc] init];
    NSMutableArray *orgProducts = _dictProducts[@(_brandRow)][@(_currentSection)];
    
    if([[searchText trim] isEqualToString:@""]) {
        
        _productsFilter = [_dictProducts mutableCopy];
    } else {
        
        for (int i = 0; i < orgProducts.count; i++) {
            
            ProductModel *m = _dictProducts[@(_brandRow)][@(_currentSection)][i];
            
            if([m.PRODUCT_NAME rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0) {
                
                [products addObject:m];
                NSDictionary *dict = [NSDictionary dictionaryWithObject:products forKey:@(_currentSection)];
                [_productsFilter setObject:dict forKey:@(_brandRow)];
            } else {
                
            }
        }
    }
    
    [_myTableView reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    //    [self.searchCoverView setHidden:NO];
    [self.view.window.layer addSublayer:self.searchCoverCALayer];
    [self.searchCoverTopView setHidden:NO];
    [self.searchCoverBottomView setHidden:NO];
}


- (void)searchCoverViewOnclick {
    
    [self.view endEditing:YES];
    //    [self.searchCoverView setHidden:YES];
    [_searchCoverCALayer removeFromSuperlayer];
    [self.searchCoverTopView setHidden:YES];
    [self.searchCoverBottomView setHidden:YES];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchCoverViewOnclick];
}

@end

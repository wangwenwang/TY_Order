//
//  ChartViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ChartViewController.h"
#import "MyPNPieChart.h"
#import "CustomerChartModel.h"
#import <MBProgressHUD.h>
#import "ChartService.h"
#import "Tools.h"
#import "ProductChartModel.h"

@interface ChartViewController ()<ChartServiceDelegate>

@property (weak, nonatomic) IBOutlet UIView *picChartView;

///
@property (strong, nonatomic) MyPNPieChart *pieChartView;

@property (strong, nonatomic) NSMutableArray *pieItems;

//饼状图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

//遮罩View
@property (weak, nonatomic) IBOutlet UIView *coverView;

//选择报表类型提示框
@property (weak, nonatomic) IBOutlet UIView *promptView;

//选择报表类型点击事件
- (IBAction)headViewOnclick:(UITapGestureRecognizer *)sender;

//遮罩View点击事件
- (IBAction)coverViewOnclick:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UILabel *whatChartLabel;

//客户报表
- (IBAction)customerChartOnclick:(UIButton *)sender;

//产品报表
- (IBAction)productChartOnclick:(UIButton *)sender;

//取消选报表类型
- (IBAction)cancelOnclick:(UIButton *)sender;

@property (strong, nonatomic) ChartService *service;

@property (weak, nonatomic) IBOutlet UIView *barChartView;

//圆饼分析模式
- (IBAction)pieChartOnclick:(UIButton *)sender;

//条形统计模式
- (IBAction)barChartOnclick:(UIButton *)sender;

//条形图底部Lable
@property (strong, nonatomic) NSMutableArray *arrXLabels;

//条形图要显示的数据
@property (strong, nonatomic) NSMutableArray *arrYValues;

//当前显示报表类型
@property (copy, nonatomic) NSString *currentChartType;

//当前显示圆饼图还是条形图 1代表圆饼图 2代表条形图
@property (assign, nonatomic) int barOrPieChart;

@property (strong, nonatomic) NSMutableArray *colors;

//条形图View的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barChartScrollContentViewWidth;

//饼图可见区域大小
@property (weak, nonatomic) IBOutlet UIView *pieVisibleView;

//条形图可见区域大小
@property (weak, nonatomic) IBOutlet UIView *barvisibleView;

@property (strong, nonatomic)PNBarChart *barChart;

// 客户数量总数
@property (assign, nonatomic) CGFloat CustomerTotalQTY;

// 产品数量总数
@property (assign, nonatomic) CGFloat ProductChartQTY;

@end

// 饼状图说明
#define kLegendFont 13
#define kLegendMaxWidth (ScreenWidth - 185)

@implementation ChartViewController

#pragma mark - 生命周期

- (instancetype)init {
    if(self = [super init]) {
        
        _pieItems = [[NSMutableArray alloc] init];
        _service = [[ChartService alloc] init];
        _service.delegate = self;
        
        _arrXLabels = [[NSMutableArray alloc] init];
        _arrYValues = [[NSMutableArray alloc] init];
        
        _currentChartType = mTagGetCustomerChartDataList;
        _barOrPieChart = 1;
        
        _colors = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"查看报表";
    
    [self addColor];
    
    [self initUI];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service getChartDataList:API_GET_CUSTOMER_CHART_DATA andTag:mTagGetCustomerChartDataList];
    _currentChartType = mTagGetCustomerChartDataList;
}


- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    _scrollContentViewHeight.constant = ScreenWidth + 10 + _arrM.count * 15;
    _barChartScrollContentViewWidth.constant = 60 + _arrM.count * 120;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - 功能函数

- (void)initUI {
    
    _promptView.hidden = YES;
    _coverView.hidden = YES;
    _barvisibleView.hidden = YES;
}


- (void)addColor {
    
    for (int i = 0; i < 7; i++) {
        
        for (int i = 0; i < 2; i++) {
            
            [_colors addObject:[UIColor blueColor]];
            [_colors addObject:[UIColor cyanColor]];
            [_colors addObject:[UIColor greenColor]];
            [_colors addObject:[UIColor brownColor]];
            [_colors addObject:[UIColor redColor]];
            [_colors addObject:[UIColor yellowColor]];
            [_colors addObject:[UIColor purpleColor]];
            [_colors addObject:[UIColor orangeColor]];
            [_colors addObject:[UIColor magentaColor]];
            [_colors addObject:[UIColor colorWithRed:135 / 255.0 green:206 / 255.0 blue:235 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:255 / 255.0 green:235 / 2550. blue:205 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:221 / 255.0 green:160 / 255.0 blue:221 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:255 / 255.0 green:99 / 255.0 blue:71 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:210 / 255.0 green:180 / 255.0 blue:140 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:61 / 255.0 green:89 / 255.0 blue:171 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:0 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:192 / 255.0 green:192 / 255.0 blue:192 / 255.0 alpha:1.0]];
            [_colors addObject:[UIColor colorWithRed:255 / 255.0 green:192 / 255.0 blue:203 / 255.0 alpha:1.0]];
        }
    }
}


#pragma mark - 条形图

// 处理数据
- (void)addBarChartData:(NSString *)type  {
    
    [_arrXLabels removeAllObjects];
    [_arrYValues removeAllObjects];
    
    if([type isEqualToString:mTagGetCustomerChartDataList]) {
        
        for (int i = 0; i < _arrM.count; i++) {
            CustomerChartModel *model = _arrM[i];
            [_arrXLabels addObject:model.TO_CITY];
            [_arrYValues addObject:@(model.ORD_QTY)];
        }
    } else if ([type isEqualToString:mTagGetProductChartDataList]) {
        
        for (int i = 0; i < _arrM.count; i++) {
            ProductChartModel *model = _arrM[i];
            [_arrXLabels addObject:model.PRODUCT_NAME];
            [_arrYValues addObject:@([model.PO_QTY floatValue])];
        }
    }
}

- (void)addBarChart {
    
    _barvisibleView.hidden = NO;
    _pieVisibleView.hidden = !_barvisibleView.hidden;
    
    [self clearBarChart];
    
    //如果_arrYValues.count == 0，程序会崩溃
    if(_arrYValues.count == 0) {
        [Tools showAlert:self.view andTitle:@"没有数据"];
        return;
    }
    
    _barChart = [[PNBarChart alloc] initWithFrame:_barChartView.bounds];
    _barChart.yChartLabelWidth = 35.0;
    _barChart.chartMarginLeft = 45.0;
    _barChart.chartMarginRight = 10.0;
    _barChart.chartMarginTop = 7.0;
    _barChart.chartMarginBottom = 17.0;
    
    _barChart.yLabelFormatter = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%zi", (NSUInteger)value];
    };
    
    _barChart.showChartBorder = YES;
    
    [_barChart setXLabels:_arrXLabels];
    [_barChart setYValues:_arrYValues];
    
    [_barChart strokeChart];
    [_barChartView addSubview:_barChart];
}


#pragma mark - 饼状图

- (void)addPieChartView:(NSString *)type {
    
    [_pieItems removeAllObjects];
    
    if([type isEqualToString:mTagGetCustomerChartDataList]) {
        
        // 索引最长名称
        CGFloat maxWidth = 0;
        for (int i = 0; i < _arrM.count; i++) {
            CustomerChartModel *m = _arrM[i];
            CGFloat width = [Tools getWidthOfString:m.TO_CITY fontSize:kLegendFont];
            if(width < kLegendMaxWidth) {
                if(width > maxWidth) {
                    maxWidth = width;
                }
            }
        }
        
        for (int i = 0; i < _arrM.count; i++) {
            
            CustomerChartModel *m = _arrM[i];
            CGFloat value = 0;
            NSString *des = [self GetCustomerChartDes:m andMaxWidth:maxWidth];
            value = (CGFloat)m.ORD_QTY;
            
            @try {
                PNPieChartDataItem *item = [PNPieChartDataItem dataItemWithValue:value color:_colors[i] description:des];
                [_pieItems addObject:item];
            } @catch (NSException *exception) {
                [Tools showAlert:self.view andTitle:@"颜色值不够用"];
            }
        }
        NSArray *items = [_pieItems copy];
        
        [self addPieChart:items andCenterTitle:@"客户销量统计"];
    } else if([type isEqualToString:mTagGetProductChartDataList]) {
        
        // 索引最长名称
        CGFloat maxWidth = 0;
        for (int i = 0; i < _arrM.count; i++) {
            ProductChartModel *m = _arrM[i];
            CGFloat width = [Tools getWidthOfString:m.PRODUCT_NAME fontSize:kLegendFont];
            if(width < kLegendMaxWidth) {
                if(width > maxWidth) {
                    maxWidth = width;
                }
            }
        }
        for (int i = 0; i < _arrM.count; i++) {
            
            ProductChartModel *m = _arrM[i];
            CGFloat value = 0;
            NSString *des = [self GetProductChartDes:m andMaxWidth:maxWidth];
            value = [m.PO_QTY floatValue];
            
            @try {
                PNPieChartDataItem *item = [PNPieChartDataItem dataItemWithValue:value color:_colors[i] description:des];
                [_pieItems addObject:item];
            } @catch (NSException *exception) {
                [Tools showAlert:self.view andTitle:@"颜色值不够用"];
            }
        }
        NSArray *items = [_pieItems copy];
        
        [self addPieChart:items andCenterTitle:@"产品销量统计"];
    }
}

- (void)addPieChart:(NSArray *)items andCenterTitle:(NSString *)centerTitle {
    
    [self clearPieChart];
    
    // 中心Label
    UILabel *centerLabel = nil;
    
    _pieChartView = [[MyPNPieChart alloc] initWithFrame:_picChartView.bounds items:items];
    
    centerLabel = [[UILabel alloc] init];
    centerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    centerLabel.numberOfLines = 0;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.font = [UIFont systemFontOfSize:13];
    [centerLabel setBounds:CGRectMake(0, 0, _pieChartView.innerCircleRadius * 2 - 8, _pieChartView.innerCircleRadius * 2)];
    [centerLabel setCenter:CGPointMake(CGRectGetWidth(_picChartView.frame) / 2, CGRectGetHeight(_picChartView.frame) / 2)];
    centerLabel.text = centerTitle;
    
    _pieChartView.descriptionTextColor = [UIColor whiteColor];
    _pieChartView.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:13.0];
    _pieChartView.duration = 2.0;
    _pieChartView.showOnlyValues = YES;
    [_pieChartView strokeChart];
    [_pieChartView addSubview:centerLabel];
    [_picChartView addSubview:_pieChartView];
    
    // 移除_picChartView里的UIView视图
    NSArray *picChartViewArr = _picChartView.subviews;
    
    for (int i = 0; i < picChartViewArr.count; i++) {
        UIView *v = picChartViewArr[i];
        if([v isMemberOfClass:[UIView class]]) {
            [v removeFromSuperview];
        }
        NSLog(@"_____:%@", [v class]);
    }
    
    _pieChartView.legendStyle = PNLegendItemStyleStacked;
    _pieChartView.legendFont = [UIFont systemFontOfSize:kLegendFont];
    UIView *legend = [_pieChartView getLegendWithMaxWidth:ScreenWidth - 30];
    CGFloat legendW = CGRectGetWidth(legend.frame);
    CGFloat legendX = CGRectGetMinX(_pieChartView.frame);
    CGFloat legendY = CGRectGetMaxY(_pieChartView.frame) + 8;
    [legend setFrame:CGRectMake(legendX, legendY, legendW, CGRectGetHeight(legend.frame))];
    [_picChartView addSubview:legend];
}


#pragma mark - 事件

// 选择报表类型
- (IBAction)headViewOnclick:(UITapGestureRecognizer *)sender {
    
    _promptView.hidden = NO;
    _coverView.hidden = NO;
}

// 遮罩
- (IBAction)coverViewOnclick:(UITapGestureRecognizer *)sender {
    
    _promptView.hidden = YES;
    _coverView.hidden = YES;
}

// 客户报表
- (IBAction)customerChartOnclick:(UIButton *)sender {
    
    _promptView.hidden = YES;
    _coverView.hidden = YES;
    _whatChartLabel.text = @"客户报表";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service getChartDataList:API_GET_CUSTOMER_CHART_DATA andTag:mTagGetCustomerChartDataList];
    _currentChartType = mTagGetCustomerChartDataList;
}

// 产品报表
- (IBAction)productChartOnclick:(UIButton *)sender {
    
    _promptView.hidden = YES;
    _coverView.hidden = YES;
    _whatChartLabel.text = @"产品报表";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service getChartDataList:API_GET_PRODUCT_CHART_DATA andTag:mTagGetProductChartDataList];
    _currentChartType = mTagGetProductChartDataList;
}

// 取消选报表类型
- (IBAction)cancelOnclick:(UIButton *)sender {
    
    _promptView.hidden = YES;
    _coverView.hidden = YES;
}

- (IBAction)pieChartOnclick:(UIButton *)sender {
    
    _pieVisibleView.hidden = NO;
    _barvisibleView.hidden = !_pieVisibleView.hidden;
    
    if(_arrM.count > 0) {
        
        [self addPieChartView:_currentChartType];
        // 记录下来，我当前在看饼状图
        _barOrPieChart = 1;
    } else {
        [Tools showAlert:self.view andTitle:@"没有数据"];
    }
}

- (IBAction)barChartOnclick:(UIButton *)sender {
    
    _pieVisibleView.hidden = YES;
    _barvisibleView.hidden = !_pieVisibleView.hidden;
    [self addBarChartData:_currentChartType];
    [self addBarChart];
    
    // 记录下来，我当前在看条形图
    _barOrPieChart = 2;
}


#pragma mark - ChartServiceDelegate

// 获取客户报表信息
- (void)successOfChartServiceWithCustomer:(NSMutableArray *)customerChart {
    
    _arrM = customerChart;
    
    [self SortAsc_CustomerChartModel:_arrM];
    
    [self updateViewConstraints];
    
    // 计算总数，方便求百分比
    for (int i = 0; i < _arrM.count; i++) {
        
        CustomerChartModel *CM = _arrM[i];
        _CustomerTotalQTY += CM.ORD_QTY;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(_barOrPieChart == 1) {
                
                [self addPieChartView:mTagGetCustomerChartDataList];
            } else if (_barOrPieChart == 2) {
                
                [self addBarChartData:mTagGetCustomerChartDataList];
                [self addBarChart];
            }
        });
    });
}


// 获取产品报表信息
- (void)successOfChartServiceWithProduct:(NSMutableArray *)productChart {
    
    _arrM = productChart;
    
    [self SortAsc_ProductChartModel:_arrM];
    
    [self updateViewConstraints];
    
    // 计算总数，方便求百分比
    for (int i = 0; i < _arrM.count; i++) {
        
        ProductChartModel *PM = _arrM[i];
        _ProductChartQTY += [PM.PO_QTY floatValue];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(_barOrPieChart == 1) {
                
                [self addPieChartView:mTagGetProductChartDataList];
            } else if (_barOrPieChart == 2) {
                
                [self addBarChartData:mTagGetProductChartDataList];
                [self addBarChart];
            }
        });
    });
    
   
}

// 获取客户或产品报表信息失败
- (void)failureOfChartService:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取报表数据失败！"];
    
    [_arrM removeAllObjects];
    
    [self clearPieChart];
    
    [self clearBarChart];
}


#pragma mark - 清屏函数

// 饼状图清屏
- (void)clearPieChart {
    
    NSUInteger count = _picChartView.subviews.count;
    for (int i = 0; i < count; i++) {
        
        UIView *v = _picChartView.subviews[0];
        [v removeFromSuperview];
    }
}


// 柱状图清屏
- (void)clearBarChart {
    
    if(_barChart) {
        
        [_barChart removeFromSuperview];
        _barChart = nil;
    }
}


// 获取客户报表描述
- (NSString *)GetCustomerChartDes:(CustomerChartModel *)customer andMaxWidth:(CGFloat)maxWidth {
    
    CGFloat CITY_WIDTH = [Tools getWidthOfString:customer.TO_CITY fontSize:kLegendFont];
    for (int i = 0; CITY_WIDTH < maxWidth; i++) {
        customer.TO_CITY = [NSString stringWithFormat:@"%@ ", customer.TO_CITY];
        CITY_WIDTH = [Tools getWidthOfString:customer.TO_CITY fontSize:kLegendFont];
    }
    
    return [NSString stringWithFormat:@"%@  数量:%.0f件  比重:%.1f%%", customer.TO_CITY, customer.ORD_QTY, (customer.ORD_QTY / _CustomerTotalQTY) * 100];
}


// 获取产品报表描述
- (NSString *)GetProductChartDes:(ProductChartModel *)product andMaxWidth:(CGFloat)maxWidth {
    
    CGFloat CITY_WIDTH = [Tools getWidthOfString:product.PRODUCT_NAME fontSize:kLegendFont];
    for (int i = 0; CITY_WIDTH < maxWidth; i++) {
        product.PRODUCT_NAME = [NSString stringWithFormat:@"%@ ", product.PRODUCT_NAME];
        CITY_WIDTH = [Tools getWidthOfString:product.PRODUCT_NAME fontSize:kLegendFont];
    }
    
    return [NSString stringWithFormat:@"%@  数量:%@件  比重:%.1f%%", product.PRODUCT_NAME, product.PO_QTY, ([product.PO_QTY floatValue] / _ProductChartQTY) * 100];
}


/**
 降序排序
 
 @param array 排序前
 
 @return 排序后
 */
- (NSMutableArray *)SortAsc_CustomerChartModel:(NSMutableArray *)array {
    
    for (int  i = 0; i < [array count] - 1; i++) {
        
        for (int j = i + 1; j < [array count]; j++) {
            
            CustomerChartModel *iM = array[i];
            CustomerChartModel *jM = array[j];
            if (iM.ORD_QTY < jM.ORD_QTY) {
                
                //交换
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return array;
}


/**
 降序排序
 
 @param array 排序前
 
 @return 排序后
 */
- (NSMutableArray *)SortAsc_ProductChartModel:(NSMutableArray *)array {
    
    for (int  i = 0; i < [array count] - 1; i++) {
        
        for (int j = i + 1; j < [array count]; j++) {
            
            ProductChartModel *iM = array[i];
            ProductChartModel *jM = array[j];
            if ([iM.PO_QTY floatValue] < [jM.PO_QTY floatValue]) {
                
                //交换
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return array;
}

@end

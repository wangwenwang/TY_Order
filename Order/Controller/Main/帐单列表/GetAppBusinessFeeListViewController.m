//
//  GetAppBusinessFeeListViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBusinessFeeListViewController.h"
#import "GetAppBusinessFeeListService.h"
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import "Tools.h"
#import "GetAppBusinessFeeListTableViewCell.h"

@interface GetAppBusinessFeeListViewController ()<GetAppBusinessFeeListServiceDelegate>

// 网络层
@property (strong, nonatomic) GetAppBusinessFeeListService *service;

// 模型
@property (strong, nonatomic) GetAppBusinessFeeListModel *GetAppBusinessFeeListM;

// 全局变量
@property (strong, nonatomic) AppDelegate *app;

// 月份
@property (weak, nonatomic) IBOutlet UILabel *BILL_DATE;

// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

// 业务代码
@property (weak, nonatomic) IBOutlet UILabel *BUSINESS_CODE;

// 业务名称
@property (weak, nonatomic) IBOutlet UILabel *BUSINESS_NAME;

// 上月留存提货余额
@property (weak, nonatomic) IBOutlet UILabel *LastMonth;

// 加本月累计付款及代垫费用金额
@property (weak, nonatomic) IBOutlet UILabel *ThisMonthPostive;

// 减本月累计提货总额
@property (weak, nonatomic) IBOutlet UILabel *ThisMonthMinus;

// 本月留存提货余额
@property (weak, nonatomic) IBOutlet UILabel *ThisMonth;

// 内容高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

// 客户信息高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customerInfoViewHeight;

// 费用详情高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feeInfoHeight;

// 费用总计高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feeTotalViewHeight;

// 费用详情
@property (weak, nonatomic) IBOutlet UIView *feeInfoView;

// 展开完成
@property (assign, nonatomic) BOOL showComplete;

// 费用明细列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 列表高度
@property (assign, nonatomic) CGFloat tableViewHeight;

// 展开提示文字
@property (weak, nonatomic) IBOutlet UILabel *showPromptLabel;

// 展开提示图片
@property (weak, nonatomic) IBOutlet UIImageView *showPromptImageView;

@end

#define kCellHeight 87

#define kCellName @"GetAppBusinessFeeListTableViewCell"

@implementation GetAppBusinessFeeListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[GetAppBusinessFeeListService alloc] init];
        _service.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"费用列表";
    
    [self initUI];
    
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_service GetAppBusinessFeeList:_MONTH_DATE andBUSINESS_IDX:_app.business.BUSINESS_IDX andPARTY_IDX:_PARTY_IDX];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - 功能函数

- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)initUI {
    
    _BILL_DATE.text = _MONTH_DATE;
    
    _PARTY_CODE.text = @"";
    _PARTY_NAME.text = @"";
    _BUSINESS_CODE.text = @"";
    _BUSINESS_NAME.text = @"";
    _LastMonth.text = @"";
    _ThisMonthPostive.text = @"";
    _ThisMonthMinus.text = @"";
    _ThisMonth.text = @"";
}


- (void)pauseLayer:(CALayer *)layer {
    
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    layer.speed=0.0;
    layer.timeOffset=pausedTime;
}


- (void)resumeLayer:(CALayer *)layer {
    
    CFTimeInterval pausedTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


#pragma mark - 手势

- (IBAction)feeOnclick {
    
    [self.view layoutIfNeeded];
    
    CGFloat Duration = 0.3;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:Duration];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = _showComplete ? @[ @(M_PI), @0 ] : @[ @0, @(M_PI) ];
    [_showPromptImageView.layer addAnimation:anim forKey:anim.keyPath];
    [_showPromptImageView.layer setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    [CATransaction commit];
    
    [UIView animateWithDuration:Duration animations:^{
        
        _feeInfoHeight.constant = _showComplete ? 40 : _tableViewHeight + 40;
        
        _scrollContentViewHeight.constant = 15 + 40 + 20 + _customerInfoViewHeight.constant + 15 + _feeInfoHeight.constant + 15 + _feeTotalViewHeight.constant + 20;
        
        _showPromptLabel.text = _showComplete ? @"展开明细" : @"收回明细";
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        _showComplete = !_showComplete;
    }];
    
    !_showComplete ? [_tableView reloadData] : nil;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _GetAppBusinessFeeListM.appBusinessFeeListModel.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppBusinessFeeListModel *m =  _GetAppBusinessFeeListM.appBusinessFeeListModel[indexPath.row];
    
    return m.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = kCellName;
    
    AppBusinessFeeListModel *m =  _GetAppBusinessFeeListM.appBusinessFeeListModel[indexPath.row];
    
    GetAppBusinessFeeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.listM = m;
    
    return cell;
}


#pragma mark - GetAppBusinessFeeListServiceDelegate

- (void)successOfGetAppBusinessFeeList:(GetAppBusinessFeeListModel *)GetAppBusinessFeeListM {
    
    _GetAppBusinessFeeListM = GetAppBusinessFeeListM;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _PARTY_CODE.text = _GetAppBusinessFeeListM.appBusinessFeeModel.pARTYCODE;
    _PARTY_NAME.text = _GetAppBusinessFeeListM.appBusinessFeeModel.pARTYNAME;
    _BUSINESS_CODE.text = _GetAppBusinessFeeListM.appBusinessFeeModel.bUSINESSCODE;
    _BUSINESS_NAME.text = _GetAppBusinessFeeListM.appBusinessFeeModel.bUSINESSNAME;
    
    _LastMonth.text = _GetAppBusinessFeeListM.appBusinessFeeModel.lastMonth;
    _ThisMonthPostive.text = _GetAppBusinessFeeListM.appBusinessFeeModel.thisMonthPostive;
    _ThisMonthMinus.text = _GetAppBusinessFeeListM.appBusinessFeeModel.thisMonthMinus;
    _ThisMonth.text = _GetAppBusinessFeeListM.appBusinessFeeModel.thisMonth;
    
    /*************  地址信息换行  *************/
    // tableView 总高度
    CGFloat tableViewHeight = 0;
    for (int i = 0; i < _GetAppBusinessFeeListM.appBusinessFeeListModel.count; i++) {
        
        AppBusinessFeeListModel *m = _GetAppBusinessFeeListM.appBusinessFeeListModel[i];
        
        // Label 容器宽度
        CGFloat contentWidth = ScreenWidth - 20 - 62 - 8;
        // Label 单行高度
        CGFloat oneLineHeight = [Tools getHeightOfString:@"fds" fontSize:14 andWidth:999.9];
        
        CGFloat overflowHeight = [Tools getHeightOfString:m.fEENAME fontSize:14 andWidth:contentWidth] - oneLineHeight;
        
        if(overflowHeight > 0) {
            
            m.cellHeight = kCellHeight + overflowHeight;
        } else {
            
            m.cellHeight = kCellHeight;
        }
        tableViewHeight += m.cellHeight;
    }
    _tableViewHeight = tableViewHeight;
    /*************  地址信息换行  *************/
    
    [_tableView reloadData];
}


- (void)failureOfGetAppBusinessFeeList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

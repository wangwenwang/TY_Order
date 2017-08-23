//
//  GetFeeListViewController.m
//  Order
//
//  Created by 凯东源 on 17/6/9.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetFeeListViewController.h"
#import "GetFeeListService.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "GetFeeListCollectionViewCell.h"
#import "Tools.h"
#import "HooDatePicker.h"
#import "MainViewController.h"

@interface GetFeeListViewController ()<GetFeeListServiceDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HooDatePickerDelegate>


@property (strong, nonatomic) GetFeeListService *service;

@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UICollectionView *tableView;

@property (strong, nonatomic) FeeListModel *feeListM;

@property (strong, nonatomic) NSMutableArray *cellHeights;

@property (assign, nonatomic) CGFloat kCellWidth0;

@property (assign, nonatomic) CGFloat kCellWidth1;

@property (assign, nonatomic) CGFloat kCellWidth2;

@property (assign, nonatomic) CGFloat kCellWidth3;

@property (nonatomic, strong) HooDatePicker *datePicker;

@property (copy, nonatomic) NSString *selected_yyyy_mm;

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//
//@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (assign, nonatomic) CGFloat xxx;

@end


#define kCellName @"GetFeeListCollectionViewCell"

//#define kCellWidth0 120
//
//#define kCellWidth1 270
//
//#define kCellWidth2 110
//
//#define kCellWidth3 120

#define kCollectionView_edge_x 10

#define kCollectionView_edge_y 10

// cell 最大宽度
#define kCollectionView_cell_max_width 300

// cell 最小宽度
#define kCollectionView_cell_min_width 120


@implementation GetFeeListViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[GetFeeListService alloc] init];
        _service.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _cellHeights = [[NSMutableArray alloc] init];
        [self initCellWidth];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service GetFeeList:_app.business.BUSINESS_IDX andPartyIdx:@"" andFeeDate:[Tools getCurrentDate_yyyy_mm] andstrPage:1 andstrPageCount:999];
    
    _selected_yyyy_mm = [self get_yyyy_mm:[Tools getCurrentDate_yyyy_mm]];
    
    [self scrollView];
    
    [self initDatePicker];
    
    // 禁止边缘返回
    [Tools interactivePopGestureRecognizer:self.navigationController andEnable:NO];
    
    [Tools addNavRightItemTypeText:self andAction:@selector(fd) andTitle:@"全屏"];
}


- (void)fd {
    
    [self UIInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
    [Tools addNavRightItemTypeText:self andAction:@selector(unFd) andTitle:@"退出全屏"];
}


- (void)unFd {
    
    [self UIInterfaceOrientation:UIInterfaceOrientationPortrait];
    
    [Tools addNavRightItemTypeText:self andAction:@selector(fd) andTitle:@"全屏"];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // 恢复边缘返回
    [Tools interactivePopGestureRecognizer:self.navigationController andEnable:YES];
    
    [self UIInterfaceOrientation:UIInterfaceOrientationPortrait];
}


- (void)UIInterfaceOrientation:(UIInterfaceOrientation)Portrait {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = Portrait;//这里可以改变旋转的方向
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
}


#pragma mark - 初始化界面

- (void)initCellWidth {
    
    _kCellWidth0 = kCollectionView_cell_min_width;
    _kCellWidth1 = 0;
    _kCellWidth2 = 0;
    _kCellWidth3 = 0;
}


- (void)initDatePicker {
    
    self.datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker.delegate = self;
    self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
    NSDate *minDate = [dateFormatter dateFromString:@"1993-01-01"];
    [self.datePicker setDate:[NSDate date] animated:YES];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
}


#pragma mark - FlatDatePicker Delegate

- (void)datePicker:(HooDatePicker *)datePicker dateDidChange:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    } else if (datePicker.datePickerMode == HooDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"yyyy-MM"]; //yyyy-MM
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
        
    }
    
//    NSString *value = [dateFormatter stringFromDate:date];
    
    //    self.labelDateSelected.text = value;
}

- (void)datePicker:(HooDatePicker *)datePicker didCancel:(UIButton *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关闭日期选择" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    } else if (datePicker.datePickerMode == HooDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"yyyy-MM"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    
    NSString *value = [dateFormatter stringFromDate:date];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service GetFeeList:_app.business.BUSINESS_IDX andPartyIdx:@"" andFeeDate:value andstrPage:1 andstrPageCount:999];
    
    _selected_yyyy_mm = [self get_yyyy_mm:value];
}


- (NSString *)get_yyyy_mm:(NSString *)yyyy_mm {
    
    NSString *year_month = @"";
    NSArray *array = [yyyy_mm componentsSeparatedByString:@"-"];
    
    if(array.count == 2) {
        
        year_month = [NSString stringWithFormat:@"%@年%@月", array[0], array[1]];
    }
    return year_month;
}


#pragma mark - GET方法

- (UIScrollView *)scrollView {
    
    if(!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        //        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        //        [_scrollView setFrame:CGRectMake(0, 0, 0, 0)];
        //        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    return _scrollView;
}


- (UIView *)contentView {
    
    if(!_contentView) {
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 10, 10));
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(400);
        }];
    }
    return _contentView;
}


- (UICollectionView *)tableView {
    
    _tableView = nil;
    
    if(!_tableView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _tableView  =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        [_scrollView addSubview:_tableView];
        //        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.edges.mas_offset(UIEdgeInsetsMake(80, 60, 0, 110));
        //            make.centerX.mas_equalTo(0);
        //            make.height.mas_equalTo(200);
        //        }];
        CGFloat x = kCollectionView_edge_x;
        CGFloat y = kCollectionView_edge_y;
        CGFloat width = _kCellWidth0 + _kCellWidth1 + _kCellWidth2 + _kCellWidth3;
        
        CGFloat cellHeight = 0;
        for (int i = 0; i < _cellHeights.count; i++) {
            
            cellHeight += [_cellHeights[i] integerValue];
        }
        CGFloat height = cellHeight;
        [_tableView setFrame:CGRectMake(x, y, width, height)];
        
        // 顶部线
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
        top.backgroundColor = [UIColor blackColor];
        [_tableView addSubview:top];
        
        // 左边线
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, height)];
        left.backgroundColor = top.backgroundColor;
        [_tableView addSubview:left];
        
    }
    return _tableView;
}


#pragma mark - 功能函数

- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil]forCellWithReuseIdentifier:kCellName];
}



#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _feeListM.feeModel.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GetFeeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellName forIndexPath:indexPath];
    NSLog(@"%ld, %ld",(long)indexPath.section , (long)indexPath.row);
    
    if(indexPath.section == 0 && indexPath.row == 0) {
        
        cell.titleLabel.textColor = [UIColor blueColor];
    } else {
        
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    
    if(indexPath.section == 0) {
        
        NSString *title = @"";
        switch (indexPath.row) {
            case 0:
                title = @"费用月份";
                break;
                
            case 1:
                title = @"活动名称";
                break;
                
            case 2:
                title = @"客户名称";
                break;
                
            case 3:
                title = @"费用（元）";
                break;
                
            default:
                break;
        }
        cell.titleLabel.text = title;
    } else {
        
        FeeModel *f = _feeListM.feeModel[indexPath.section];
        
        NSString *title = @"";
        switch (indexPath.row) {
            case 0:
                title = _selected_yyyy_mm;
                break;
                
            case 1:
                title = f.fEENAME;
                break;
                
            case 2:
                title = f.pARTYNAME;
                break;
                
            case 3:
                title = f.fEEAMOUNT;
                break;
                
            default:
                break;
        }
        if((indexPath.section == _feeListM.feeModel.count - 1) && indexPath.row == 0) {
            
            cell.titleLabel.text = @"";
        } else {
            
            cell.titleLabel.text = title;
        }
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0 && indexPath.row == 0) {
        
        [self.datePicker show];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat cellW = (ScreenWidth - 2) / 3;
    
    NSUInteger cellHeight = [_cellHeights[indexPath.section] integerValue];
    
    if(indexPath.row == 0) {
        
        return CGSizeMake(_kCellWidth0, cellHeight);
    } else if(indexPath.row == 1) {
        
        return CGSizeMake(_kCellWidth1, cellHeight);
    } else if(indexPath.row == 2) {
        
        return CGSizeMake(_kCellWidth2, cellHeight);
    } else if(indexPath.row == 3) {
        
        return CGSizeMake(_kCellWidth3, cellHeight);
    } else {
        
        return CGSizeMake(0, 0);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}


#pragma mark - GetFeeListServiceDelegate

- (void)successOfGetFeeList:(FeeListModel *)feeListM {
    
    // 清屏
    [self initCellWidth];
    [_tableView removeFromSuperview];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSUInteger listCount = feeListM.feeModel.count;
    
    if(listCount == 0) [Tools showAlert:self.view andTitle:@"没有这个月的数据"];
    
    _feeListM = feeListM;
    [_cellHeights removeAllObjects];
    
    if(listCount == 0) _feeListM.feeModel = [[NSMutableArray alloc] init];  // 如果没数据，显示表头
    
    FeeModel *fitstM = [[FeeModel alloc] init];
    [_feeListM.feeModel insertObject:fitstM atIndex:0];
    
    FeeModel *feeLastM = [[FeeModel alloc] init];
    CGFloat fEEAMOUNT_all = 0; // 费用总计
    for (int i = 0; i < _feeListM.feeModel.count; i++) {
        
        FeeModel *f = _feeListM.feeModel[i];
        fEEAMOUNT_all += [f.fEEAMOUNT floatValue];
    }
    
    // 有数据才返回表尾
    if(listCount > 0) {
        
        feeLastM.fEEAMOUNT = [NSString stringWithFormat:@"%.4f", fEEAMOUNT_all];
        feeLastM.pARTYNAME = @"合计";
        [_feeListM.feeModel addObject:feeLastM];
    }
    
    // 计算表格宽度
    for (int i = 0; i < _feeListM.feeModel.count; i++) {
        
        CGFloat cellWidth = 0;
        FeeModel *f = _feeListM.feeModel[i];
        
        if(i == 1) {
            
            //            f.pARTYNAME = @"fjsdkljsldj ksldjf sldkjf s;dlkfj s;lkfjs d;kfj sdklfjsdal;fjs dl;kfjsdlak;fjsfsdklfjksl;d埃里克森kfjsdsjkfjsd;lfjsdl;fjs;dklfjsnfdsfsdfdsfdjsf;dksjf;kjd;lfjfjs;kdlfj;";
            cellWidth = [Tools getWidthOfString:f.fEENAME fontSize:15];
            _kCellWidth1 = MAX(_kCellWidth1, cellWidth);
            _kCellWidth1 = (_kCellWidth1 > kCollectionView_cell_max_width) ? kCollectionView_cell_max_width : _kCellWidth1; // 小于最大值
            _kCellWidth1 = (_kCellWidth1 < kCollectionView_cell_min_width) ?  kCollectionView_cell_min_width : _kCellWidth1; // 大于最小值
        } else if(i == 2) {
            
            //            f.pARTYNAME = @"fjsdkljsldj ksldjf sldkjf s;dlkfj s;lkfjs d;kfj sdklfjsdal;fjs dl;kfjsdlak;fjsfsdklfjksl;dfjs;kdlfj;";
            cellWidth = [Tools getWidthOfString:f.pARTYNAME fontSize:15];
            _kCellWidth2 = MAX(_kCellWidth2, cellWidth);
            _kCellWidth2 = (_kCellWidth2 > kCollectionView_cell_max_width) ? kCollectionView_cell_max_width : _kCellWidth2;
            _kCellWidth2 = (_kCellWidth2 < kCollectionView_cell_min_width) ?  kCollectionView_cell_min_width : _kCellWidth2;
        } else if(i == 3) {
            
            cellWidth = [Tools getWidthOfString:f.fEEAMOUNT fontSize:15];
            _kCellWidth3 = MAX(_kCellWidth3, cellWidth);
            _kCellWidth3 = (_kCellWidth3 > kCollectionView_cell_max_width) ? kCollectionView_cell_max_width : _kCellWidth3;
            _kCellWidth3 = (_kCellWidth3 < kCollectionView_cell_min_width) ?  kCollectionView_cell_min_width : _kCellWidth3;
        }
    }
    
    // 计算表格高度
    CGFloat cellHeight_all = 0;
    
    for (int i = 0; i < _feeListM.feeModel.count; i++) {
        
        FeeModel *f = _feeListM.feeModel[i];
        
        // 活动名称
        CGFloat cellHeight1 = [Tools getHeightOfString:f.fEENAME fontSize:15 andWidth:_kCellWidth1];
        
        // 客户名称
        CGFloat cellHeight2 = [Tools getHeightOfString:f.pARTYNAME fontSize:15 andWidth:_kCellWidth2];
        
        CGFloat cellHeight = MAX(cellHeight1, cellHeight2);
        cellHeight = (cellHeight > 50) ? cellHeight : 50;
        
        // 总高度累计
        cellHeight_all += cellHeight;
        
        [_cellHeights addObject:@(cellHeight)];
    }
    
    // 重新设置 contentSize
    _scrollView.contentSize = CGSizeMake(_kCellWidth0 + _kCellWidth1 + _kCellWidth2 + _kCellWidth3 + kCollectionView_edge_x * 2 + 20, cellHeight_all + kCollectionView_edge_y * 2);
    
    [_scrollView addSubview:self.tableView];
    
    [self registerCell];
    
    // 重设tableView 宽度
    CGRect rect = _tableView.frame;
    rect.size.width = _kCellWidth0 + _kCellWidth1 + _kCellWidth2 + _kCellWidth3 + kCollectionView_edge_x * 2;
    [_tableView setFrame:rect];
    
    [_tableView reloadData];
}


- (void)failureOfGetFeeList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}

//- (BOOL)shouldAutorotate
//
//{
//    
//    return NO;
//    
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//
//{
//    
//    return UIInterfaceOrientationMaskLandscape;
//    
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//
//{
//    
//    return UIInterfaceOrientationLandscapeRight;
//    
//}

@end

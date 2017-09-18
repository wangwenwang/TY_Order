//
//  MainViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/27.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "MaincollectionViewCell.h"
#import "SearchOrderPathViewController.h"
#import "NewsViewController.h"
#import "HotProductViewController.h"
#import "ChartService.h"
#import "ChartViewController.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "GetStockListViewController.h"
#import "AppDelegate.h"
#import "GetFeeListViewController.h"
#import "CustomerListViewController.h"

@interface MainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ChartServiceDelegate>

/// Cell ID
@property (copy, nonatomic) NSString *cellID;

/// myCollectionView 数据
@property (strong, nonatomic) NSMutableArray *myCollectionDataArrM;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (strong, nonatomic) ChartService *chartService;

@property (strong, nonatomic) AppDelegate *app;

@end

@implementation MainViewController

- (instancetype)init {
    if(self = [super init]) {
        self.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"menu_index_unselected"];
        _cellID = @"myCollectionViewCellID";
        _myCollectionDataArrM = [[NSMutableArray alloc] init];
        _chartService = [[ChartService alloc] init];
        _chartService.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //获取plist数据
    [self getPlistData];
    
    //注册Cell
    [self registerCell];
    
    // 注册通知
    [self addNotification];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //添加广告轮播
    [self addCycleScrollView];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"首页";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 通知

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:kMainViewController_receiveMsg object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMainViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify{
    
    NSString *msg = aNotify.userInfo[@"msg"];
    [Tools showAlert:self.view andTitle:msg andTime:2.5];
}


#pragma mark - 私有方法

- (void)addCycleScrollView {
    
    NSArray *images = [NSArray arrayWithObjects:@"ad_pic_0.jpg", @"ad_pic_1.jpg", @"ad_pic_2.jpg", @"ad_pic_3.jpg", nil];
    
    // 本地加载图片的轮播器
    SDCycleScrollView *_cycleScrollView1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_cycleScrollView.frame)) imageNamesGroup:images];
    [self.view addSubview:_cycleScrollView1];
}

- (void)registerCell {
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell"bundle:nil]forCellWithReuseIdentifier:_cellID];
}

- (void)getPlistData {
    
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"MainCollection.plist" ofType:nil];
    _myCollectionDataArrM = [NSMutableArray arrayWithContentsOfFile:dataPath];
    
    if([_app.business.BUSINESS_IDX intValue] == 7 || [_app.business.BUSINESS_CODE rangeOfString:@"YIB"].length > 0 || [_app.business.BUSINESS_NAME rangeOfString:@"怡宝"].length > 0) {
        
    } else {
        
        if(_myCollectionDataArrM.count >= 7) {
            
            [_myCollectionDataArrM removeObjectAtIndex:6];
        }
    }
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _myCollectionDataArrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellID forIndexPath:indexPath];
    
    cell.titleLabel.text = _myCollectionDataArrM[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:_myCollectionDataArrM[indexPath.row][@"imageName"]];
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellW = (ScreenWidth - 2) / 3;
    return CGSizeMake(cellW, cellW);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld, %ld", (long)indexPath.section, (long)indexPath.row);
    
    NSString *title =  _myCollectionDataArrM[indexPath.row][@"title"];
    
    if([title isEqualToString:@"最新资讯"]) {
        
        [Tools showAlert:self.view andTitle:@"正在维护中..."];
    } else if([title isEqualToString:@"热销产品"]) {
        
        HotProductViewController *hotVC = [[HotProductViewController alloc] init];
        [self.navigationController pushViewController:hotVC animated:YES];
    } else if([title isEqualToString:@"查看报表"]) {
        
        ChartViewController *vc = [[ChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if([title isEqualToString:@"查看订单"]) {
        
        self.tabBarController.selectedIndex = 2;
    } else if(indexPath.row == 5) {
        
        GetStockListViewController *vc = [[GetStockListViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if([title isEqualToString:@"客户费用"]) {
        
        GetFeeListViewController *vc = [[GetFeeListViewController alloc] init];
        vc.title = title;
        
        //        [self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        //        CustomerListViewController *vc = [[CustomerListViewController alloc] init];
        //        vc.title = title;
        //        vc.vcClass = NSStringFromClass([self class]);
        //        [self.navigationController pushViewController:vc animated:YES];
    } else if([title isEqualToString:@"费用帐单"]) {
        
        CustomerListViewController *vc = [[CustomerListViewController alloc] init];
        vc.title = title;
        vc.vcClass = NSStringFromClass([self class]);
        vc.functionName = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if([title isEqualToString:@"库存管理"]) {
        
        CustomerListViewController *vc = [[CustomerListViewController alloc] init];
        vc.title = title;
        vc.vcClass = NSStringFromClass([self class]);
        vc.functionName = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//#pragma mark -- ChartServiceDelegate
////获取客户报表回调
//- (void)successOfChartServiceWithCustomer:(NSMutableArray *)customerChart {
//
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    ChartViewController *vc = [[ChartViewController alloc] init];
//    vc.arrM = customerChart;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)failureOfChartService:(NSString *)msg {
//
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [Tools showAlert:self.view andTitle:@"没有数据"];
//}

//获取产品报表回调

@end

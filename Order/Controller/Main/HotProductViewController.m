//
//  HotProductViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "HotProductViewController.h"
#import "HotProductTableViewCell.h"
#import "HotProductService.h"
#import "Tools.h"
#import "NSString+Trim.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD.h>

@interface HotProductViewController ()<UITableViewDataSource, UITableViewDelegate, HotProductServiceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) HotProductService *service;

@property (strong, nonatomic) NSArray *products;

@end

@implementation HotProductViewController

- (instancetype)init {
    if(self = [super init]) {
        _service = [[HotProductService alloc] init];
        _service.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"热销产品";
    
    [self registerCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_service getHotProductData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 私有方法
- (void)registerCell {
    [_myTableView registerNib:[UINib nibWithNibName:@"HotProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotProductTableViewCell"];
    
    _myTableView.separatorStyle = NO;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //界面处理
    static NSString *cellID = @"HotProductTableViewCell";
    HotProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    //数据处理
    NSDictionary *dict = _products[indexPath.row];
    NSString *productName = @"";
    double productPrice = 0;
    NSString *productDesc = @"";
    NSString *imageURL = [NSString stringWithFormat:@"%@/%@", API_ServerAddress, dict[@"PRODUCT_URL"]];
    @try {
        //过滤出产品名称
        productName = dict[@"PRODUCT_NAME"];
        NSArray *array = [productName componentsSeparatedByString:@","];
        if(array.count == 1) {
            array = [productName componentsSeparatedByString:@"，"];
        }
        //过渡出规格
        productName = (array.count > 0) ? array[0] : @"";
        productPrice = [dict[@"PRODUCT_PRICE"] doubleValue];
        productDesc = dict[@"PRODUCT_DESC"];
        productDesc = [productDesc stringByReplacingOccurrencesOfString:productName withString:@""];
        if(productDesc.length > 0) {
            NSString *first = [productDesc substringToIndex:1];
            if([first isEqualToString:@","] || [first isEqualToString:@"，"]) {
                productDesc = [productDesc substringFromIndex:1];
            }
        }
    } @catch (NSException *exception) {
    }
    
    //填充数据
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"ic_hot_sell_product"] options:SDWebImageRefreshCached];
    cell.nameLabel.text = productName;
    cell.formatLabel.text = productDesc;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%.1f", productPrice];
    
    //返回Cell
    return cell;
}

#pragma mark -- HotProductServiceDelegate
- (void)successOfHotProduct:(NSArray *)products {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _products = products;
    
    [_myTableView reloadData];
}

- (void)failureOfHotProduct:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"获取失败"];
}

@end

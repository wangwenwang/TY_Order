//
//  AddStockTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddStockTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AddStockCellTableViewCell.h"

@interface AddStockTableViewCell ()<AddStockCellTableViewCellDelegate>

// 产品图片
@property (weak, nonatomic) IBOutlet UIImageView *PRODUCT_URL;

// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

// 产品规格
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME2;

// 产品原价
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_PRICE;

// 库存数量
@property (weak, nonatomic) IBOutlet UITextField *PRODUCT_INVENTORY;

// 生产日期
@property (weak, nonatomic) IBOutlet UILabel *PRODUCTION_DATE;

// 生产日期 下划线
@property (weak, nonatomic) IBOutlet UIView *PRODUCTION_DATE_line;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


#define kCellHeight 81
#define kCellName @"AddStockCellTableViewCell"

@interface AddStockTableViewCell ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation AddStockTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self registerCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


// 注册Cell
- (void)registerCell {
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - SET方法

- (void)setProductM:(ProductModel *)productM {
    
    _productM = productM;
    
    if(_productM) {
        
        // 产品图片
        NSString *imageURL = [NSString stringWithFormat:@"%@/%@", API_SERVER_AUTOGRAPH_AND_PICTURE_FILE, _productM.PRODUCT_URL];
        [_PRODUCT_URL sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"ic_information_picture"]];
        
        // 产品名称
        _PRODUCT_NAME.text = [self getProductName:_productM.PRODUCT_NAME];
        
        // 产品规格
        _PRODUCT_NAME2.text = [self getProductFormat:_productM.PRODUCT_NAME];
        
        // 产品原价
        _PRODUCT_PRICE.text = [NSString stringWithFormat:@"￥%.1f", _productM.PRODUCT_PRICE];
        
        // 生产日期
        _PRODUCTION_DATE.text = productM.PRODUCTION_DATE;
        
        if([productM.PRODUCTION_DATE isEqualToString:@""]) {
            
            [_PRODUCTION_DATE_line setHidden:NO];
        } else {
            
            [_PRODUCTION_DATE_line setHidden:YES];
        }
    }
}


- (void)setProducts_cell_paty:(NSMutableArray *)products_cell_paty {
    
    _products_cell_paty = products_cell_paty;
    [_tableView reloadData];
}


#pragma mark - 功能函数

- (IBAction)addItem:(UIButton *)sender {
    
    _productM.cellHeight += kCellHeight;
    
    ProductModel *p = [[ProductModel alloc] init];
    p.IDX = _productM.IDX;
    p.PRODUCT_NO = _productM.PRODUCT_NO;
    p.PRODUCT_NAME = _productM.PRODUCT_NAME;
    
    [_products_cell_paty addObject:p];
    if([_delegate respondsToSelector:@selector(reloadData_LM)]) {
        
        [_delegate reloadData_LM];
    }
    [_tableView reloadData];
}


- (IBAction)deleteItem:(UIButton *)sender {
    
    if(_products_cell_paty.count <= 1) {
        
        return;
    }
    
    _productM.cellHeight -= kCellHeight;
    
    [_products_cell_paty removeLastObject];
    if([_delegate respondsToSelector:@selector(reloadData_LM)]) {
        
        [_delegate reloadData_LM];
    }
    [_tableView reloadData];
}


#pragma mark - 功能函数

// 获取产品名称，传入参数：ProductModel模型，PRODUCT_NAME变量
- (NSString *)getProductName:(NSString *)str {
    NSArray *array = [str componentsSeparatedByString:@","];
    
    if(array.count > 0) {
        return array[0];
    } else {
        return @"";
    }
}


// 获取产品规格，传入参数：ProductModel模型，PRODUCT_NAME变量
- (NSString *)getProductFormat:(NSString *)str {
    NSArray *array = [str componentsSeparatedByString:@","];
    
    if(array.count > 1) {
        return array[1];
    } else {
        return @"";
    }
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _products_cell_paty.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 处理界面
    static NSString *cellId = kCellName;
    AddStockCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    cell.products_cell_paty = _products_cell_paty;
    
    return cell;
}


- (void)PRODUCTION_DATE_onclick:(NSUInteger)indexRow {
    
    if([_delegate respondsToSelector:@selector(PRODUCTION_DATE_onclick:andIndex_in_paty:)]) {
        
        [_delegate PRODUCTION_DATE_onclick:self.tag andIndex_in_paty:indexRow];
    }
}

@end

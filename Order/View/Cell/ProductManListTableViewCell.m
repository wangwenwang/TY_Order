//
//  ProductManListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/6/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "ProductManListTableViewCell.h"

@interface ProductManListTableViewCell ()


// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

// 产品规格
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME2;

// 产品原价
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_PRICE;

// 库存数量
@property (weak, nonatomic) IBOutlet UITextField *PRODUCT_INVENTORY;

@end

@implementation ProductManListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _PRODUCT_INVENTORY.inputAccessoryView = [self addToolbar];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


- (void)setProductM:(ProductModel *)productM {
    
    _productM = productM;
    
    if(_productM) {
        
        // 产品名称
        _PRODUCT_NAME.text = [self getProductName:_productM.PRODUCT_NAME];
        
        // 产品规格
        _PRODUCT_NAME2.text = [self getProductFormat:_productM.PRODUCT_NAME];
        
        // 产品原价
        _PRODUCT_PRICE.text = [NSString stringWithFormat:@"￥%.1f", _productM.PRODUCT_PRICE];
    }
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


- (UIToolbar *)addToolbar {
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor blueColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}


// 收回键盘
- (void)textFieldDone {
    
    [self endEditing:YES];
    
    [self customize:[_PRODUCT_INVENTORY.text longLongValue]];
}


// 回调库存
- (void)customize:(long long)selectedNumber {
    
    if([_delegate respondsToSelector:@selector(PRODUCT_INVENTORY_NumberOnclick:andIndexRow:)]) {
        
        [_delegate PRODUCT_INVENTORY_NumberOnclick:selectedNumber andIndexRow:self.tag];
    }
}

@end

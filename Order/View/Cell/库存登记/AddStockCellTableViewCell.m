//
//  AddStockCellTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/6/9.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddStockCellTableViewCell.h"

@interface AddStockCellTableViewCell ()

// 库存数量
@property (weak, nonatomic) IBOutlet UITextField *STOCK_QTY;

// 生产日期
@property (weak, nonatomic) IBOutlet UILabel *PRODUCTION_DATE;

// 生产日期 下划线
@property (weak, nonatomic) IBOutlet UIView *PRODUCTION_DATE_line;

@end

@implementation AddStockCellTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _STOCK_QTY.inputAccessoryView = [self addToolbar];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


#pragma mark - SET方法

- (void)setProducts_cell_paty:(NSMutableArray *)products_cell_paty {
    
    _products_cell_paty = products_cell_paty;
    
    ProductModel *p = _products_cell_paty[self.tag];
    
    // 生产日期
    _PRODUCTION_DATE.text = p.PRODUCTION_DATE;
    
    if([p.PRODUCTION_DATE isEqualToString:@""]) {
        
        [_PRODUCTION_DATE_line setHidden:NO];
    } else {
        
        [_PRODUCTION_DATE_line setHidden:YES];
    }
}


- (UIToolbar *)addToolbar {
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 35)];
    UIColor *LM_bg = RGB(80, 80, 80);
    toolbar.tintColor = RGB(40, 100, 241);
    toolbar.backgroundColor = LM_bg;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}


// 收回键盘
- (void)textFieldDone {
    
    [self endEditing:YES];
}


#pragma mark - 事件

- (IBAction)STOCK_QTY_editingChanged:(UITextField *)sender {
    
    ProductModel *productM = _products_cell_paty[self.tag];
    productM.STOCK_QTY = [_STOCK_QTY.text longLongValue];
}

- (IBAction)PRODUCTION_DATE_onclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(PRODUCTION_DATE_onclick:)]) {
        
        [_delegate PRODUCTION_DATE_onclick:self.tag];
    }
}

@end

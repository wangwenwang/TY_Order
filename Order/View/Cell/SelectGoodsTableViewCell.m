//
//  SelectGoodsTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SelectGoodsTableViewCell.h"
#import "ProductPolicyTableViewCell.h"
#import "ProductPolicyModel.h"

@interface SelectGoodsTableViewCell ()<UITableViewDelegate, UITableViewDataSource>


// Cell本身高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productViewHeight;

@end


@implementation SelectGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ProductPolicyTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProductPolicyTableViewCell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _policys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ProductPolicyTableViewCell";
    ProductPolicyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    ProductPolicyModel *m = _policys[indexPath.row];
    
    cell.policyTextLabel.text = m.POLICY_NAME;
    
    return cell;
    
}


#pragma mark - SET方法

- (void)setPolicys:(NSMutableArray *)policys {
    
    _policys = policys;
    
    [_myTableView reloadData];
}


- (void)setSelfHeight:(float)selfHeight {
    
    _productViewHeight.constant = selfHeight;
}


- (IBAction)delNumberOnclick:(UIButton *)sender {
    
    if(_product.CHOICED_SIZE > 0) {
        _product.CHOICED_SIZE --;
        NSString *productNumberStr = [NSString stringWithFormat:@"%lld", _product.CHOICED_SIZE];
        
        [_productNumberButton setTitle:productNumberStr forState:UIControlStateNormal];
        if([_delegate respondsToSelector:@selector(delNumberOnclick:andIndexRow:andSection:)]) {
            [_delegate delNumberOnclick:_product.PRODUCT_PRICE andIndexRow:(int)self.tag andSection:self.section];
        }
    }
}

- (IBAction)addNumberOnclick:(UIButton *)sender {
    
    if([_product.ISINVENTORY isEqualToString:@"Y"]) {
        long long maxSize = _product.PRODUCT_INVENTORY;
        if(_product.CHOICED_SIZE < maxSize) {
            [self add];
        } else {
            if([_delegate respondsToSelector:@selector(noStockOfSelectGoodsTableViewCell)]) {
                [_delegate noStockOfSelectGoodsTableViewCell];
            }
        }
    } else {
        [self add];
    }
}

- (void)add {
    _product.CHOICED_SIZE ++;
    NSString *productNumberStr = [NSString stringWithFormat:@"%lld", _product.CHOICED_SIZE];
    [_productNumberButton setTitle:productNumberStr forState:UIControlStateNormal];
    if([_delegate respondsToSelector:@selector(addNumberOnclick:andIndexRow:andSection:)]) {
        [_delegate addNumberOnclick:_product.PRODUCT_PRICE andIndexRow:(int)self.tag andSection:self.section];
    }
}

- (IBAction)productNumberOnclick:(UIButton *)sender {
    
//    long long selectedNumber = [[_productNumberButton titleForState:UIControlStateNormal] longLongValue];
//    
//    if([_delegate respondsToSelector:@selector(productNumberOnclick:andIndexRow:andSelectedNumber:)]) {
//        [_delegate productNumberOnclick:_product.PRODUCT_PRICE andIndexRow:(int)self.tag andSelectedNumber:selectedNumber];
//    }
    
    long long selectedNumber = [[_productNumberButton titleForState:UIControlStateNormal] longLongValue];
    if([_product.ISINVENTORY isEqualToString:@"Y"]) {
        
        long long maxSize = _product.PRODUCT_INVENTORY;
        if(selectedNumber <= maxSize) {
            
            [self customize:selectedNumber];
        } else {
            if([_delegate respondsToSelector:@selector(noStockOfSelectGoodsTableViewCell)]) {
                [_delegate noStockOfSelectGoodsTableViewCell];
            }
        }
    } else {
        
        [self customize:selectedNumber];
    }
}

- (void)customize:(long long)selectedNumber {
    if([_delegate respondsToSelector:@selector(productNumberOnclick:andIndexRow:andSelectedNumber:andSection:)]) {
        [_delegate productNumberOnclick:_product.PRODUCT_PRICE andIndexRow:(int)self.tag andSelectedNumber:selectedNumber andSection:self.section];
    }
}

@end

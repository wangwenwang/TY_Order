//
//  Store_GetOutProductListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "Store_GetOutProductListTableViewCell.h"

@interface Store_GetOutProductListTableViewCell ()

// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

@end

@implementation Store_GetOutProductListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setStoreProductM:(StoreProductModel *)storeProductM {
    
    _PRODUCT_NAME.text = storeProductM.pRODUCTNAME;
}

@end

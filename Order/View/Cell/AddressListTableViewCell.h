//
//  AddressListTableViewCell.h
//  Order
//
//  Created by 凯东源 on 17/7/5.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@protocol AddressListTableViewCellDelegate <NSObject>

/// 编辑地址
- (void)editOnclick:(NSUInteger)row;

/// 默认地址
- (void)defauleAddressOnclick:(NSUInteger)row;

/// 删除地址
- (void)deleteOnclick:(NSUInteger)row;

@end


@interface AddressListTableViewCell : UITableViewCell


@property (weak, nonatomic) id <AddressListTableViewCellDelegate> delegate;

@property (strong, nonatomic) AddressModel *addressM;

@end

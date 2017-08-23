//
//  SelectedGiftsTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectedGiftsTableViewCellDelegate <NSObject>

@optional
- (void)delNumberOnclick:(NSInteger)indexRow;

@optional
- (void)addNumberOnclick:(NSInteger)indexRow;

@optional
- (void)productNumberOnclick:(NSInteger)indexRow;

@end

@interface SelectedGiftsTableViewCell : UITableViewCell

@property (weak, nonatomic) id <SelectedGiftsTableViewCellDelegate> delegate;

//产品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//产品数量
@property (weak, nonatomic) IBOutlet UIButton *numberButton;

@end

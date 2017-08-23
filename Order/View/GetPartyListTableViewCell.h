//
//  GetPartyListTableViewCell.h
//  Order
//
//  Created by 凯东源 on 17/7/13.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyModel.h"

@protocol GetPartyListTableViewCellDelegate <NSObject>

/// 删除地址
- (void)deleteOnclick:(NSUInteger)row;

@end

@interface GetPartyListTableViewCell : UITableViewCell


@property (weak, nonatomic) id <GetPartyListTableViewCellDelegate> delegate;

@property (strong, nonatomic) PartyModel *partyM;

@end

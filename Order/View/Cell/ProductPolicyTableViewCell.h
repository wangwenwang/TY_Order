//
//  ProductPolicyTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/15.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductPolicyTableViewCell : UITableViewCell

/// 促销图片
@property (weak, nonatomic) IBOutlet UIImageView *policyImageView;

/// 促销信息
@property (weak, nonatomic) IBOutlet UILabel *policyTextLabel;

@end

//
//  OrderGiftModel.h
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGiftModel : NSObject<NSCopying>

@property(copy, nonatomic)NSString *TYPE_NAME;

@property(assign, nonatomic)double QTY;

@property(assign, nonatomic)double PRICE;

@property(assign, nonatomic)double choiceCount;

@property(assign, nonatomic)BOOL isChecked;

- (void)setDict:(NSDictionary *)dict;

@end

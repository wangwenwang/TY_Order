//
//  NormalAdressListService.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalAdressListModel.h"

@protocol NormalAdressListServiceDelegate <NSObject>

@optional
- (void)successOfNormalAdressList:(NormalAdressListModel *)NormalAdressListM;

@optional
- (void)successOfNormalAdressListNoData:(NSString *)msg;

@optional
- (void)failureOfNormalAdressList:(NSString *)msg;

@end

@interface NormalAdressListService : NSObject

@property (weak, nonatomic) id <NormalAdressListServiceDelegate> delegate;


- (void)NormalAdressList:(NSString *)strPrentCode;

@end

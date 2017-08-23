//
//  AddressModel.h
//  Order
//
//  Created by 凯东源 on 16/10/13.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 客户地址
@interface AddressModel : NSObject

@property(copy, nonatomic)NSString *IDX;

@property(copy, nonatomic)NSString *ADDRESS_CODE;

@property(copy, nonatomic)NSString *ADDRESS_ALIAS;

@property(copy, nonatomic)NSString *ADDRESS_REGION;

@property(copy, nonatomic)NSString *ADDRESS_ZIP;

@property(copy, nonatomic)NSString *ADDRESS_INFO;

@property(copy, nonatomic)NSString *CONTACT_PERSON;

@property(copy, nonatomic)NSString *CONTACT_TEL;

@property(copy, nonatomic)NSString *CONTACT_FAX;

@property(copy, nonatomic)NSString *CONTACT_SMS;

@property(copy, nonatomic)NSString *ADDRESS_REMARK;

@property(copy, nonatomic)NSString *COORDINATE;

- (void)setDict:(NSDictionary *)dict;

@property (assign, nonatomic) BOOL defaultAddress;

@property(assign, nonatomic)float cellHeight;

@property(assign, nonatomic)float allCellHeight;

@end

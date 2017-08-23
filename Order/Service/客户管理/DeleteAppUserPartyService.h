//
//  DeleteAppUserPartyService.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeleteAppUserPartyServiceDelegate <NSObject>

@optional
- (void)successOfDeleteAppUserParty:(NSString *)msg;

@optional
- (void)failureOfDeleteAppUserParty:(NSString *)msg;

@end

@interface DeleteAppUserPartyService : NSObject

@property (weak, nonatomic) id <DeleteAppUserPartyServiceDelegate> delegate;


- (void)DeleteAppUserParty:(NSString *)strUserId andstrPartyId:(NSString *)strPartyId;

@end

//
//  NormalAdressListModel.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalAdressModel.h"



//{"type":"1","msg":"获取成功","NormalAdressModel":[{"ITEM_IDX":"120000",
//    
//    "ITEM_NAME":"天津"},
//                                              
//    {"ITEM_IDX":"130000",
//        
//        "ITEM_NAME":"河北省"},
//                                              
//    {"ITEM_IDX":"150000",
//        
//        "ITEM_NAME":"内蒙古自治区"},
//                                              
//    {"ITEM_IDX":"210000",
//        
//        "ITEM_NAME":"辽宁省"},
//                                              
//    {"ITEM_IDX":"110000",
//        
//        "ITEM_NAME":"北京"},
//                                              
//    {"ITEM_IDX":"140000",
//        
//        "ITEM_NAME":"山西省"},
//                                              
//    {"ITEM_IDX":"440000",
//        
//        "ITEM_NAME":"广东省"},
//                                              
//    {"ITEM_IDX":"310000",
//        
//        "ITEM_NAME":"上海"},
//                                              
//    {"ITEM_IDX":"350000",
//        
//        "ITEM_NAME":"福建省"},
//                                              
//    {"ITEM_IDX":"320000",
//        
//        "ITEM_NAME":"江苏省"},
//                                              
//    {"ITEM_IDX":"340000",
//        
//        "ITEM_NAME":"安徽省"},
//                                              
//    {"ITEM_IDX":"220000",
//        
//        "ITEM_NAME":"吉林省"},
//                                              
//    {"ITEM_IDX":"230000",
//        
//        "ITEM_NAME":"黑龙江省"},
//                                              
//    {"ITEM_IDX":"330000",
//        
//        "ITEM_NAME":"浙江省"},
//                                              
//    {"ITEM_IDX":"360000",
//        
//        "ITEM_NAME":"江西省"},
//                                              
//    {"ITEM_IDX":"420000", 
//        
//        "ITEM_NAME":"湖北省"},
//                                              
//    {"ITEM_IDX":"430000", 
//        
//        "ITEM_NAME":"湖南省"},
//                                              
//    {"ITEM_IDX":"370000", 
//        
//        "ITEM_NAME":"山东省"},
//                                              
//    {"ITEM_IDX":"410000", 
//        
//        "ITEM_NAME":"河南省"},
//                                              
//    {"ITEM_IDX":"450000", 
//        
//        "ITEM_NAME":"广西壮族自治区"},
//                                              
//    {"ITEM_IDX":"540000", 
//        
//        "ITEM_NAME":"西藏自治区"},
//                                              
//    {"ITEM_IDX":"510000", 
//        
//        "ITEM_NAME":"四川省"},
//                                              
//    {"ITEM_IDX":"500000", 
//        
//        "ITEM_NAME":"重庆"},
//                                              
//    {"ITEM_IDX":"460000", 
//        
//        "ITEM_NAME":"海南省"},
//                                              
//    {"ITEM_IDX":"520000", 
//        
//        "ITEM_NAME":"贵州省"},
//                                              
//    {"ITEM_IDX":"530000", 
//        
//        "ITEM_NAME":"云南省"},
//                                              
//    {"ITEM_IDX":"610000", 
//        
//        "ITEM_NAME":"陕西省"},
//                                              
//    {"ITEM_IDX":"620000", 
//        
//        "ITEM_NAME":"甘肃省"},
//                                              
//    {"ITEM_IDX":"640000", 
//        
//        "ITEM_NAME":"宁夏回族自治区"},
//                                              
//    {"ITEM_IDX":"650000", 
//        
//        "ITEM_NAME":"新疆维吾尔自治区"},
//                                              
//    {"ITEM_IDX":"710000", 
//        
//        "ITEM_NAME":"台湾"},
//                                              
//    {"ITEM_IDX":"630000", 
//        
//        "ITEM_NAME":"青海省"},
//                                              
//    {"ITEM_IDX":"810000", 
//        
//        "ITEM_NAME":"香港特别行政区"},
//                                              
//    {"ITEM_IDX":"820000", 
//        
//        "ITEM_NAME":"澳门特别行政区"}]}


@interface NormalAdressListModel : NSObject

@property (nonatomic, strong) NSArray * normalAdressModel;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

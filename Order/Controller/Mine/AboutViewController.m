//
//  AboutViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/29.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *text = @"       可以直接通过手机app向企业发送订单，实时查看订单处于发货、运输、到货等之间的哪个环节，通过手机app可以查看企业发布的促销等信息，使得客户及时得到企业的优惠。与传统手工模式相比，大大减少了中间的人力。使得企业和客户能够实时跟踪货物信息，更加高效的管理货物的运输，提高客户对企业的认可度。";
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    label.font = font;

    CGFloat width = ScreenWidth - 20;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{ NSFontAttributeName: font }];
    CGRect labelRect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX } options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    label.bounds = CGRectMake(0 , 0, labelRect.size.width, labelRect.size.height); label.text = text; [self.view addSubview:label];
    label.center = CGPointMake(ScreenWidth / 2, (ScreenHeight - 64 - 50) / 2);
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

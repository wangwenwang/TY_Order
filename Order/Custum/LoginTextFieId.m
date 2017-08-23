//
//  LoginTextFieId.m
//  CMClient
//
//  Created by 凯东源 on 17/2/24.
//  Copyright © 2017年 城马联盟. All rights reserved.
//

#import "LoginTextFieId.h"

@implementation LoginTextFieId

/*
ly override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        
        self.alpha = 1;
        self.layer.cornerRadius = 3.0f;
        self.textColor = RGB(51, 51, 51);
        self.backgroundColor = [UIColor clearColor];
//        [self setValue:[UIColor colorWithRed:166 / 255.0 green:232 / 255.0 blue:184 / 255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
       [self setValue:RGB(157, 157, 157) forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

@end

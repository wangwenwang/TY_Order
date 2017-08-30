//
//  ChangePasswordViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/29.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "NSString+Trim.h"
#import "Tools.h"
#import "ChangePasswordService.h"
#import <MBProgressHUD.h>
#import "UIViewController+BackButtonHandler.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()<ChangePasswordServiceDelatate>

@property (weak, nonatomic) IBOutlet UITextField *oldPwdT;

@property (weak, nonatomic) IBOutlet UITextField *pwdT;

@property (weak, nonatomic) IBOutlet UITextField *rePwdT;

@property (strong, nonatomic) ChangePasswordService *service;

- (IBAction)commitOnclick:(UIButton *)sender;

@end

@implementation ChangePasswordViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[ChangePasswordService alloc] init];
        
        _service.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    self.title = @"修改密码";
    
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (IBAction)commitOnclick:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString *oldPwd = [_oldPwdT.text trim];
    NSString *newPwd = [_pwdT.text trim];
    NSString *reNewPwd = [_rePwdT.text trim];
    
    if([Tools isConnectionAvailable]) {
        if(![oldPwd isEmpty]) {
            if(![newPwd isEmpty]) {
                if(![reNewPwd isEmpty]) {
                    if([newPwd isEqualToString:reNewPwd]) {
                        if(reNewPwd.length >= 6) {
                            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            [_service changePassword:oldPwd andNewPassword:reNewPwd];
                        }else {
                          [Tools showAlert:self.view andTitle:@"密码不能小于6位数!"];
                        }
                    }else {
                        [Tools showAlert:self.view andTitle:@"两次新密码不一致!"];
                    }
                }else {
                    [Tools showAlert:self.view andTitle:@"请确认新密码!"];
                }
            }else {
                [Tools showAlert:self.view andTitle:@"请输入新密码!"];
            }
        }else {
            [Tools showAlert:self.view andTitle:@"请输入原密码!"];
        }
    }else {
        [Tools showAlert:self.view andTitle:@"网络不可用"];
    }
}


- (void)successOfChangePassword {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:@"修改成功" andTime:2];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LoginViewController *vc = [[LoginViewController alloc] init];
            vc.clearPwd = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [Tools setRootViewControllerWithCrossDissolve:self.view.window andViewController:nav];
        });
    });
}


- (void)failureOfChangePassword:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg ? msg : @"修改失败"];
}

@end

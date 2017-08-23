//
//  RegisterViewController.m
//  CMClient
//
//  Created by 凯东源 on 17/1/14.
//  Copyright © 2017年 城马联盟. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterService.h"
#import "Tools.h"
#import <MBProgressHUD.h>
#import "LoginTextFieId.h"
#import "LoginButton.h"
#import "AreaProvinceViewController.h"
#import "AppDelegate.h"
#import "NormalAdressListViewController.h"

@interface RegisterViewController ()<RegisterServiceDelegate> {
    
    AppDelegate *_app;
}

// 手机号
@property (weak, nonatomic) IBOutlet LoginTextFieId *phoneNumF;

// 密码
@property (weak, nonatomic) IBOutlet LoginTextFieId *passwordF;

// 确认密码
@property (weak, nonatomic) IBOutlet LoginTextFieId *rePasswordF;

// 真实姓名
@property (weak, nonatomic) IBOutlet LoginTextFieId *nameF;

// 确认按钮
@property (weak, nonatomic) IBOutlet LoginButton *commitBtn;

// 点击注册
- (IBAction)registerOnclick:(UIButton *)sender;

// scrollContentView 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

@property (strong, nonatomic) RegisterService *service;

// 客户名称
@property (weak, nonatomic) IBOutlet UITextField *PARTY_NAME;

// 地址人名
@property (weak, nonatomic) IBOutlet UITextField *CONTACT_PERSON;

// 地址电话
@property (weak, nonatomic) IBOutlet LoginTextFieId *CONTACT_TEL;

// 详细地址（选择）
@property (strong, nonatomic) LM_A_B_C_D *a_b_c_d;

// 详细地址（选择）
@property (weak, nonatomic) IBOutlet UILabel *ADDRESS_INFO;

// 详细地址（填写）
@property (weak, nonatomic) IBOutlet LoginTextFieId *ADDRESS_ADDRESS;

@end


@implementation RegisterViewController

- (instancetype)init {
    
    if(self = [super init]) {
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _service = [[RegisterService alloc] init];
        _service.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self addNotification];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    //    _scrollContentViewHeight.constant = CGRectGetMaxY(_commitBtn.frame) + 20;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 通知

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:kAdd_AddressViewController_receiveMsg object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAdd_AddressViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify {
    
    LM_A_B_C_D *msg = aNotify.userInfo[@"msg"];
    
    _a_b_c_d = msg;
    
    _ADDRESS_INFO.text = [NSString stringWithFormat:@"%@%@%@%@", _a_b_c_d.A.iTEMNAME, _a_b_c_d.B.iTEMNAME, _a_b_c_d.C.iTEMNAME, _a_b_c_d.D.iTEMNAME];
}


- (void)reloadData:(NSNotification *)aNotifica {
    
    _ADDRESS_INFO.text = aNotifica.userInfo[@"city"];
}


#pragma mark - 事件
- (IBAction)registerOnclick:(UIButton *)sender {
    
    // 如果用户没输入电话号码 就点击注册按钮，弹出键盘让用户输入电话号码
    if([_phoneNumF.textTrim isEqualToString:@""]) {
        
        [_phoneNumF becomeFirstResponder];
        return;
    }
    
    // 两次密码要一致，并且不能为空
    if(![_passwordF.textTrim isEqualToString:@""]) {
        
        if(![_rePasswordF.textTrim isEqualToString:@""]) {
            
            if([_passwordF.textTrim isEqualToString:_rePasswordF.textTrim] ) {
                
                if(![_nameF.textTrim isEqualToString:@""]) {
                    
                    if(![_PARTY_NAME.textTrim isEqualToString:@""]) {
                        
                        if(![_CONTACT_PERSON.textTrim isEqualToString:@""]) {
                            
                            if(![_CONTACT_TEL.textTrim isEqualToString:@""]) {
                                
                                if(_a_b_c_d) {
                                    
                                    if(![_ADDRESS_ADDRESS.textTrim isEqualToString:@""]) {
                                        
                                        [self.view endEditing:YES];
                                        
                                        NSString *a = _a_b_c_d.A.iTEMIDX;
                                        NSString *b = _a_b_c_d.B.iTEMIDX;
                                        NSString *c = _a_b_c_d.C.iTEMIDX;
                                        NSString *d = _a_b_c_d.D.iTEMIDX;
                                        NSString *e = [NSString stringWithFormat:@"%@%@%@%@%@", _a_b_c_d.A.iTEMNAME, _a_b_c_d.B.iTEMNAME, _a_b_c_d.C.iTEMNAME, _a_b_c_d.D.iTEMNAME, _ADDRESS_ADDRESS.textTrim];
                                        
                                        [_service registerX:_nameF.textTrim andstrPwd:_passwordF.textTrim andstrUserCode:_phoneNumF.textTrim andPARTY_NAME:_PARTY_NAME.textTrim andPARTY_CITY:_a_b_c_d.B.iTEMNAME andCONTACT_PERSON:_CONTACT_PERSON.textTrim andCONTACT_TEL:_CONTACT_TEL.textTrim andPARTY_REMARK:@"" andADDRESS_PROVINCE:a and:b andADDRESS_AREA:c andADDRESS_RURAL:d andADDRESS_ADDRESS:_ADDRESS_ADDRESS.textTrim andADDRESS_INFO:e];
                                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                    } else {
                                        
                                        [Tools showAlert:self.view andTitle:@"详细地址不能为空"];
                                    }
                                } else {
                                    
                                    [Tools showAlert:self.view andTitle:@"地址区域不能为空"];
                                }
                            } else {
                                
                                [Tools showAlert:self.view andTitle:@"地址联系电话不能为空"];
                            }
                        } else {
                            
                            [Tools showAlert:self.view andTitle:@"地址名称不能为空"];
                        }
                    } else {
                        
                        [Tools showAlert:self.view andTitle:@"客户名称不能为空"];
                    }
                } else {
                    
                    [Tools showAlert:self.view andTitle:@"真实姓名不能为空"];
                }
            } else {
                
                [Tools showAlert:self.view andTitle:@"密码不一致"];
            }
        } else {
            
            [Tools showAlert:self.view andTitle:@"请确认密码"];
        }
    } else {
        
        [Tools showAlert:self.view andTitle:@"请输入密码"];
    }
}


- (IBAction)addressOnclick:(UITapGestureRecognizer *)sender {
    
    NormalAdressListViewController *vc = [[NormalAdressListViewController alloc] init];
    vc.LM_CODE = @"A";
    vc.strPrentCode = @"0";
    [self.navigationController pushViewController:vc animated:YES];
    
    //    AreaProvinceViewController *vc = [[AreaProvinceViewController alloc] init];
    //
    //    //nav导航
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //    [self presentViewController:nav animated:YES completion:nil];
    
}


- (IBAction)textFieldDidChange:(LoginTextFieId *)sender {
    
    if (_phoneNumF.text.length > 11) {
        
        _phoneNumF.text = [_phoneNumF.text substringToIndex:11];
    }
}


#pragma mark - RegisterServiceDelegate

- (void)successOfRegister {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginViewController_receiveMsg object:nil userInfo:@{@"msg" : @"注册成功"}];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)failureOfRegister:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

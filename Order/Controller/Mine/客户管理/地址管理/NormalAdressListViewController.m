//
//  NormalAdressListViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "NormalAdressListViewController.h"
#import "NormalAdressListService.h"
#import <MBProgressHUD.h>
#import "Tools.h"
#import "Add_AddressViewController.h"
#import "RegisterViewController.h"
#import "NormalAdressModel.h"
#import "AddPartyViewController.h"

@interface NormalAdressListViewController ()<NormalAdressListServiceDelegate, UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NormalAdressListService *service;

@property (strong, nonatomic) NormalAdressListModel *NormalAdressListM;

@end


#define kCellName @"fdscellid"

#define kCellHeight 44


@implementation NormalAdressListViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[NormalAdressListService alloc] init];
        _service.delegate = self;
        
        _lm_a_b_c_d = [[LM_A_B_C_D alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if([_LM_CODE isEqualToString:@"A"]) {
        
        self.title = @"省";
        [_service NormalAdressList:_strPrentCode];
    } else if([_LM_CODE isEqualToString:@"B"]) {
        
        self.title = @"市";
        [_service NormalAdressList:_strPrentCode];
    } else if([_LM_CODE isEqualToString:@"C"]) {
        
        self.title = @"区/县";
        [_service NormalAdressList:_strPrentCode];
    } else if([_LM_CODE isEqualToString:@"D"]) {
        
        self.title = @"街道/镇";
        [_service NormalAdressList:_strPrentCode];
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _NormalAdressListM.normalAdressModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = kCellName;
    
    NormalAdressModel *m = _NormalAdressListM.normalAdressModel[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = m.iTEMNAME;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NormalAdressModel *m = _NormalAdressListM.normalAdressModel[indexPath.row];
    
    NormalAdressListViewController *vc = [[NormalAdressListViewController alloc] init];
    NSString *LM_CODE = @"";
    if([_LM_CODE isEqualToString:@"A"]) {
        
        LM_CODE = @"B";
        _lm_a_b_c_d.A = m;
        NSLog(@"");
    } else if([_LM_CODE isEqualToString:@"B"]) {
        
        LM_CODE = @"C";
        _lm_a_b_c_d.B = m;
        NSLog(@"");
    } else if([_LM_CODE isEqualToString:@"C"]) {
        
        LM_CODE = @"D";
        _lm_a_b_c_d.C = m;
    } else if([_LM_CODE isEqualToString:@"D"]) {
        
         _lm_a_b_c_d.D = m;
        
        for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
            
            UIViewController *vc = self.navigationController.viewControllers[i];
            NSLog(@"---%@", [vc class]);
            
            if([vc isKindOfClass:[Add_AddressViewController class]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kAdd_AddressViewController_receiveMsg object:nil userInfo:@{@"msg" : _lm_a_b_c_d}];
                
                [self.navigationController popToViewController:vc animated:YES];
                
                break;
            } else if([vc isKindOfClass:[RegisterViewController class]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kAdd_AddressViewController_receiveMsg object:nil userInfo:@{@"msg" : _lm_a_b_c_d}];
                
                [self.navigationController popToViewController:vc animated:YES];
                
                break;
            } else if([vc isKindOfClass:[AddPartyViewController class]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kAdd_AddressViewController_receiveMsg object:nil userInfo:@{@"msg" : _lm_a_b_c_d}];
                
                [self.navigationController popToViewController:vc animated:YES];
                
                break;
            }
        }
    }
    vc.strPrentCode = m.iTEMIDX;
    vc.LM_CODE = LM_CODE;
    vc.lm_a_b_c_d = _lm_a_b_c_d;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - NormalAdressListServiceDelegate

- (void)successOfNormalAdressList:(NormalAdressListModel *)NormalAdressListM {
    
    _NormalAdressListM = NormalAdressListM;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_tableView reloadData];
}


- (void)successOfNormalAdressListNoData:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}


- (void)failureOfNormalAdressList:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

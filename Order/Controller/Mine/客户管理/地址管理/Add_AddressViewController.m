//
//  Add_AddressViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "Add_AddressViewController.h"
#import "AreaProvinceViewController.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import "AddAddressService.h"
#import "Tools.h"
#import "NormalAdressListViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "UpdateAddressService.h"
#import <ContactsUI/ContactsUI.h>

@interface Add_AddressViewController ()<ABPeoplePickerNavigationControllerDelegate, AddAddressServiceDelegate, UpdateAddressServiceDelegate, CNContactPickerDelegate>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

// 收货人
@property (weak, nonatomic) IBOutlet UITextField *nameF;


// 联系方式
@property (weak, nonatomic) IBOutlet UITextField *telF;


// 所在地区
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;


// 详细地址
@property (weak, nonatomic) IBOutlet UITextField *detailAddressLabel;


// 网络层
@property (strong, nonatomic) AddAddressService *service;

// 全局变量
@property (strong, nonatomic) AppDelegate *app;

// 详细地址
@property (strong, nonatomic) LM_A_B_C_D *a_b_c_d;

// 网络层
@property (strong, nonatomic) UpdateAddressService *service_update;

@end

@implementation Add_AddressViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[AddAddressService alloc] init];
        _service.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        _service_update = [[UpdateAddressService alloc] init];
        _service_update.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"新建收货人";
    
    [self initUI];
    
    [self addNotification];
    
    _scrollContentViewHeight.constant = ScreenHeight - 64;
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGetPartyListViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify {
    
    LM_A_B_C_D *msg = aNotify.userInfo[@"msg"];
    
    _a_b_c_d = msg;
    
    _areaLabel.text = [NSString stringWithFormat:@"%@%@%@%@", _a_b_c_d.A.iTEMNAME, _a_b_c_d.B.iTEMNAME, _a_b_c_d.C.iTEMNAME, _a_b_c_d.D.iTEMNAME];
}


#pragma mark - 功能方法

- (void)initUI {
    
    _areaLabel.text = @"";
    
    _nameF.text = _addressM.CONTACT_PERSON;
    
    _telF.text = _addressM.CONTACT_TEL;
    
    //    _areaLabel.text = ;
    
    _detailAddressLabel.text = _addressM.ADDRESS_INFO;
}


#pragma mark - 事件

- (IBAction)saveOnclick {
    
    //    _addressM.CONTACT_PERSON = _nameF.text;
    //
    //    _addressM.CONTACT_TEL = _telF.text;
    //
    //    _addressM.ADDRESS_REGION = _areaLabel.text;
    //
    //    _addressM.ADDRESS_INFO = _detailAddressLabel.text;
    
    // 编辑
    if(_addressM) {
        
        NSString *a = [NSString stringWithFormat:@"%@%@%@%@%@", _a_b_c_d.A.iTEMNAME, _a_b_c_d.B.iTEMNAME, _a_b_c_d.C.iTEMNAME, _a_b_c_d.D.iTEMNAME, _detailAddressLabel.textTrim];
        
        if(![_areaLabel.text isEqualToString:@""]) {
            
            if(![_detailAddressLabel.textTrim isEqualToString:@""]) {
                
                if(![_nameF.textTrim isEqualToString:@""]) {
                    
                    if(![_telF.textTrim isEqualToString:@""]) {
                        
                        if(_a_b_c_d) {
                            
                            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            
                            [_service_update UpdateAddress:_app.user.IDX andADDRESS_IDX:_addressM.IDX andADDRESS_INFO:a andADDRESS_PROVINCE:_a_b_c_d.A.iTEMIDX andADDRESS_CITY:_a_b_c_d.B.iTEMIDX andADDRESS_AREA:_a_b_c_d.C.iTEMIDX andADDRESS_RURAL:_a_b_c_d.D.iTEMIDX andADDRESS_ADDRESS:_detailAddressLabel.textTrim andCONTACT_PERSON:_nameF.textTrim andCONTACT_TEL:_telF.textTrim];
                        } else {
                            
                            [Tools showAlert:self.view andTitle:@"所在地区不能为空"];
                        }
                    } else {
                        
                        [Tools showAlert:self.view andTitle:@"收货人电话不能为空"];
                    }
                } else {
                    
                    [Tools showAlert:self.view andTitle:@"收货人名称不能为空"];
                }
            } else {
                
                [Tools showAlert:self.view andTitle:@"详细地址不能为空"];
            }
        } else {
            
            [Tools showAlert:self.view andTitle:@"所在区域不能为空"];
        }
    }
    
    // 添加
    else {
        
        NSString *a = [NSString stringWithFormat:@"%@%@%@%@%@", _a_b_c_d.A.iTEMNAME, _a_b_c_d.B.iTEMNAME, _a_b_c_d.C.iTEMNAME, _a_b_c_d.D.iTEMNAME, _detailAddressLabel.textTrim];
        
        if(![_areaLabel.text isEqualToString:@""]) {
            
            if(![_detailAddressLabel.textTrim isEqualToString:@""]) {
                
                if(![_nameF.textTrim isEqualToString:@""]) {
                    
                    if(![_telF.textTrim isEqualToString:@""]) {
                        
                        if(_a_b_c_d) {
                            
                            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            
                            [_service AddAddress:_app.user.IDX andPARTY_IDX:_party.IDX andADDRESS_CODE:_party.PARTY_CODE andADDRESS_PROVINCE:_a_b_c_d.A.iTEMIDX andADDRESS_CITY:_a_b_c_d.B.iTEMIDX andADDRESS_AREA:_a_b_c_d.C.iTEMIDX andADDRESS_RURAL:_a_b_c_d.D.iTEMIDX andADDRESS_ADDRESS:_detailAddressLabel.textTrim andCONTACT_PERSON:_nameF.textTrim andCONTACT_TEL:_telF.textTrim andADDRESS_INFO:a];
                        } else {
                            
                            [Tools showAlert:self.view andTitle:@"所在地区不能为空"];
                        }
                    } else {
                        
                        [Tools showAlert:self.view andTitle:@"收货人电话不能为空"];
                    }
                } else {
                    
                    [Tools showAlert:self.view andTitle:@"收货人名称不能为空"];
                }
            } else {
                
                [Tools showAlert:self.view andTitle:@"详细地址不能为空"];
            }
        } else {
            
            [Tools showAlert:self.view andTitle:@"所在区域不能为空"];
        }
    }
}


#pragma mark - 手势

- (IBAction)areaOnclick:(UITapGestureRecognizer *)sender {
    
    //    AreaProvinceViewController *vc = [[AreaProvinceViewController alloc] init];
    //
    //    //nav导航
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //    [self presentViewController:nav animated:YES completion:nil];
    
    NormalAdressListViewController *vc = [[NormalAdressListViewController alloc] init];
    vc.LM_CODE = @"A";
    vc.strPrentCode = @"0";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)contactOnclick:(UITapGestureRecognizer *)sender {
    
    if(SystemVersion >= 10.0){
        //iOS 10
        //    AB_DEPRECATED("Use CNContactPickerViewController from ContactsUI.framework instead")
        CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
        contactVc.delegate = self;
        [self presentViewController:contactVc animated:YES completion:^{
            
        }];
    } else {
        
        ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
        nav.peoplePickerDelegate = self;
        if(SystemVersion > 8.0){
            nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        }
        [self presentViewController:nav animated:YES completion:nil];
    }
}


#pragma mark - iOS 10 联系人选择

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    NSString *givenName = contactProperty.contact.givenName;
    NSString *familyName = contactProperty.contact.familyName;
    NSString *fullName = [NSString stringWithFormat:@"%@%@", givenName, familyName];
    
    NSString *tel = [contactProperty.value stringValue];
    tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    _nameF.text = fullName;
    _telF.text = tel;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - iOS 10以下 联系人选择

// 选择联系人某个属性时调用（展开详情）
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString *fir = CFBridgingRelease(firstName);
    NSString *las = CFBridgingRelease(lastName);
    
    NSString *fullName = [NSString stringWithFormat:@"%@%@", las ? las : @"", fir ? fir : @""];
    
    ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSString *tel = (__bridge_transfer NSString *)  ABMultiValueCopyValueAtIndex(multi, identifier);
    tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    _nameF.text = fullName;
    _telF.text = tel;
    
    NSLog(@"");
}


#pragma mark - AddAddressServiceDelegate

- (void)successOfAddAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddressListViewController_receiveMsg object:nil userInfo:@{@"msg" : msg}];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)failureOfAddAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - UpdateAddressServiceDelegate

- (void)successOfUpdateAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddressListViewController_receiveMsg object:nil userInfo:@{@"msg" : msg}];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)failureOfUpdateAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

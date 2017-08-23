//
//  AddPartyViewController.m
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddPartyViewController.h"
#import "AddPartyService.h"
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import "Tools.h"
#import "AddAddressService.h"
#import "LM_A_B_C_D.h"
#import "NormalAdressListViewController.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import <ContactsUI/ContactsUI.h>

@interface AddPartyViewController ()<AddPartyServiceDelegate, AddAddressServiceDelegate, ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate>

/************ 添加客户 ************/

// 客户名称
@property (weak, nonatomic) IBOutlet UITextField *PARTY_NAME;

// 备注
@property (weak, nonatomic) IBOutlet UITextField *PARTY_REMARK;

// 网络层
@property (strong, nonatomic) AddPartyService *service;

// 全局变量
@property (strong, nonatomic) AppDelegate *app;

// 容器高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

// AddPartyM
@property (strong, nonatomic) AddPartyModel *AddPartyM;



/************ 添加地址 ************/

// 收货人
@property (weak, nonatomic) IBOutlet UITextField *nameF;


// 联系方式
@property (weak, nonatomic) IBOutlet UITextField *telF;


// 所在地区
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;


// 详细地址
@property (weak, nonatomic) IBOutlet UITextField *detailAddressLabel;


// 网络层
@property (strong, nonatomic) AddAddressService *service_addAddress;

// 详细地址
@property (strong, nonatomic) LM_A_B_C_D *a_b_c_d;

@end


@implementation AddPartyViewController


- (instancetype)init {
    
    if(self = [super init]) {
        
        _service = [[AddPartyService alloc] init];
        _service.delegate = self;
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        _service_addAddress = [[AddAddressService alloc] init];
        _service_addAddress.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"新建客户";
    
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


#pragma mark - 功能函数

- (void)initUI {
    
    _areaLabel.text = @"";
}


- (void)saveAddress {
    
    NSString *a = [NSString stringWithFormat:@"%@%@%@%@%@", _a_b_c_d.A.iTEMNAME, _a_b_c_d.B.iTEMNAME, _a_b_c_d.C.iTEMNAME, _a_b_c_d.D.iTEMNAME, _detailAddressLabel.textTrim];
    
    if(![_areaLabel.text isEqualToString:@""]) {
        
        if(![_detailAddressLabel.textTrim isEqualToString:@""]) {
            
            if(![_nameF.textTrim isEqualToString:@""]) {
                
                if(![_telF.textTrim isEqualToString:@""]) {
                    
                    if(_a_b_c_d) {
                        
                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        
                        [_service_addAddress AddAddress:_app.user.IDX andPARTY_IDX:_AddPartyM.iDX andADDRESS_CODE:_AddPartyM.strPartyCode andADDRESS_PROVINCE:_a_b_c_d.A.iTEMIDX andADDRESS_CITY:_a_b_c_d.B.iTEMIDX andADDRESS_AREA:_a_b_c_d.C.iTEMIDX andADDRESS_RURAL:_a_b_c_d.D.iTEMIDX andADDRESS_ADDRESS:_detailAddressLabel.textTrim andCONTACT_PERSON:_nameF.textTrim andCONTACT_TEL:_telF.textTrim andADDRESS_INFO:a];
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


#pragma mark - 事件

- (IBAction)saveOnclick:(UIButton *)sender {
    
    
    if(![_PARTY_NAME.textTrim isEqualToString:@""]) {
        
        if(![_areaLabel.text isEqualToString:@""]) {
            
            if(![_detailAddressLabel.textTrim isEqualToString:@""]) {
                
                if(![_nameF.textTrim isEqualToString:@""]) {
                    
                    if(![_telF.textTrim isEqualToString:@""]) {
                        
                        if(_a_b_c_d) {
                            
                            [self.view endEditing:YES];
                            
                            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            
                            [_service AddParty:_app.user.IDX andPARTY_NAME:_PARTY_NAME.textTrim andPARTY_CITY:@" " andPARTY_REMARK:_PARTY_REMARK.textTrim];
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
    } else {
        
        [Tools showAlert:self.view andTitle:@"客户名称不能为空"];
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


#pragma mark - AddPartyServiceDelegate

- (void)successOfAddParty:(NSString *)msg andAddPartyM:(AddPartyModel *)AddPartyM {
    
    _AddPartyM = AddPartyM;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self saveAddress];
}


- (void)failureOfAddParty:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}


#pragma mark - AddAddressServiceDelegate

- (void)successOfAddAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetPartyListViewController_receiveMsg object:nil userInfo:@{@"msg" : @"客户创建成功!"}];
        [self.navigationController popViewControllerAnimated:YES];
    });
}


- (void)failureOfAddAddress:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [Tools showAlert:self.view andTitle:msg];
}

@end

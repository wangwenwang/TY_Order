//
//  LoginViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/26.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "NSString+Trim.h"
#import "Tools.h"
#import <MBProgressHUD.h>
#import "MainViewController.h"
#import "MakeOrderViewController.h"
#import "MineViewController.h"
#import "AppDelegate.h"
#import "WMPageController.h"
#import "OrderingViewController.h"
#import "OrderFinishViewController.h"
#import "OrderCancelViewController.h"

#import "ConfirmOrderViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<LoginServiceDelegate, UIAlertViewDelegate>

// 帐号
@property (weak, nonatomic) IBOutlet UITextField *userNameT;

// 密码
@property (weak, nonatomic) IBOutlet UITextField *pswT;

// 网络操作层
@property (strong, nonatomic) LoginService *service;

// 全局变量
@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) NSMutableArray *business;

- (IBAction)loginOnclick:(UIButton *)sender;

@end

@implementation LoginViewController

#pragma mark - 生命周期
- (instancetype)init {
    self = [super init];
    if (self) {
        _service = [[LoginService alloc] init];
        _service.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _business = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self addNotification];
    
    //填充上一次登录成功的帐号密码
    [self setUserNameAndPassword];
    
    [self.view layoutIfNeeded];
    
    //帐号
    UIImageView *uImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetHeight(_userNameT.frame) - 12, CGRectGetHeight(_userNameT.frame) - 10)];
    uImage.image = [UIImage imageNamed:@"user"];
    _userNameT.leftViewMode = UITextFieldViewModeAlways;
    _userNameT.leftView = uImage;
    
    //密码
    UIImageView *pswImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, CGRectGetHeight(_pswT.frame) - 10, CGRectGetHeight(_pswT.frame) - 10)];
    pswImage.image = [UIImage imageNamed:@"lock"];
    _pswT.leftViewMode = UITextFieldViewModeAlways;
    _pswT.leftView = pswImage;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
    [self removeNotification];
}


#pragma mark - 通知

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:kLoginViewController_receiveMsg object:nil];
}


- (void)removeNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginViewController_receiveMsg object:nil];
}


- (void)receiveMsg:(NSNotification *)aNotify {
    
    _userNameT.text = @"";
    
    _pswT.text = @"";
    
    NSString *msg = aNotify.userInfo[@"msg"];
    [Tools showAlert:self.view andTitle:msg andTime:2.5];
}


#pragma mark - 点击事件

/// 登录
- (IBAction)loginOnclick:(UIButton *)sender {
    
//    ConfirmOrderViewController *vc = [[ConfirmOrderViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
//#if DEBUG
//    [self successOfLogin];
//#else
    
    NSString *userName = [_userNameT.text trim];
    NSString *pwd = [_pswT.text trim];
    
    if(![userName isEmpty]) {
        if(![pwd isEmpty]) {
            if([Tools isConnectionAvailable]) {
                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [self.view endEditing:YES];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                   
                    usleep(300000); // 解决键盘还没收回，就弹alert，然后alert选择完又弹键盘问题
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [_service login:userName andPsw:pwd];
                    });
                });
            }else {
                [Tools showAlert:self.view andTitle:@"网络不可用"];
            }
        }else {
            [Tools showAlert:self.view andTitle:@"请输入密码"];
        }
    }else {
        [Tools showAlert:self.view andTitle:@"请输入用户名"];
    }
//#endif
}


#pragma mark - 私有方法

// 填充上一次登录成功的帐号密码
- (void)setUserNameAndPassword {
    
    NSString *a = [[NSUserDefaults standardUserDefaults] objectForKey:udUserName];
    NSString *b = [[NSUserDefaults standardUserDefaults] objectForKey:udPassWord];
    
    if(a && b) {
        
        _userNameT.text = a;
        if(!_clearPwd) _pswT.text = b;
    }
}

- (WMPageController *)p_defaultController {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [OrderingViewController class];
                title = @"在途";
                break;
            case 1:
                vcClass = [OrderFinishViewController class];
                title = @"已完成";
                break;
            default:
                vcClass = [OrderCancelViewController class];
                title = @"已取消";
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.menuItemWidth = 85;
    pageVC.menuHeight = CheckOrderViewControllerMenuHeight;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}

#pragma mark - LoginServiceDelegate

- (void)successOfLogin {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //4个子控制器
    MainViewController *mainVC =[[MainViewController alloc] init];
    MakeOrderViewController *makeVC = [[MakeOrderViewController alloc] init];
    //    WMPageController *checkVC = [[WMPageController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    UINavigationController *mainVC_nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    UINavigationController *makeVC_nav = [[UINavigationController alloc] initWithRootViewController:makeVC];
    UINavigationController *mineVC_nav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    
    WMPageController *pageController = [self p_defaultController];
    // 下划线
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    pageController.selectIndex = 0;
    
    
    UINavigationController *pageController_nav = [[UINavigationController alloc] initWithRootViewController:pageController];
    
    
    //
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.tabBar.tintColor = TYColor;
//    tbc.viewControllers = @[mainVC_nav, makeVC_nav, pageController_nav, mineVC_nav];
    tbc.viewControllers = @[mainVC, makeVC, pageController, mineVC];
    
    //导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tbc];
    
    //切换根控制器
    [Tools setRootViewControllerWithFlipFromRight:_app.window andViewController:nav];
}

- (void)successOfLoginSelectBusinss:(NSMutableArray *)business {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _business = business;
    if(business.count == 1) {
        [self saveBusiness:business[0]];
    }else if(business.count > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择业务类型" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        alert.delegate = self;
        
        for(int i = 0; i < business.count; i++) {
            NSDictionary *dict = business[i];
            NSString *title = dict[@"BUSINESS_NAME"];
            [alert addButtonWithTitle:title];
        }
        [alert show];
    }else {
        [Tools showAlert:self.view andTitle:@"没有业务哦"];
    }
    
}

- (void)failureOfLogin:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:msg];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex:%ld", (long)buttonIndex);
    
    
    
    if(buttonIndex == 0) {
        nil;  //点击取消， 不操作
    }else {
        NSDictionary *dict;
        if(_business.count > 1) {
            dict = _business[buttonIndex - 1];
        }
        [self saveBusiness:dict];
    }
}

- (void)saveBusiness:(NSDictionary *)dict {
    _app.business.BUSINESS_IDX = dict[@"BUSINESS_IDX"];
    _app.business.BUSINESS_CODE = dict[@"BUSINESS_CODE"];
    _app.business.BUSINESS_NAME = dict[@"BUSINESS_NAME"];
    
    if([_app.business.BUSINESS_IDX intValue] == 48 || [_app.business.BUSINESS_CODE rangeOfString:@"QH"].length > 0 || [_app.business.BUSINESS_NAME rangeOfString:@"前海"].length > 0) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"QH" forKey:kWelcomeImageName];
    } else if([_app.business.BUSINESS_IDX intValue] == 7 || [_app.business.BUSINESS_CODE rangeOfString:@"YIB"].length > 0 || [_app.business.BUSINESS_NAME rangeOfString:@"怡宝"].length > 0) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"YIB" forKey:kWelcomeImageName];
    } else if([_app.business.BUSINESS_IDX intValue] == 40 || [_app.business.BUSINESS_CODE rangeOfString:@"DK"].length > 0 || [_app.business.BUSINESS_NAME rangeOfString:@"鼎葵"].length > 0) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"DK" forKey:kWelcomeImageName];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self successOfLogin];
}


- (IBAction)registerOnclick:(UIButton *)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

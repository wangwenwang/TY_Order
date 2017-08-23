//
//  MineViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/27.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "AppDelegate.h"
#import "Tools.h"
#import "AboutViewController.h"
#import "ChangePasswordViewController.h"
#import "LoginViewController.h"
#import "AddressListViewController.h"
#import <objc/runtime.h>
//#import "CustomerListViewController.h"
#import "GetPartyListViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

// Plist数据
@property (strong, nonatomic) NSMutableArray *myTableViewArrM;

@property (copy, nonatomic) NSString *cellID;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) AppDelegate *app;

- (IBAction)changeAccountOnclick:(UIButton *)sender;

// 顶部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

// 底部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;

@end


#define kCellHeight 44

@implementation MineViewController

- (instancetype)init {
    if(self = [super init]) {
        self.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"menu_mine_unselected"];
        _myTableViewArrM = [[NSMutableArray alloc] init];
        _cellID = @"MineTableViewCell";
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //获取Plist数据
    [self getPlistData];
    
    //注册Cell
    [self registerCell];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"我的";
}


- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    _scrollContentViewHeight.constant = _topViewHeight.constant + _myTableViewArrM.count * kCellHeight + _bottomViewHeight.constant;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 私有方法

- (void)getPlistData {
    
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"MineTable.plist" ofType:nil];
    _myTableViewArrM = [NSMutableArray arrayWithContentsOfFile:dataPath];
    
    // 只有鼎葵宝山仓才有此功能
    if(![_app.business.BUSINESS_CODE isEqualToString:@"DKI06"]) {
        
        NSUInteger count = _myTableViewArrM.count;
        for (int i = 0; i < count; i++) {
            
            NSDictionary *dict = _myTableViewArrM[i];
            NSString *title = dict[@"title"];
            if([title isEqualToString:@"客户管理"]) {
                
                [_myTableViewArrM removeObjectAtIndex:i];
                
                break;
            }
        }
    }
}


- (void)registerCell {
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:_cellID];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myTableViewArrM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"MineTableViewCell";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:_myTableViewArrM[indexPath.row][@"imageName"]];
    
    NSString *prompt = _myTableViewArrM[indexPath.row][@"title"];
    cell.promptLabel.text = prompt;
    
    if([prompt isEqualToString:@"用户姓名："]) {
        
        cell.titleLabel.text = _app.user.USER_NAME;
    } else if([prompt isEqualToString:@"用户角色："]) {
        
        cell.titleLabel.text = [Tools getRoleName:_app.user.USER_TYPE] ;
    } else if([prompt isEqualToString:@"业务类型："]) {
        
        cell.titleLabel.text = _app.business.BUSINESS_NAME;
    } else if([prompt isEqualToString:@"修改密码"]) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = @"";
    } else if([prompt isEqualToString:@"客户管理"]) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = @"";
    } else if([prompt isEqualToString:@"版本号：     "]) {
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.titleLabel.text = [NSString stringWithFormat:@"V %@", version];
    } else if([prompt isEqualToString:@"关于"]) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = @"";
    } else {
        
        cell.titleLabel.text = @"";
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *prompt = _myTableViewArrM[indexPath.row][@"title"];
    
    if([prompt isEqualToString:@"修改密码"]) {
        
        ChangePasswordViewController *cpVC = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:cpVC animated:YES];
    } else if([prompt isEqualToString:@"客户管理"]) {
        
        GetPartyListViewController *vc = [[GetPartyListViewController alloc] init];
        vc.title = prompt;
//        vc.vcClass = NSStringFromClass([self class]);
        [self.navigationController pushViewController:vc animated:YES];
    } else if([prompt isEqualToString:@"关于"]) {
        
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}


- (IBAction)changeAccountOnclick:(UIButton *)sender {
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [Tools setRootViewControllerWithCrossDissolve:_app.window andViewController:nav];
}

@end

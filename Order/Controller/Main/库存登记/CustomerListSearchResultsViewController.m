//
//  CustomerListSearchResultsViewController.m
//  Order
//
//  Created by 凯东源 on 17/6/5.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "CustomerListSearchResultsViewController.h"
#import "MakeOrderTableViewCell.h"
#import "PartyModel.h"
#import "AddStockViewController.h"
#import "CustomerListViewController.h"
#import "GetStockListViewController.h"
#import "MainViewController.h"
#import "GetAppBillFeeListViewController.h"

@interface CustomerListSearchResultsViewController ()

@end

#define kCellName @"MakeOrderTableViewCell"

@implementation CustomerListSearchResultsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:kCellName bundle:nil] forCellReuseIdentifier:kCellName];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSLog(@"result viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 95.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.searchDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = kCellName;
    MakeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    PartyModel *m = _searchDataArray[indexPath.row];
    cell.customerTypeLabel.text = m.PARTY_TYPE;
    cell.customerCodeLabel.text = m.PARTY_CODE;
    cell.customerCityLabel.text = m.PARTY_CITY;
    cell.customerNameLabel.text = m.PARTY_NAME;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PartyModel *party = _searchDataArray[indexPath.row];
    
    if([_vcClass isEqualToString:NSStringFromClass([GetStockListViewController class])]) {
        
        AddStockViewController *vc = [[AddStockViewController alloc] init];
        vc.partyM = party;
        [self.navigationController pushViewController:vc animated:YES];
    } else if([_vcClass isEqualToString:NSStringFromClass([MainViewController class])]) {
        
        GetAppBillFeeListViewController *vc = [[GetAppBillFeeListViewController alloc] init];
        vc.PARTY_IDX = party.IDX;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)dealloc {
    
    NSLog(@"result dealloc");
}

@end

//
//  OrderProgressNodeViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/12.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderProgressNodeViewController.h"
#import "OrderProgressNodeTableViewCell.h"
#import "StateTackModel.h"
#import "Tools.h"

@interface OrderProgressNodeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation OrderProgressNodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单进度";
    
    [self registerCell];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)registerCell {
    [_myTableView registerNib:[UINib nibWithNibName:@"OrderProgressNodeTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderProgressNodeTableViewCell"];
    _myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _stateTacks.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"OrderProgressNodeTableViewCell";
    OrderProgressNodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    StateTackModel *m = _stateTacks[indexPath.row];
    cell.statusLabel.text =[Tools getOrderState:m.ORDER_STATE];
    cell.dateLabel.text = m.STATE_TIME;
    
    return cell;
}


- (void)viewDidLayoutSubviews {
    
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end

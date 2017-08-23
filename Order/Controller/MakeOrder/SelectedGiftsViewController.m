//
//  SelectedGiftsViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SelectedGiftsViewController.h"
#import "SelectedGiftsTableViewCell.h"
#import "PromotionDetailModel.h"
#import "OrderGiftModel.h"
#import "Tools.h"

@interface SelectedGiftsViewController ()<UITableViewDelegate, UITableViewDataSource, SelectedGiftsTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//遮罩视图
@property (weak, nonatomic) IBOutlet UIView *coverView;

//自定义数量视图
@property (weak, nonatomic) IBOutlet UIView *customizNumberView;

//输入自定义数量
@property (weak, nonatomic) IBOutlet UITextField *cusmotizeNumber;

//取消自定义数量
- (IBAction)cancelCustomizeNumberOnclick:(UIButton *)sender;

//确定自定义数量
- (IBAction)confirmCustomizeNumberOnclick:(UIButton *)sender;

//自定义数量的indexRow
@property (assign, nonatomic) NSInteger customizeNumberIndexRow;

@end

@implementation SelectedGiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"已选赠品";
    
    [self registerCell];
    
    [self addKvo];
    
    [self initUI];
}

- (void)initUI {
    _customizNumberView.hidden = YES;
}

- (void)addKvo {
    [_customizNumberView addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _customizNumberView  && [keyPath isEqualToString:@"hidden"]) {
        BOOL isHidden = [change[@"new"] boolValue];
        _coverView.hidden = isHidden;
    }
    
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 私有方法
/// 注册Cell
- (void)registerCell {
    [_myTableView registerNib:[UINib nibWithNibName:@"SelectedGiftsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectedGiftsTableViewCell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _gifts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"SelectedGiftsTableViewCell";
    SelectedGiftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    PromotionDetailModel *m = _gifts[indexPath.row]
    ;

    cell.nameLabel.text = m.PRODUCT_NAME;
    [cell.numberButton setTitle:[NSString stringWithFormat:@"%lld" ,m.PO_QTY] forState:UIControlStateNormal];
    
    return cell;
}



#pragma mark -- SelectedGiftsTableViewCellDelegate
- (void)delNumberOnclick:(NSInteger)indexRow {
    PromotionDetailModel *m = _gifts[indexRow];
    if(m.PO_QTY < 1) {
        return;
    }
    
    m.PO_QTY--;
    
    int _typeIndexRow = [self findTypeIndexRow:m];
    
    //返回赠品数量
    OrderGiftModel *giftType = _giftTypes[_typeIndexRow];
    giftType.choiceCount --;
    
    //是否考虑库存
    if([m.LOTTABLE09 isEqualToString:@"Y"]) {
        m.LOTTABLE11 ++;
    }
    
    //删除已选的产品
    if(m.PO_QTY == 0) {
        [_gifts removeObject:m];
    }
    
    [_myTableView reloadData];
}

- (void)addNumberOnclick:(NSInteger)indexRow {
    //库存不足
    PromotionDetailModel *m = _gifts[indexRow];
    if([m.LOTTABLE09 isEqualToString:@"Y"] && m.LOTTABLE11 < 1) {
        [Tools showAlert:self.view andTitle:@"仓库剩余库存不足!"];
        return;
    }
    
    int _typeIndexRow = [self findTypeIndexRow:m];
    
    //赠品已选满
    OrderGiftModel *giftType = _giftTypes[_typeIndexRow];
    if([Tools getDouble:giftType.choiceCount] >= giftType.QTY) {
        [Tools showAlert:self.view andTitle:@"超出当前赠品可选数额"];
        return;
    } else {
        giftType.choiceCount ++;
    }
    
    //保存已选的产品，或刷新购物车数据
    if([_gifts indexOfObject:m] == NSNotFound) {
        [_gifts addObject:m];
    } else {
        //购物车与列表的Model用同一块内存，所以不用再次刷新
    }
    
    //是否考虑库存
    if([m.LOTTABLE09 isEqualToString:@"Y"]) {
        m.LOTTABLE11 --;
    }
    
    m.PO_QTY ++;
    
    [_myTableView reloadData];
}

- (void)productNumberOnclick:(NSInteger)indexRow {
    //处理输入框
    [_cusmotizeNumber becomeFirstResponder];
    _cusmotizeNumber.text = @"";
    _customizeNumberIndexRow = indexRow;
    _customizNumberView.hidden = NO;
}

- (int)findTypeIndexRow:(PromotionDetailModel *)m {
    //寻找_typeIndexRow
    int _typeIndexRow = 0;
    for(int i = 0; i < _dictPromotionDetails.count; i++) {
        NSMutableArray *promotionDetails = _dictPromotionDetails[@(i)];
        
        if(!([promotionDetails indexOfObject:m] == NSNotFound)) {
            _typeIndexRow = i;
            break;
        }
    }
    return _typeIndexRow;
}



#pragma mark -- 点击事件
- (IBAction)confirmCustomizeNumberOnclick:(UIButton *)sender {
    [self.view endEditing:YES];
    _customizNumberView.hidden = YES;
    
    long long number = [_cusmotizeNumber.text longLongValue];
    //赠品数据
    PromotionDetailModel *m = _gifts[_customizeNumberIndexRow];
    
    int _typeIndexRow = [self findTypeIndexRow:m];
    //品类数据
    OrderGiftModel *giftType = _giftTypes[_typeIndexRow];
    //改变是数量，有可能为负数
    long long changeCount = number - m.PO_QTY;
    
    //库存不足
    if([m.LOTTABLE09 isEqualToString:@"Y"] && m.LOTTABLE11 < changeCount) {
        [Tools showAlert:self.view andTitle:@"仓库剩余库存不足!"];
        return;
    }
    
    //赠品已选满
    if([Tools getDouble:giftType.choiceCount] + changeCount > giftType.QTY) {
        [Tools showAlert:self.view andTitle:@"超出当前赠品可选数额"];
        return;
    } else {
        giftType.choiceCount += changeCount;
    }
    
    m.PO_QTY += changeCount;
    
    //是否考虑库存
    if([m.LOTTABLE09 isEqualToString:@"Y"]) {
        m.LOTTABLE11 -= changeCount;
    }
    
    //保存已选的产品，或刷新购物车数据
    if([_gifts indexOfObject:m] == NSNotFound) {
        [_gifts addObject:m];
    } else {
        //购物车与列表的Model用同一块内存，所以不用再次刷新
    }
    
    //删除已选的产品
    if(m.PO_QTY == 0) {
        [_gifts removeObject:m];
    }
    
    [_myTableView reloadData];
}

- (IBAction)cancelCustomizeNumberOnclick:(UIButton *)sender {
    [self.view endEditing:YES];
    _customizNumberView.hidden = YES;
}

- (void)dealloc {
    
    [_customizNumberView removeObserver:self forKeyPath:@"hidden"];
}


@end

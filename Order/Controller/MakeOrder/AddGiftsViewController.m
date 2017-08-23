//
//  AddGiftsViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "AddGiftsViewController.h"
#import "AddGiftTypesTableViewCell.h"
#import "AddGiftProductsTableViewCell.h"
#import "OrderGiftModel.h"
#import "PromotionDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductModel.h"
#import "Tools.h"
#import "AddGiftsService.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SelectedGiftsViewController.h"

@interface AddGiftsViewController ()<UITableViewDelegate, UITableViewDataSource, AddGiftProductsTableViewCellDelegate, AddGiftsServiceDelegate>

//品类TableView
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;

//产品TableView
@property (weak, nonatomic) IBOutlet UITableView *productTableView;

//品类在Table中的下标
@property (assign, nonatomic) NSInteger typeIndexRow;

//已经选择的赠品
@property (strong, nonatomic) NSMutableArray *selectedGifts;

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

//可选数量（全品类总数）
@property (weak, nonatomic) IBOutlet UILabel *canChoiceNumber;

//已选数量（全品类总数）
@property (weak, nonatomic) IBOutlet UILabel *choicedNumber;

@property (strong, nonatomic) AddGiftsService *addGiftsService;

@property (strong, nonatomic) AppDelegate *app;

//重选
- (IBAction)resetChoiceOnclick:(UITapGestureRecognizer *)sender;

//详情（购物车）
- (IBAction)detailOnclick:(UITapGestureRecognizer *)sender;

@property (strong, nonatomic) NSMutableDictionary *dictCopy;

@end

@implementation AddGiftsViewController

- (instancetype)init {
    if(self = [super init]) {
        
        _selectedGifts = [[NSMutableArray alloc] init];
        _addGiftsService = [[AddGiftsService alloc] init];
        _addGiftsService.delegate = self;
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加赠品";
    
    [self registerCell];
    
    [self addKvo];
    
    [self initUI];
    
    _dictCopy = [_dictPromotionDetails mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreData];
}

- (void)initUI {
    _customizNumberView.hidden = YES;
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"确认添加" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAdd)];
    self.navigationItem.rightBarButtonItem = myButton;
}

- (void)confirmAdd {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:_selectedGifts forKey:@"gifts"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kConfirmOrderViewControllerRefreshGifts object:nil userInfo:dict];
    
    //
    int lineNubmer = _beginLine + 1;
    for(int i = 0; i < _selectedGifts.count; i++) {
        PromotionDetailModel *m = _selectedGifts[i];
        m.LINE_NO = lineNubmer;
        m.PO_VOLUME = m.PO_VOLUME * m.PO_QTY;
        m.PO_WEIGHT = m.PO_WEIGHT * m.PO_QTY;
        lineNubmer ++;
    }
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark -- 私有方法
/// 注册Cell
- (void)registerCell {
    [_typeTableView registerNib:[UINib nibWithNibName:@"AddGiftTypesTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddGiftTypesTableViewCell"];
    _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_productTableView registerNib:[UINib nibWithNibName:@"AddGiftProductsTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddGiftProductsTableViewCell"];
    _productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView.tag == 1001) {
        
        return _giftTypes.count;
    } else if(tableView.tag == 1002) {
        NSMutableArray *promotionDetails = _dictPromotionDetails[@(_typeIndexRow)];
        return promotionDetails.count;
    } else {
        
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        
        return 35;
    } else if(tableView.tag == 1002) {
        
        return 60;
    } else {
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        
        static NSString *cellId = @"AddGiftTypesTableViewCell";
        AddGiftTypesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        OrderGiftModel *m = _giftTypes[indexPath.row];
        
        cell.nameLabel.text = m.TYPE_NAME;
        cell.totalLabel.text = [NSString stringWithFormat:@"%.1f", m.QTY];
        cell.laveLabel.text = [NSString stringWithFormat:@"%.1f", m.QTY - m.choiceCount];
        
        return cell;
    } else if(tableView.tag == 1002) {
        
        static NSString *cellId = @"AddGiftProductsTableViewCell";
        AddGiftProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.delegate = self;
        cell.tag = indexPath.row;
        
        
        PromotionDetailModel *m = _dictPromotionDetails[@(_typeIndexRow)][indexPath.row]
        ;
        
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:m.PRODUCT_URL] placeholderImage:[UIImage imageNamed:@"ic_information_picture"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = [self getProductName:m.PRODUCT_NAME];
        cell.formLabel.text = [self getProductStyle:m.PRODUCT_NAME];
        //是否考虑库存
        if([m.LOTTABLE09 isEqualToString:@"Y"]) {
            cell.stockPromptLabel.text = @"剩余库存：";
            cell.stockLabel.text =[NSString stringWithFormat:@"%lld", m.LOTTABLE11];
        } else {
            cell.stockPromptLabel.text = nil;
            cell.stockLabel.text = nil;
        }
        [cell.numberLabel setTitle:[NSString stringWithFormat:@"%lld", m.PO_QTY] forState:UIControlStateNormal];
        
        return cell;
    } else {
        
        return [[UITableViewCell alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == 1001) {
        _typeIndexRow = indexPath.row;
        
        if([_dictPromotionDetails objectForKey:@(indexPath.row)]) {
            [_productTableView reloadData];
        } else {
            OrderGiftModel *m = _giftTypes[indexPath.row];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [_addGiftsService getAddGiftsData:_app.business.BUSINESS_IDX andPartyIdx:_partyId andPartyAddressIdx:_addressIdx andProductName:m.TYPE_NAME];
        }
        
    } else if(tableView.tag == 1002) {
        
    }
}

//获取产品名称
- (NSString *)getProductName:(NSString *)s {
    @try {
        NSArray *array = [s componentsSeparatedByString:@","];
        return array[0];
    } @catch (NSException *exception) {
        return s;
    }
}

//获取产品规格
- (NSString *)getProductStyle:(NSString *)s {
    @try {
        NSRange range = [s rangeOfString:@","];
        return [s substringFromIndex:range.location + 1];
    } @catch (NSException *exception) {
        return s;
    }
}

- (void)refreData {
    //品类数据
    float canChoiceCount = 0;
    float hasChoiceCount = 0;
    float totalChoiceCount = 0;
    for(int i = 0; i < _giftTypes.count; i++) {
        OrderGiftModel *giftType = _giftTypes[i];
        hasChoiceCount += giftType.choiceCount;
        totalChoiceCount += giftType.QTY;
    }
    canChoiceCount = totalChoiceCount - hasChoiceCount;
    
    _canChoiceNumber.text = [NSString stringWithFormat:@"%.1f", canChoiceCount];
    _choicedNumber.text = [NSString stringWithFormat:@"%.1f", hasChoiceCount];
    [_productTableView reloadData];
    [_typeTableView reloadData];
}

#pragma mark -- 点击事件
- (IBAction)confirmCustomizeNumberOnclick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    _customizNumberView.hidden = YES;
    
    long long number = [_cusmotizeNumber.text longLongValue];
    //赠品数据
    PromotionDetailModel *m = _dictPromotionDetails[@(_typeIndexRow)][_customizeNumberIndexRow];
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
    if([_selectedGifts indexOfObject:m] == NSNotFound) {
        [_selectedGifts addObject:m];
    } else {
        //购物车与列表的Model用同一块内存，所以不用再次刷新
    }
    
    //删除已选的产品
    if(m.PO_QTY == 0) {
        [_selectedGifts removeObject:m];
    }
    
    [self refreData];
}

- (IBAction)cancelCustomizeNumberOnclick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    _customizNumberView.hidden = YES;
}

#pragma mark -- AddGiftProductsTableViewCellDelegate 
- (void)delNumberOnclick:(NSInteger)indexRow {
    
    PromotionDetailModel *m = _dictPromotionDetails[@(_typeIndexRow)][indexRow];
    if(m.PO_QTY < 1) {
        return;
    }
    
    m.PO_QTY--;
    
    //返回赠品数量
    OrderGiftModel *giftType = _giftTypes[_typeIndexRow];
    giftType.choiceCount --;
    
    //是否考虑库存
    if([m.LOTTABLE09 isEqualToString:@"Y"]) {
        m.LOTTABLE11 ++;
    }
    
    //删除已选的产品
    if(m.PO_QTY == 0) {
        [_selectedGifts removeObject:m];
    }
    
    [self refreData];
}

- (void)addNumberOnclick:(NSInteger)indexRow {
    //库存不足
    PromotionDetailModel *m = _dictPromotionDetails[@(_typeIndexRow)][indexRow];
    if([m.LOTTABLE09 isEqualToString:@"Y"] && m.LOTTABLE11 < 1) {
        [Tools showAlert:self.view andTitle:@"仓库剩余库存不足!"];
        return;
    }
    
    //赠品已选满
    OrderGiftModel *giftType = _giftTypes[_typeIndexRow];
    if([Tools getDouble:giftType.choiceCount] >= giftType.QTY) {
        [Tools showAlert:self.view andTitle:@"超出当前赠品可选数额"];
        return;
    } else {
        giftType.choiceCount ++;
    }
    
    //保存已选的产品，或刷新购物车数据
    if([_selectedGifts indexOfObject:m] == NSNotFound) {
        [_selectedGifts addObject:m];
    } else {
        //购物车与列表的Model用同一块内存，所以不用再次刷新
    }
    
    //是否考虑库存
    if([m.LOTTABLE09 isEqualToString:@"Y"]) {
        m.LOTTABLE11 --;
    }
    
    m.PO_QTY ++;
    
    [self refreData];
}

- (void)productNumberOnclick:(NSInteger)indexRow {
    //处理输入框
    [_cusmotizeNumber becomeFirstResponder];
    _cusmotizeNumber.text = @"";
    _customizeNumberIndexRow = indexRow;
    _customizNumberView.hidden = NO;
    [_productTableView reloadData];
}

#pragma mark -- AddGiftsServiceDelegate
- (void)successOfAddGifts:(NSMutableArray *)promotionDetails {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_dictPromotionDetails setObject:promotionDetails forKey:@(_typeIndexRow)];
    
    [_productTableView reloadData];
}

- (void)failureOfAddGifts:(NSString *)msg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Tools showAlert:self.view andTitle:@"获取赠品失败"];
}

- (void)dealloc {
    
    [_customizNumberView removeObserver:self forKeyPath:@"hidden"];
}

- (IBAction)resetChoiceOnclick:(UITapGestureRecognizer *)sender {
    
    _dictPromotionDetails = [_dictCopy mutableCopy];
    [_productTableView reloadData];
}

- (IBAction)detailOnclick:(UITapGestureRecognizer *)sender {
    if(_selectedGifts.count) {
        SelectedGiftsViewController *vc = [[SelectedGiftsViewController alloc] init];
        vc.gifts = _selectedGifts;
        vc.dictPromotionDetails = _dictPromotionDetails;
        vc.giftTypes = _giftTypes;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [Tools showAlert:self.view andTitle:@"未选择赠品"];
    }
}
@end

//
//  CheckSignatureViewController.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "CheckSignatureViewController.h"
#import "SignatureAndPictureModel.h"
#import <MBProgressHUD.h>
#import "PhotoBroswerVC.h"

@interface CheckSignatureViewController ()
- (IBAction)buttonOnclick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

//订单签收
@property (weak, nonatomic) IBOutlet UIImageView *signtureImageView1;

//交货现场图
@property (weak, nonatomic) IBOutlet UIImageView *signtureImageView2;

//交货现场图
@property (weak, nonatomic) IBOutlet UIImageView *signtureImageView3;

//客户签名
@property (strong, nonatomic) SignatureAndPictureModel *customerSignatureM;

//现场图1
@property (strong, nonatomic) SignatureAndPictureModel *pictureM1;

//现场图2
@property (strong, nonatomic) SignatureAndPictureModel *pictureM2;

////客户签名图片比例
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signatureImageRatio;
//
////现场图片二，长宽比例
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView2Constraint;
//
////现场图片三，长宽比例
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView3Constraint;

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation CheckSignatureViewController

- (instancetype)init {
    if(self = [super init]) {
        _customerSignatureM = nil;
        _pictureM1 = nil;
        _pictureM2 = nil;
        
        _images = [[NSMutableArray alloc] initWithCapacity:3];
        for(int i = 0; i < 3; i++) {
            [_images addObject:[UIImage imageNamed:@"ic_imageview_default_bg"]
             ];
        }
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    CGFloat width = CGRectGetWidth(_signtureImageView1.frame);
//    NSLog(@"signtureImageView2ratilo:%f", width);
//    CGFloat ratilo = _signtureImageView1.image.size.width / _signtureImageView1.image.size.height;
//    NSLog(@"%f", ratilo);
//    CGFloat constant = width * (ratilo - 1) / 2;
//    _signatureImageRatio.constant = constant;
//    
//    
//    
//    width = CGRectGetWidth(_signtureImageView2.frame);
//    ratilo = _signtureImageView2.image.size.width / _signtureImageView2.image.size.height;
//    constant = width * (ratilo - 1) / 2;
//    _imageView2Constraint.constant = constant;
//    
//    
//    width = CGRectGetWidth(_signtureImageView3.frame);
//    ratilo = _signtureImageView3.image.size.width / _signtureImageView3.image.size.height;
//    constant = width * (ratilo - 1) / 2;
//    _imageView3Constraint.constant = constant;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看电子签名";
    
    //处理数据
    [self dealWithData];
    
    [self addImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)addImage {
    /// 客户签名
    if(_customerSignatureM) {
        NSString *url = [NSString stringWithFormat:@"%@/%@", API_SERVER_AUTOGRAPH_AND_PICTURE_FILE, _customerSignatureM.PRODUCT_URL];
        if(url) {
            [MBProgressHUD showHUDAddedTo:_button1 animated:YES];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                UIImage *image = [self setImageFieldImage:url];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:_button1 animated:YES];
                    
                    [_button1 setImage:image forState:UIControlStateNormal];
                    
                    [_images replaceObjectAtIndex:0 withObject:image];
                });
            });
            
        }
    }
    
    /// 现场图片1
    if(_pictureM1) {
        NSString *url = [NSString stringWithFormat:@"%@/%@", API_SERVER_AUTOGRAPH_AND_PICTURE_FILE, _pictureM1.PRODUCT_URL];
        if(url) {
            [MBProgressHUD showHUDAddedTo:_button2 animated:YES];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [self setImageFieldImage:url];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:_button2 animated:YES];
                    
                    [_button2 setImage:image forState:UIControlStateNormal];
                    
                    [_images replaceObjectAtIndex:1 withObject:image];
                });
            });
            
        }
    }
    
    /// 现场图片2
    if(_pictureM2) {
        NSString *url = [NSString stringWithFormat:@"%@/%@", API_SERVER_AUTOGRAPH_AND_PICTURE_FILE, _pictureM2.PRODUCT_URL];
        if(url) {
            [MBProgressHUD showHUDAddedTo:_button3 animated:YES];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [self setImageFieldImage:url];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:_button3 animated:YES];
                    [_button3 setImage:image forState:UIControlStateNormal];
                    
                    
                    [_images replaceObjectAtIndex:2 withObject:image];
                });
            });
            
        }
    }
}

- (void)dealWithData {
    
    for(int i = 0; i < _signatures.count; i++) {
        SignatureAndPictureModel *m = _signatures[i];
        
        if([m.REMARK isEqualToString:@"Autograph"]) {
            
            _customerSignatureM = m;
        } else if([m.REMARK isEqualToString:@"pricture"]) {
            
            if(!_pictureM1) {
                
                _pictureM1 = m;
            } else if(!_pictureM2) {
                
                _pictureM2 = m;
            }
        }
    }
}

#pragma mark -- 功能函数
/**
 * 设置 imageview 的图片
 *
 * imageUrl: 图片的网络路径
 */
- (UIImage *)setImageFieldImage:(NSString *)imageUrl {
    UIImage *image = nil;
    if(imageUrl) {
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *imageData;
        if(url) {
            imageData = [NSData dataWithContentsOfURL:url];
        }
        if(imageData) {
            image = [UIImage imageWithData:imageData];
        }
    }
    
    return image;
}

/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index{
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        NSArray *localImages = [weakSelf.images copy];
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image = localImages[i];
            
            //源frame
            UIImageView *imageV =(UIImageView *) weakSelf.view.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

- (IBAction)buttonOnclick:(UIButton *)sender {
    [self localImageShow:sender.tag - 1001];
}

@end

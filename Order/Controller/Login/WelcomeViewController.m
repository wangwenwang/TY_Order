//
//  WelcomeViewController.m
//  Order
//
//  Created by 凯东源 on 16/9/26.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "Tools.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()

// 计时器，启动页时间
@property (strong, nonatomic) NSTimer *timer;

- (IBAction)skipOnclick:(UIButton *)sender;

// 启动图片
@property (weak, nonatomic) IBOutlet UIImageView *welcomeImageView;

// 全局变量
@property(strong, nonatomic) AppDelegate *app;

@end

@implementation WelcomeViewController

- (instancetype)init {
    
    if (self = [super init]) {
        
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self skipAd];
    
//    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:udUserName];
//    
//    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
//    NSLog(@"fds:%@", dict);
//    
//    if(userName) {
//    
//        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(skipAd) userInfo:nil repeats:YES];
//        
//        NSString *welcomeImageName = [[NSUserDefaults standardUserDefaults] objectForKey:kWelcomeImageName];
//        if([welcomeImageName isEqualToString:@"YIB"]) {
//            
//            _welcomeImageView.image = [UIImage imageNamed:@"welcome1"];
//        } else if([welcomeImageName isEqualToString:@"DK"]) {
//            
//            _welcomeImageView.image = [UIImage imageNamed:@"welcome2"];
//        }  else if([welcomeImageName isEqualToString:@"QH"]) {
//            
//            _welcomeImageView.image = [UIImage imageNamed:@"welcome3"];
//        } else {
//            
//            [self skipAd];
//        }
//    } else {
//        
//        [self addLogoAnimation];
//    }
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - 点击事件
- (void)skipAd {
    if(_timer) {
        [_timer invalidate];
    }
    LoginViewController *vc = [[LoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [Tools setRootViewControllerWithCrossDissolve:_app.window andViewController:nav];
}

- (IBAction)skipOnclick:(UIButton *)sender {
    [self skipAd];
}

/// 旋转动画
- (void)addLogoAnimation {
    
    //背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:131 / 255.0 blue:0 / 255.0 alpha:1.0];
    [self.view addSubview:bgView];
    
    //LogoView
    UIImage *logo = [UIImage imageNamed:@"kdy"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
    CGFloat logoViewW = ScreenWidth / 1.5;
    CGFloat logoViewH = logoViewW * (logo.size.height / logo.size.width);
    logoView.bounds = CGRectMake(0, 0, logoViewW, logoViewH);
    logoView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    [self.view addSubview:logoView];
    
    //旋转时间
    CFTimeInterval duration = 2.0;
    
    //旋转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //让其在z轴旋转
    [rotationAnimation setToValue:[NSNumber numberWithDouble:M_PI * 2.0]]; //旋转角度
    [rotationAnimation setDuration:duration];  //旋转周期
    [rotationAnimation setCumulative:YES]; //旋转累加角度
    [rotationAnimation setRepeatCount:1]; //旋转次数
    
    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAnimation setFromValue:[NSNumber numberWithDouble:0.3]];
    [scaleAnimation setToValue:[NSNumber numberWithDouble:0.95]];
    [scaleAnimation setDuration:duration];
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    //群组动画
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    [animationGroup setDuration:duration];
    [animationGroup setAutoreverses:NO];   //是否重播，原动画的倒播
    [animationGroup setRepeatCount:0];  //HUGE_VALF;     //HUGE_VALF,源自math.h
    
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    
    //添加动画
    [logoView.layer addAnimation:animationGroup forKey:@"animationGroup"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //动画
        usleep(duration * 1000000 + 500000);
        dispatch_async(dispatch_get_main_queue(), ^{
            //去掉key动画
            [logoView.layer removeAnimationForKey:@"animationGroup"];
            [self skipAd];
        });
    });
}

@end

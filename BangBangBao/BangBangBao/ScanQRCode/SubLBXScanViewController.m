//
//
//
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "SubLBXScanViewController.h"

@interface SubLBXScanViewController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation SubLBXScanViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    self.title = @"扫码绑定";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_isQQSimulator) {
        [self drawBottomItems];
        [self drawTitle];
        [self.view bringSubviewToFront:_topTitle];
    }else{
        _topTitle.hidden = YES;
    }
}

//绘制扫描区域
- (void)drawTitle{
    if (!_topTitle){
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        
        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 ){
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"將取景框對準二維碼即可自動掃描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }    
}

- (void)drawBottomItems{
    if (_bottomItemsView) {
        return;
    }
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                      CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:_bottomItemsView];
    CGSize size = CGSizeMake(65, 87);
    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 1/2, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_bottomItemsView addSubview:_btnPhoto];
    
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array{
    if (array.count < 1){
        return;
    }
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        NSLog(@"scanResult:%@",result.strScanned);
    }
    LBXScanResult *scanResult = array[0];
    NSString*strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    if (!strResult) {
        return;
    }
    //震动提醒
    //[LBXScanWrapper systemVibrate];
    //声音提醒
    //[LBXScanWrapper systemSound];
    [self showNextVCWithScanResult:scanResult];
   
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult{
    NSLog(@"%@",strResult);
    [self dismissViewControllerAnimated:YES completion:^{
        [self.scanQRCodeSuccessfulDelegate scanQRCodeSuccessfulWithResult:strResult.strScanned];
    }];
}


#pragma mark -底部功能项
//打开相册
- (void)openPhoto{
    if ([LBXScanWrapper isGetPhotoPermission]){
        [self openLocalPhoto];
    }else{
        //[MBProgressHUD showHUDwithSuccess:NO WithTitle:@"請到設置隱私中開啟本軟體相冊權限" withView:self.navigationController.view];
    }
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - getter and setter

- (UIButton *) backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

@end

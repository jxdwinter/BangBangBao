//
//  ViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "ViewController.h"
#import "ScanQRCodeViewController.h"
#import "BaseNavigationController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *scanQRCodeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"元寶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.scanQRCodeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void) scan {
    if (![self cameraPemission]){
        //[MBProgressHUD showHUDwithSuccess:NO WithTitle:@"没有摄像机权限" withView:self.navigationController.view];
        return;
    }else{
        LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
        style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
        ScanQRCodeViewController *vc = [ScanQRCodeViewController new];
        vc.style = style;
        vc.isQQSimulator = YES;
        vc.scanQRCodeSuccessfulDelegate = self;
        [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
        }];
    }
}

- (BOOL)cameraPemission{
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]){
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    return isHavePemission;
}

#pragma mark - ScanSuccessfulDelegate

- (void) scanQRCodeSuccessfulWithResult : (NSString *) result {
    NSLog(@"%@",result);
}

#pragma mark - getter and setter

- (UIButton *) scanQRCodeButton {
    if (!_scanQRCodeButton) {
        _scanQRCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_scanQRCodeButton addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
        [_scanQRCodeButton setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    }
    return _scanQRCodeButton;
}


@end

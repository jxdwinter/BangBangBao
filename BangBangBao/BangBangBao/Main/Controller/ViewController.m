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
#import <ClusterPrePermissions/ClusterPrePermissions.h>
#import "MainCollectionViewCell.h"
#import "MainFooterView.h"
#import "MainFooterSubView.h"
#import "MainBusinessRecordViewController.h"
#import "MainYuanbaoBusinessRecordViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *scanQRCodeButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *iconDataSource;
@property (nonatomic, strong) MainFooterView *footerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"幫幫寶";
    self.navigationItem.titleView = titleLabel;
    
    self.dataSource = @[@"淘寶天貓代付",@"阿里巴巴代付",@"支付寶儲值",@"微信錢包",@"虛寶代購",@"儲值元寶"];
    self.iconDataSource = @[@"main_taobao",@"main_alibaba",@"main_zhifubao",@"main_weixin",@"main_qq",@"main_yuanbao"];

    [self.view addSubview:self.scanQRCodeButton];
    [self.scanQRCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@60.0);
        make.height.equalTo(@60.0);
    }];
    
    UILabel *scanQRCodeLabel = [[UILabel alloc] init];
    scanQRCodeLabel.text = @"QR Code 掃描";
    scanQRCodeLabel.textAlignment = NSTextAlignmentCenter;
    scanQRCodeLabel.font = DEFAULFONT;
    scanQRCodeLabel.textColor = DEFAULTTEXTCOLOR;
    [self.view addSubview:scanQRCodeLabel];
    [scanQRCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scanQRCodeButton.mas_bottom).with.offset(10.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@20.0);
    }];
    
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
    [self.view addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanQRCodeLabel.mas_bottom).with.offset(50.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizontalLine.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void) scan {
    ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
    [permissions showCameraPermissionsWithTitle:@"訪問您的相機"
                                        message:@"幫幫寶想要使用您的攝像頭來掃描二維碼"
                                denyButtonTitle:@"不允許"
                               grantButtonTitle:@"允許"
                              completionHandler:^(BOOL hasPermission,
                                                  ClusterDialogResult userDialogResult,
                                                  ClusterDialogResult systemDialogResult) {
                                  if (hasPermission) {
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
                                  } else {
                                      [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"請在設置隱私中開啟本軟體相機權限" withView:self.navigationController.view];
                                  }

    }];
}

- (void) businessRecord {
    MainBusinessRecordViewController *businessRecordViewController = [[MainBusinessRecordViewController alloc] init];
    [self.navigationController pushViewController:businessRecordViewController animated:YES];
}

- (void) yuanbaoBusinessRecord {
    MainYuanbaoBusinessRecordViewController *yuanbaoBusinessRecordViewController = [[MainYuanbaoBusinessRecordViewController alloc] init];
    [self.navigationController pushViewController:yuanbaoBusinessRecordViewController animated:YES];
}

#pragma mark - ScanSuccessfulDelegate

- (void) scanQRCodeSuccessfulWithResult : (NSString *) result {
    NSLog(@"%@",result);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MAINCOLLECTIONVIEWCELL" forIndexPath:indexPath];
    cell.nameLabel.text = self.dataSource[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.iconDataSource[indexPath.row]]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        if (!_footerView) {
            _footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                             withReuseIdentifier:@"FOOTER" forIndexPath:indexPath];
            _footerView.businessRecordView.iconImageView.image = [UIImage imageNamed:@"main_business_record"];
            _footerView.businessRecordView.nameLabel.text = @"交易記錄";
            [_footerView.businessRecordView addTarget:self action:@selector(businessRecord) forControlEvents:UIControlEventTouchUpInside];
            _footerView.yuanbaoBusinessRecordView.iconImageView.image = [UIImage imageNamed:@"main_yuanbao_business_record"];
            _footerView.yuanbaoBusinessRecordView.nameLabel.text = @"元寶充值記錄";
            [_footerView.yuanbaoBusinessRecordView addTarget:self action:@selector(yuanbaoBusinessRecord) forControlEvents:UIControlEventTouchUpInside];
        }
        reusableview = _footerView;
    }
    return reusableview;
}

#pragma mark - getter and setter

- (UIButton *) scanQRCodeButton {
    if (!_scanQRCodeButton) {
        _scanQRCodeButton = [[UIButton alloc] init];
        [_scanQRCodeButton addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
        [_scanQRCodeButton setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    }
    return _scanQRCodeButton;
}

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 240.0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"MAINCOLLECTIONVIEWCELL"];
        [_collectionView registerClass:[MainFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}


@end

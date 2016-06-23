//
//  MineBankInformationViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/22/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineBankInformationViewController.h"
#import "PaymentsApi.h"
#import "PaymentBankDatabaseHelper.h"

@interface MineBankInformationViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation MineBankInformationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"付款銀行帳戶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    [self getPaymentBank];
}

#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addBank {
    
}

- (void) getPaymentBank {
    PaymentsApi *api = [[PaymentsApi alloc] init];
    RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
    [api addAccessory:accessory];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] integerValue] == 0) {
                
            }else {
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"message"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    }];

}

#pragma mark - getter and setter

- (UIButton *) backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
        [_backButton addTarget:self action:@selector(popToPreViewController) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *) addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
        [_addButton addTarget:self action:@selector(addBank) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setImage:[UIImage imageNamed:@"bankInformation_add"] forState:UIControlStateNormal];
    }
    return _addButton;
}

@end

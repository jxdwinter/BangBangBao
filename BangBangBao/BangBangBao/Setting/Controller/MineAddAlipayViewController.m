//
//  MineAddAlipayViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/24/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineAddAlipayViewController.h"
#import "CreateAlipayAccountApi.h"

@interface MineAddAlipayViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation MineAddAlipayViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新增支付寶賬戶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(40.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *uaernameLabel = [[UILabel alloc] init];
    uaernameLabel.textColor = [UIColor blackColor];
    uaernameLabel.font = [UIFont systemFontOfSize:10];
    uaernameLabel.text = @"請輸入支付寶帳號";
    [self.view addSubview:uaernameLabel];
    [uaernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uaernameLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.textField becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self.textField resignFirstResponder];
    [super viewWillDisappear:animated];
}

#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) createAlipayAccount {
    if (self.textField.text.length) {
        [self.textField resignFirstResponder];
        CreateAlipayAccountApi *api = [[CreateAlipayAccountApi alloc] initWithAccount_number:self.textField.text];
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"添加成功" withView:self.navigationController.view];
                if (self.addAlipayDelegate && [self.addAlipayDelegate respondsToSelector:@selector(reloadAlipay)]) {
                    [self.addAlipayDelegate reloadAlipay];
                }
                [self performSelector:@selector(popToPreViewController) withObject:nil afterDelay:0.8];
            }
        } failure:^(YTKBaseRequest *request) {
            [self.textField becomeFirstResponder];
            NSDictionary *dic = [[NSDictionary alloc]init];
            NSError *e = nil;
            dic = [NSJSONSerialization JSONObjectWithData: [request.responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                  options: NSJSONReadingMutableContainers
                                                    error: &e];
            if (!e) {
                if (dic[@"error"]) {
                    [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"error"][@"account_number"] withView:self.navigationController.view];
                }else{
                    [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"message"] withView:self.navigationController.view];
                }
            }
        }];
    }else{
        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"請輸入支付寶帳號" withView:self.navigationController.view];
    }
}

#pragma mark UITextFieldDelegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self createAlipayAccount];
    return YES;
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

- (UITextField *) textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.font = DEFAULFONT;
        _textField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        [_textField setTintColor:DEFAULTCOLOR];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入支付寶帳號"
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _textField;
}

- (UIButton *) saveButton {
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_saveButton addTarget:self action:@selector(createAlipayAccount) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setImage:[UIImage imageNamed:@"mine_save"] forState:UIControlStateNormal];
    }
    return _saveButton;
}

@end

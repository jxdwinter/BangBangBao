//
//  ForgetPasswordViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/12/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordStepTwoViewController.h"

@interface ForgetPasswordViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.frame];
    control.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    [control addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchUpInside];
    self.view = control;
    
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.width.equalTo(@25.0);
        make.height.equalTo(@25.0);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"找回密碼";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(self.view.mas_top).with.offset(30.0);
        }else{
            make.top.equalTo(self.view.mas_top).with.offset(50.0);
        }
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@30.0);
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.text = @"重置密碼後請再次嘗試登錄";
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@20.0);
    }];
    
    UIView *oneLine = [[UIView alloc] init];
    oneLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:oneLine];
    [oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.textColor = [UIColor blackColor];
    accountLabel.font = [UIFont systemFontOfSize:10];
    accountLabel.text = @"Email帳號或行動電話";
    [self.view addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-100.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.view addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-100.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTextField.mas_top).with.offset(0.0);
        make.left.equalTo(self.accountTextField.mas_right).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.bottom.equalTo(self.accountTextField.mas_bottom).with.offset(0.0);
    }];
    
    UIView *twoLine = [[UIView alloc] init];
    twoLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:twoLine];
    [twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void) closeKeyboard {
    [self.view endEditing:YES];
}

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) next {
    ForgetPasswordStepTwoViewController *forgetPasswordStepTwoViewController = [[ForgetPasswordStepTwoViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordStepTwoViewController animated:YES];
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

- (UITextField *) accountTextField{
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.delegate = self;
        _accountTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _accountTextField.font = DEFAULFONT;
        _accountTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_accountTextField setTintColor:DEFAULTCOLOR];
        _accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入Email帳號或行動電話"
                                                                                attributes:@{NSForegroundColorAttributeName:
                                                                                                 [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _accountTextField;
}

- (UIButton *) nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_nextButton setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
        //_nextButton.enabled = NO;
    }
    return _nextButton;
}

@end

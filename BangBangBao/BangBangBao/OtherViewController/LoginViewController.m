//
//  LoginViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/11/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ForgetPasswordViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetPasswordButton;

@end

@implementation LoginViewController

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
    titleLabel.text = @"歡迎回來";
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
    infoLabel.text = @"登錄你的賬戶開始使用";
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@20.0);
    }];
    
    FBSDKLoginButton *facebookLoginButton = [[FBSDKLoginButton alloc] init];
    facebookLoginButton.titleLabel.text = @"使用Facebook登錄";
    [self.view addSubview:facebookLoginButton];
    [facebookLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(infoLabel.mas_bottom).with.offset(20.0);
        }else{
            make.top.equalTo(infoLabel.mas_bottom).with.offset(40.0);
        }
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@50.0);
    }];
    
    UILabel *orLabel = [[UILabel alloc] init];
    orLabel.textAlignment = NSTextAlignmentCenter;
    orLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    orLabel.font = [UIFont systemFontOfSize:12];
    orLabel.text = @"或者";
    [self.view addSubview:orLabel];
    [orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(facebookLoginButton.mas_bottom).with.offset(20.0);
        }else{
            make.top.equalTo(facebookLoginButton.mas_bottom).with.offset(40.0);
        }
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@40.0);
        make.height.equalTo(@20.0);
    }];
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orLabel.mas_centerY).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(orLabel.mas_left).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orLabel.mas_centerY).with.offset(0.0);
        make.left.equalTo(orLabel.mas_right).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(orLabel.mas_bottom).with.offset(20.0);
        }else{
            make.top.equalTo(orLabel.mas_bottom).with.offset(40.0);
        }
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *uaernameLabel = [[UILabel alloc] init];
    uaernameLabel.textColor = [UIColor blackColor];
    uaernameLabel.font = [UIFont systemFontOfSize:10];
    uaernameLabel.text = @"郵箱帳號或行動電話";
    [self.view addSubview:uaernameLabel];
    [uaernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.view addSubview:self.usernameTextField];
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uaernameLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *midLine = [[UIView alloc] init];
    midLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.font = [UIFont systemFontOfSize:10];
    passwordLabel.text = @"密碼";
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-100.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-100.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.passwordTextField.mas_right).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.bottom.equalTo(self.passwordTextField.mas_bottom).with.offset(0.0);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    [self.view addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20.0);
        make.left.equalTo(self.view.mas_left).with.offset(10.0);
        make.right.equalTo(self.view.mas_right).with.offset(-10.0);
        make.height.equalTo(@40.0);
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

- (void) login {
    
}

- (void) forgetPassword {
    ForgetPasswordViewController *forgetPasswordViewController = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
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

- (UITextField *) usernameTextField{
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.delegate = self;
        _usernameTextField.keyboardType = UIKeyboardTypeDefault;
        _usernameTextField.font = DEFAULFONT;
        _usernameTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_usernameTextField setTintColor:DEFAULTCOLOR];
        _usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入郵箱帳號或行動電話"
                                                                                   attributes:@{NSForegroundColorAttributeName:
                                                                                                    [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _usernameTextField;
}

- (UITextField *) passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.font = DEFAULFONT;
        _passwordTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        [_passwordTextField setTintColor:DEFAULTCOLOR];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入密碼"
                                                                                   attributes:@{NSForegroundColorAttributeName:
                                                                                                    [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _passwordTextField;
}

- (UIButton *) loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登錄" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_loginButton setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
        _loginButton.enabled = NO;
    }
    return _loginButton;
}

- (UIButton *) forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [[UIButton alloc] init];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [_forgetPasswordButton setTitle:@"忘記密碼?" forState:UIControlStateNormal];
        [_forgetPasswordButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_forgetPasswordButton setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00] forState:UIControlStateNormal];
    }
    return _forgetPasswordButton;
}

@end

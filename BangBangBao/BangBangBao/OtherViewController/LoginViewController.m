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
#import "LoginApi.h"
#import "LoginWithFacebookApi.h"
#import "MemberInformationApi.h"
#import <YTKChainRequest.h>
#import "User.h"
#import "AppDelegate.h"

@interface LoginViewController () <UITextFieldDelegate,UIScrollViewDelegate,YTKChainRequestDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *facebookLoginButton;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetPasswordButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.contentView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(30.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.width.equalTo(@25.0);
        make.height.equalTo(@25.0);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"歡迎回來";
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(50.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@30.0);
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.text = @"登錄你的賬戶開始使用";
    [self.contentView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@20.0);
    }];

    [self.contentView addSubview:self.facebookLoginButton];
    [self.facebookLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.mas_bottom).with.offset(40.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@50.0);
    }];
    
    UILabel *orLabel = [[UILabel alloc] init];
    orLabel.textAlignment = NSTextAlignmentCenter;
    orLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    orLabel.font = [UIFont systemFontOfSize:12];
    orLabel.text = @"或者";
    [self.contentView addSubview:orLabel];
    [orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.facebookLoginButton.mas_bottom).with.offset(40.0);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@40.0);
        make.height.equalTo(@20.0);
    }];
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orLabel.mas_centerY).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(orLabel.mas_left).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orLabel.mas_centerY).with.offset(0.0);
        make.left.equalTo(orLabel.mas_right).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orLabel.mas_bottom).with.offset(40.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *uaernameLabel = [[UILabel alloc] init];
    uaernameLabel.textColor = [UIColor blackColor];
    uaernameLabel.font = [UIFont systemFontOfSize:10];
    uaernameLabel.text = @"郵箱帳號或行動電話";
    [self.contentView addSubview:uaernameLabel];
    [uaernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.usernameTextField];
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uaernameLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *midLine = [[UIView alloc] init];
    midLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.font = [UIFont systemFontOfSize:10];
    passwordLabel.text = @"密碼";
    [self.contentView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-100.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-100.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.contentView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_top).with.offset(0.0);
        make.left.equalTo(self.passwordTextField.mas_right).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.bottom.equalTo(self.passwordTextField.mas_bottom).with.offset(0.0);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    [self.contentView addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
        make.height.equalTo(@40.0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.forgetPasswordButton.mas_bottom).with.offset(20.0);
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
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    if (username.length && password.length) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username withPassword:password];
        YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [chainReq addAccessory:accessory];
        [chainReq addRequest:api callback:^(YTKChainRequest *chainRequest, YTKBaseRequest *baseRequest) {
            LoginApi *result = (LoginApi *)baseRequest;
            NSDictionary *dic = [api responseDictionaryWithResponseString:result.responseString];
            if (dic) {
                [AccountHelper saveAccountVerifyTokenWithToken:dic[@"token"]];
                MemberInformationApi *api = [[MemberInformationApi alloc] initWithMid:[dic[@"mid"] description]];
                [chainRequest addRequest:api callback:nil];
            }
        }];
        chainReq.delegate = self;
        [chainReq start];
    }
}

- (void) forgetPassword {
    ForgetPasswordViewController *forgetPasswordViewController = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

-(void)loginButtonClicked{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        NSLog(@"%@",result.token.tokenString);
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if ([FBSDKAccessToken currentAccessToken]) {
                 NSLog(@"%@",[[FBSDKAccessToken currentAccessToken] tokenString]);
                 LoginWithFacebookApi *api = [[LoginWithFacebookApi alloc] initWithFacebookAccessToken:[[FBSDKAccessToken currentAccessToken] tokenString]];
                 YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
                 RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
                 [chainReq addAccessory:accessory];
                 [chainReq addRequest:api callback:^(YTKChainRequest *chainRequest, YTKBaseRequest *baseRequest) {
                     LoginApi *result = (LoginApi *)baseRequest;
                     NSDictionary *dic = [api responseDictionaryWithResponseString:result.responseString];
                     if (dic) {
                         [AccountHelper saveAccountVerifyTokenWithToken:dic[@"token"]];
                         MemberInformationApi *api = [[MemberInformationApi alloc] initWithMid:[dic[@"mid"] description]];
                         [chainRequest addRequest:api callback:nil];
                     }
                 }];
                 chainReq.delegate = self;
                 [chainReq start];
             }
         }
     }];
}

- (void) enter{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setupRootViewController];
}

#pragma mark - YTKChainRequestDelegate

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    NSArray *requestArray = chainRequest.requestArray;
    MemberInformationApi *api = requestArray[1];
    NSDictionary *dic = [api responseDictionaryWithResponseString:api.responseString];
    if (dic) {
        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"登錄成功" withView:self.navigationController.view];
        AccountManager *accountManager = [AccountManager sharedAccountManager];
        [accountManager setCurrentUser:dic];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"USERLOGIN" object:nil];
        [self performSelector:@selector(enter) withObject:nil afterDelay:1.5];
    }
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest*)request {
    NSDictionary *dic = [[NSDictionary alloc]init];
    NSError *e = nil;
    dic = [NSJSONSerialization JSONObjectWithData: [request.responseString dataUsingEncoding:NSUTF8StringEncoding]
                                          options: NSJSONReadingMutableContainers
                                            error: &e];
    if (!e) {
        if (dic[@"error"]) {
            [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"error"][@"username"] withView:self.navigationController.view];
        }else{
            [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"message"] withView:self.navigationController.view];
        }
    }
}

#pragma mark - getter and setter

- (UIScrollView *) scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *) contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    }
    return _contentView;
}

- (UIButton *) backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
        [_backButton addTarget:self action:@selector(popToPreViewController) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *) facebookLoginButton {
    if (!_facebookLoginButton) {
        _facebookLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_facebookLoginButton.layer setMasksToBounds:YES];
        [_facebookLoginButton.layer setCornerRadius:2.0];
        _facebookLoginButton.backgroundColor = [UIColor colorWithRed:0.24 green:0.34 blue:0.56 alpha:1.00];
        _facebookLoginButton.titleLabel.font = DEFAULFONT;
        [_facebookLoginButton setTitle: @"使用Facebook登錄" forState: UIControlStateNormal];
        [_facebookLoginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookLoginButton;
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

//
//  SignupViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/12/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "SignupViewController.h"
#import "FacebookSignupViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SignupViewController () <UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *facebookLoginButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *confirmPasswordTextField;
@property (nonatomic, strong) UIButton *signupButton;
@property (nonatomic, strong) UITextField *referrerTextField;
@property (nonatomic, strong) UIButton *announcementButton;

@end

@implementation SignupViewController

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
    titleLabel.text = @"創建帳號";
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
    infoLabel.text = @"立即加入幫幫寶";
    [self.contentView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.view addSubview:self.facebookLoginButton];
    [self.facebookLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.mas_bottom).with.offset(40.0);
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
        make.top.equalTo(self.facebookLoginButton.mas_bottom).with.offset(40.0);
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
    
    UIView *oneLine = [[UIView alloc] init];
    oneLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:oneLine];
    [oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orLabel.mas_bottom).with.offset(40.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.textColor = [UIColor blackColor];
    emailLabel.font = [UIFont systemFontOfSize:10];
    emailLabel.text = @"Email帳號";
    [self.contentView addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.emailTextField];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *twoLine = [[UIView alloc] init];
    twoLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:twoLine];
    [twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:10];
    nameLabel.text = @"真實姓名";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.width.equalTo(@((SCREEN_WIDTH - 40.0)/2 - 20.0));
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.width.equalTo(@((SCREEN_WIDTH - 40.0)/2 - 20.0));
        make.height.equalTo(@30.0);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:10];
    phoneLabel.text = @"行動電話";
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(nameLabel.mas_right).with.offset(40.5);
        make.width.equalTo(@((SCREEN_WIDTH - 40.0)/2 - 20.0));
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.nameTextField.mas_right).with.offset(40.5);
        make.width.equalTo(@((SCREEN_WIDTH - 40.0)/2 - 20.0));
        make.height.equalTo(@30.0);
    }];
    
    UIView *thrLine = [[UIView alloc] init];
    thrLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:thrLine];
    [thrLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoLine.mas_bottom).with.offset(0.0);
        make.centerX.equalTo(twoLine.mas_centerX);
        make.bottom.equalTo(thrLine.mas_top).with.offset(0.0);
        make.width.equalTo(@0.5);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.font = [UIFont systemFontOfSize:10];
    passwordLabel.text = @"密碼";
    [self.contentView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thrLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *fourLine = [[UIView alloc] init];
    fourLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:fourLine];
    [fourLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *confirmPasswordLabel = [[UILabel alloc] init];
    confirmPasswordLabel.textColor = [UIColor blackColor];
    confirmPasswordLabel.font = [UIFont systemFontOfSize:10];
    confirmPasswordLabel.text = @"密碼確認";
    [self.contentView addSubview:confirmPasswordLabel];
    [confirmPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fourLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-100.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.confirmPasswordTextField];
    [self.confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmPasswordLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-100.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.contentView addSubview:self.signupButton];
    [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmPasswordTextField.mas_top).with.offset(0.0);
        make.left.equalTo(self.confirmPasswordTextField.mas_right).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.bottom.equalTo(self.confirmPasswordTextField.mas_bottom).with.offset(0.0);
    }];
    
    UIView *fiveLine = [[UIView alloc] init];
    fiveLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:fiveLine];
    [fiveLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmPasswordTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *referrerLabel = [[UILabel alloc] init];
    referrerLabel.textColor = [UIColor blackColor];
    referrerLabel.font = [UIFont systemFontOfSize:10];
    referrerLabel.text = @"推薦人ID/行動電話（無推薦人可不填）";
    [self.contentView addSubview:referrerLabel];
    [referrerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fiveLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-100.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.contentView addSubview:self.referrerTextField];
    [self.referrerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(referrerLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *sixLine = [[UIView alloc] init];
    sixLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.contentView addSubview:sixLine];
    [sixLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.referrerTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    [self.contentView addSubview:self.announcementButton];
    [self.announcementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sixLine.mas_bottom).with.offset(20.0);
        make.height.equalTo(@40.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.announcementButton.mas_bottom).with.offset(20.0);
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

- (void) signup {
    
}

- (void) announcement {
    
}

-(void)loginButtonClicked{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            if ([FBSDKAccessToken currentAccessToken]) {
                FacebookSignupViewController *facebookSignupViewController = [[FacebookSignupViewController alloc] init];
                facebookSignupViewController.accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
                [self.navigationController pushViewController:facebookSignupViewController animated:YES];
            }
        }
    }];
}

#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        //[self closeKeyboard];
    }
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

- (UIButton *) facebookLoginButton {
    if (!_facebookLoginButton) {
        _facebookLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_facebookLoginButton.layer setMasksToBounds:YES];
        [_facebookLoginButton.layer setCornerRadius:2.0];
        _facebookLoginButton.backgroundColor = [UIColor colorWithRed:0.24 green:0.34 blue:0.56 alpha:1.00];
        _facebookLoginButton.titleLabel.font = DEFAULFONT;
        [_facebookLoginButton setTitle: @"使用Facebook註冊" forState: UIControlStateNormal];
        [_facebookLoginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookLoginButton;
}

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

- (UITextField *) emailTextField{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] init];
        _emailTextField.delegate = self;
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.font = DEFAULFONT;
        _emailTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_emailTextField setTintColor:DEFAULTCOLOR];
        _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入Email帳號"
                                                                                   attributes:@{NSForegroundColorAttributeName:
                                                                                                    [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _emailTextField;
}

- (UITextField *) nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.delegate = self;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.font = DEFAULFONT;
        _nameTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_nameTextField setTintColor:DEFAULTCOLOR];
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入真實姓名"
                                                                                attributes:@{NSForegroundColorAttributeName:
                                                                                                 [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _nameTextField;
}

- (UITextField *) phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.font = DEFAULFONT;
        _phoneTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTextField setTintColor:DEFAULTCOLOR];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入行動電話"
                                                                               attributes:@{NSForegroundColorAttributeName:
                                                                                                [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _phoneTextField;
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

- (UITextField *) confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[UITextField alloc] init];
        _confirmPasswordTextField.delegate = self;
        _confirmPasswordTextField.keyboardType = UIKeyboardTypeDefault;
        _confirmPasswordTextField.font = DEFAULFONT;
        _confirmPasswordTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        [_confirmPasswordTextField setTintColor:DEFAULTCOLOR];
        _confirmPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _confirmPasswordTextField.secureTextEntry = YES;
        _confirmPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請再次輸入密碼"
                                                                                   attributes:@{NSForegroundColorAttributeName:
                                                                                                    [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _confirmPasswordTextField;
}

- (UIButton *) signupButton{
    if (!_signupButton) {
        _signupButton = [[UIButton alloc] init];
        [_signupButton addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
        [_signupButton setTitle:@"註冊" forState:UIControlStateNormal];
        [_signupButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_signupButton setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
        _signupButton.enabled = NO;
    }
    return _signupButton;
}

- (UITextField *) referrerTextField{
    if (!_referrerTextField) {
        _referrerTextField = [[UITextField alloc] init];
        _referrerTextField.delegate = self;
        _referrerTextField.keyboardType = UIKeyboardTypeDefault;
        _referrerTextField.font = DEFAULFONT;
        _referrerTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _referrerTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_referrerTextField setTintColor:DEFAULTCOLOR];
        _referrerTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請輸入推薦人ID/行動電話"
                                                                               attributes:@{NSForegroundColorAttributeName:
                                                                                                [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _referrerTextField;
}

- (UIButton *) announcementButton{
    if (!_announcementButton) {
        _announcementButton = [[UIButton alloc] init];
        [_announcementButton addTarget:self action:@selector(announcement) forControlEvents:UIControlEventTouchUpInside];
        [_announcementButton setTitle:@"註冊即代表您同意<幫幫寶會員條款>" forState:UIControlStateNormal];
        [_announcementButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_announcementButton setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00] forState:UIControlStateNormal];
    }
    return _announcementButton;
}

@end

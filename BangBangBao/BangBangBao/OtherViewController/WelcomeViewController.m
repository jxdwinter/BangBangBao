//
//  WelcomeViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/11/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"

@interface WelcomeViewController ()

@property (nonatomic, strong) UIButton *creatAccountButton;
@property (nonatomic, strong) UIButton *signinButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    if (IS_IPHONE_4_OR_LESS) {
        backgroundImageView.image = [UIImage imageNamed:@"welcome_iphone4"];
    }else if (IS_IPHONE_5){
        backgroundImageView.image = [UIImage imageNamed:@"welcome_iphone5"];
    }else if (IS_IPHONE_6){
        backgroundImageView.image = [UIImage imageNamed:@"welcome_iphone6"];
    }else{
        backgroundImageView.image = [UIImage imageNamed:@"welcome_iphone6plus"];
    }
    [self.view addSubview:backgroundImageView];
    
    UIView *blackView = [[UIView alloc] initWithFrame:self.view.frame];
    blackView.backgroundColor = [UIColor colorWithWhite:.0 alpha:0.7];
    [self.view addSubview:blackView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.text = @"幫幫寶 ";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-80.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@30.0);
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.text = @"幫你 幫她 去淘寶 ";
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.view addSubview:self.signinButton];
    [self.signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20.0);
        make.left.equalTo(self.view.mas_left).with.offset(10.0);
        make.right.equalTo(self.view.mas_right).with.offset(-10.0);
        make.height.equalTo(@40.0);
    }];
    
    [self.view addSubview:self.creatAccountButton];
    [self.creatAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.signinButton.mas_top).with.offset(-10.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@50.0);
    }];

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = NO;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void) createAccount {
    SignupViewController *signupViewController = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

- (void) signin {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

#pragma mark - getter and setter

- (UIButton *) creatAccountButton {
    if (!_creatAccountButton) {
        _creatAccountButton = [[UIButton alloc] init];
        [_creatAccountButton.layer setMasksToBounds:YES];
        [_creatAccountButton.layer setCornerRadius:2.0];
        [_creatAccountButton addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
        _creatAccountButton.titleLabel.font = DEFAULFONT;
        _creatAccountButton.backgroundColor = DEFAULTCOLOR;
        [_creatAccountButton setTitle:@"創建帳號" forState:UIControlStateNormal];
    }
    return _creatAccountButton;
}

- (UIButton *) signinButton {
    if (!_signinButton) {
        _signinButton = [[UIButton alloc] init];
        [_signinButton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
        [_signinButton setTitle:@"已經有帳號?" forState:UIControlStateNormal];
        [_signinButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_signinButton setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00] forState:UIControlStateNormal];
    }
    return _signinButton;
}

@end

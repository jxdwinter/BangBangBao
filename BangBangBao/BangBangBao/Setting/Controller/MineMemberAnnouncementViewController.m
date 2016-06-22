//
//  MineMemberAnnouncementViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/22/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineMemberAnnouncementViewController.h"

@interface MineMemberAnnouncementViewController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation MineMemberAnnouncementViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"會員公告";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
}

#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
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

@end

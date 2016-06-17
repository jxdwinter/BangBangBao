//
//  BaseViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "BaseViewController.h"
#import <Flurry.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:self.title timed:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [Flurry endTimedEvent:self.title withParameters:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end

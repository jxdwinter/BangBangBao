//
//  MineViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/16/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineTableViewHeaderView.h"
#import "MineInformationEditViewController.h"
#import "MineBankInformationViewController.h"
#import "MineAlipayInformationViewController.h"
#import "MineMemberAnnouncementViewController.h"
#import "MineRecommendFriendsViewController.h"
#import "MineAboutBangBangBaoViewController.h"
#import <JGActionSheet.h>
#import "AppDelegate.h"
#import "BankInfoApi.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MineTableViewHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *iconDataSource;
@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.logoutButton];
    
    self.dataSource = @[@[@"個人資料編輯",@"付款銀行帳戶",@"收款支付寶帳戶"],@[@"會員公告",@"推薦好友"],@[@"關於幫幫寶"]];
    self.iconDataSource = @[@[@"mine_personal_information",@"mine_bank_account",@"mine_zhifubao"],@[@"mine_gonggao",@"mine_tuijian"],@[@"mine_about"]];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logout{
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"确认登出吗?" message:@"" buttonTitles:@[@"確認"] buttonStyle:JGActionSheetButtonStyleRed];
    section.titleLabel.textColor = DEFAULTTEXTCOLOR;
    section.titleLabel.font = DEFAULFONT;
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section, cancelSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if (indexPath.section == 0 && indexPath.row == 0) {
            [self exit];
        }
    }];
    [sheet showInView:[[UIApplication sharedApplication] keyWindow] animated:YES];
}

- (void) exit {
    [[AccountManager sharedAccountManager] userLogout];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setupRootViewController];
    [appDelegate.tabBarController setSelectedIndex:0];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CELL";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    cell.nameLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.iconDataSource[indexPath.section][indexPath.row]]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseViewController *viewController = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            MineInformationEditViewController *informationEditViewController = [[MineInformationEditViewController alloc] init];
            viewController = informationEditViewController;
        }else if (indexPath.row == 1) {
            MineBankInformationViewController *bankInformationViewController = [[MineBankInformationViewController alloc] init];
            viewController = bankInformationViewController;
        }else if (indexPath.row == 2) {
            MineAlipayInformationViewController *alipayInformationViewController = [[MineAlipayInformationViewController alloc] init];
            viewController = alipayInformationViewController;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MineMemberAnnouncementViewController *memberAnnouncementViewController = [[MineMemberAnnouncementViewController alloc] init];
            viewController = memberAnnouncementViewController;
        }else if (indexPath.row == 1) {
            MineRecommendFriendsViewController *recommendFriendsViewController = [[MineRecommendFriendsViewController alloc] init];
            viewController = recommendFriendsViewController;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MineAboutBangBangBaoViewController *aboutBangBangBaoViewController = [[MineAboutBangBangBaoViewController alloc] init];
            viewController = aboutBangBangBaoViewController;
        }
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getter and setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBARHEIGHT -TABBARHEIGHT)
                                                  style:UITableViewStyleGrouped];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        _tableView.sectionIndexColor = DEFAULTCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 50.0)]];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MineTableViewHeaderView *) headerView {
    if (!_headerView) {
        _headerView = [[MineTableViewHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 210.0)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
        _headerView.avatarImageView.image = [UIImage imageNamed:@"mine_avatar"];
        _headerView.nameLabel.text = @"蔣曉冬";
        [_headerView.identityButton setImage:[UIImage imageNamed:@"mine_identity"] forState:UIControlStateNormal];
        [_headerView.phoneButton setImage:[UIImage imageNamed:@"mine_phone"] forState:UIControlStateNormal];
        [_headerView.supermarketButton setImage:[UIImage imageNamed:@"mine_supermarket"] forState:UIControlStateNormal];
        _headerView.yuanbaoLabel.text = [NSString stringWithFormat:@"元寶 : %@",@"125"];
        _headerView.myRankLabel.text = @"VIP8";
        _headerView.myNumberLabel.text = @"586";
         _headerView.myRecommendLabel.text = @"6";
    }
    return _headerView;
}

- (UIButton *) logoutButton {
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [_logoutButton setImage:[UIImage imageNamed:@"mine_logout"] forState:UIControlStateNormal];
    }
    return _logoutButton;
}

@end

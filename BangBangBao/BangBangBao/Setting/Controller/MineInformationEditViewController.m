//
//  MineInformationEditViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/22/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineInformationEditViewController.h"
#import "MineTableViewCell.h"

@interface MineInformationEditViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *iconDataSource;

@end

@implementation MineInformationEditViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"個人資料編輯";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    self.dataSource = @[@[@"會員身份認證",@"行動電話驗證",@"開通商超付款"],@[@"修改E-mail",@"修改密碼"],@[@"推薦人行動電話"]];
    self.iconDataSource = @[@[@"mineinformation_identity",@"mineinformation_phone",@"mineinformation_supermarket"],@[@"mineinformation_email",@"mineinformation_password"],@[@"mineinformation_friends"]];
    [self.view addSubview:self.tableView];
}

#pragma mark - private methods

- (void) popToPreViewController {
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
    /*
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
     */
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
    }
    return _tableView;
}

@end

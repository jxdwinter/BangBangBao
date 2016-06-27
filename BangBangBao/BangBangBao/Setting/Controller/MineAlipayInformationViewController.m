//
//  MineAlipayInformationViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/22/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineAlipayInformationViewController.h"
#import "AccountApi.h"
#import "PaymentAlipayDatabaseHelper.h"
#import "Payment_Alipay.h"
#import "MineBankTableViewCell.h"
#import "MineAddAlipayViewController.h"
#import "AccountDeleteApi.h"
#import <JGActionSheet.h>

@interface MineAlipayInformationViewController () <UITableViewDelegate, UITableViewDataSource,AddAlipayDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MineAlipayInformationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"收款支付寶帳戶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    self.dataSource = [NSMutableArray new];
    NSArray *tmpArray = [[PaymentAlipayDatabaseHelper sharedPaymentAlipaysDatabaseHelper] queryAllAlipays];
    if (tmpArray && tmpArray.count) {
        for (NSDictionary *dic in tmpArray) {
            Payment_Alipay *alipay = [Payment_Alipay yy_modelWithJSON:dic];
            [self.dataSource addObject:alipay];
        }
    }
    [self.view addSubview:self.tableView];
    [self getPaymentAlipay];
}

#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addBank {
    if ([self.dataSource count] < 5) {
        MineAddAlipayViewController *addAlipayViewController = [[MineAddAlipayViewController alloc] init];
        addAlipayViewController.addAlipayDelegate = self;
        [self.navigationController pushViewController:addAlipayViewController animated:YES];
    }else{
        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"最多只能添加 5 個收款支付寶帳戶" withView:self.navigationController.view];
    }
}

- (void) getPaymentAlipay {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AccountApi *api = [[AccountApi alloc] init];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                NSDictionary *tmpDic = dic[@"alipay"];
                NSArray *tmpArray = [tmpDic allValues];
                NSMutableArray *tmpMutableArray = [NSMutableArray new];
                if (tmpArray) {
                    for (NSDictionary *d in tmpArray) {
                        Payment_Alipay *alipay = [Payment_Alipay yy_modelWithJSON:d];
                        if (alipay) {
                            [tmpMutableArray addObject:alipay];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[PaymentAlipayDatabaseHelper sharedPaymentAlipaysDatabaseHelper] savePaymentAlipaysWithAlipaysArray:tmpArray];
                        [self.dataSource removeAllObjects];
                        [self.dataSource addObjectsFromArray:tmpMutableArray];
                        [self.tableView reloadData];
                    });
                }
            }
        } failure:^(YTKBaseRequest *request) {
            dispatch_async(dispatch_get_main_queue(), ^{
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
            });
        }];
    });
}

- (NSString *) dealTextWithAlipay : (Payment_Alipay *) alipay {
    NSString *tmpString = @"";

    NSString *account_name = alipay.account_name;
    if (account_name.length >= 1) {
        account_name = [account_name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    NSString *account_number = alipay.account_number;

    tmpString = [tmpString stringByAppendingString:account_name?account_name:@""];
    tmpString = [tmpString stringByAppendingString:@"  "];
    tmpString = [tmpString stringByAppendingString:account_number?account_number:@""];
    return tmpString;
}

- (void)deleteAlipay : (Payment_Alipay *) alipay withIndexPath : (NSIndexPath *) indexPath {
    AccountDeleteApi *api = [[AccountDeleteApi alloc] initWithAccount_id:alipay.aid];
    RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
    [api addAccessory:accessory];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        [[PaymentAlipayDatabaseHelper sharedPaymentAlipaysDatabaseHelper] deleteAlipayWithAlipay_id:alipay.aid];
        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"刪除成功" withView:self.navigationController.view];
    } failure:^(YTKBaseRequest *request) {
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
}

#pragma mark - AddAlipayDelegate

- (void) reloadAlipay {
    [self getPaymentAlipay];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CELL";
    MineBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[MineBankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    Payment_Alipay *alipay = self.dataSource[indexPath.row];
    cell.infoLabel.text = [self dealTextWithAlipay:alipay];
    if ([alipay.account_status isEqualToString:@"non_exist"]) {
        cell.statusLabel.text = @"賬戶不存在";
        cell.statusLabel.textColor = DEFAULTTEXTCOLOR;
    }else if ([alipay.account_status isEqualToString:@"real_name_verified"]) {
        cell.statusLabel.text = @"賬戶正常";
        cell.statusLabel.textColor = [UIColor colorWithRed:0.53 green:0.72 blue:0.45 alpha:1.00];
    }else {
        cell.statusLabel.text = @"檢測中...";
        cell.statusLabel.textColor = DEFAULTTEXTCOLOR;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==  UITableViewCellEditingStyleDelete) {
        Payment_Alipay *alipay = self.dataSource[indexPath.row];
        JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"确认刪除吗?" message:@"" buttonTitles:@[@"確認"] buttonStyle:JGActionSheetButtonStyleDefault];
        section.titleLabel.textColor = DEFAULTTEXTCOLOR;
        section.titleLabel.font = DEFAULFONT;
        JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
        NSArray *sections = @[section, cancelSection];
        JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
        [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *idxPath) {
            [sheet dismissAnimated:YES];
            if (idxPath.section == 0 && idxPath.row == 0) {
                [self deleteAlipay:alipay withIndexPath:indexPath];
            }
        }];
        [sheet showInView:self.navigationController.view animated:YES];
    }
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"刪除";
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

- (UIButton *) addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
        [_addButton addTarget:self action:@selector(addBank) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setImage:[UIImage imageNamed:@"bankInformation_add"] forState:UIControlStateNormal];
    }
    return _addButton;
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

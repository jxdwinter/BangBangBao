//
//  MineBankInformationViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/22/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineBankInformationViewController.h"
#import "AccountApi.h"
#import "PaymentBankDatabaseHelper.h"
#import "Payment_Bank.h"
#import "MineBankTableViewCell.h"
#import "MineAddBankViewController.h"

@interface MineBankInformationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MineBankInformationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"付款銀行帳戶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    self.dataSource = [NSMutableArray new];
    NSArray *tmpArray = [[PaymentBankDatabaseHelper sharedPaymentBanksDatabaseHelper] queryAllBanks];
    if (tmpArray && tmpArray.count) {
        for (NSDictionary *dic in tmpArray) {
            Payment_Bank *bank = [Payment_Bank yy_modelWithJSON:dic];
            [self.dataSource addObject:bank];
        }
    }
    [self.view addSubview:self.tableView];
    [self getPaymentBank];
}

#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addBank {
    if ([self.dataSource count] < 5) {
        MineAddBankViewController *addBankViewController = [[MineAddBankViewController alloc] init];
        [self.navigationController pushViewController:addBankViewController animated:YES];
    }else{
        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"最多只能添加 5 個付款銀行帳戶" withView:self.navigationController.view];
    }
}

- (void) getPaymentBank {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AccountApi *api = [[AccountApi alloc] init];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                NSDictionary *tmpDic = dic[@"bank"];
                NSArray *tmpArray = [tmpDic allValues];
                NSMutableArray *tmpMutableArray = [NSMutableArray new];
                if (tmpArray) {
                    for (NSDictionary *d in tmpArray) {
                        Payment_Bank *bank = [Payment_Bank yy_modelWithJSON:d];
                        if (bank) {
                            [tmpMutableArray addObject:bank];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[PaymentBankDatabaseHelper sharedPaymentBanksDatabaseHelper] savePaymentBanksWithBanksArray:tmpArray];
                        [self.dataSource removeAllObjects];
                        [self.dataSource addObjectsFromArray:tmpMutableArray];
                        [self.tableView reloadData];
                    });
                }
            }
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"%@",request.responseString);
        }];
    });
}

- (NSString *) dealTextWithBank : (Payment_Bank *) bank {
    NSString *tmpString = @"";
    
    NSString *account_bank = bank.account_bank;
    if ([account_bank rangeOfString:@"|"].location != NSNotFound) {
        account_bank = [account_bank substringFromIndex:[account_bank rangeOfString:@"|"].location + 1];
    }
    
    NSString *account_name = bank.account_name;
    if (account_name.length >= 1) {
        account_name = [account_name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    NSString *account_number = bank.account_number;
    if (account_number.length >= 6) {
        account_number = [account_number substringWithRange:NSMakeRange(account_number.length - 6, 6)];
    }
    
    tmpString = [tmpString stringByAppendingString:account_bank];
    tmpString = [tmpString stringByAppendingString:@"  "];
    tmpString = [tmpString stringByAppendingString:account_name];
    tmpString = [tmpString stringByAppendingString:@"  "];
    tmpString = [tmpString stringByAppendingString:account_number];
    return tmpString;
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
    Payment_Bank *bank = self.dataSource[indexPath.row];
    cell.infoLabel.text = [self dealTextWithBank:bank];;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    }
    return _tableView;
}

@end

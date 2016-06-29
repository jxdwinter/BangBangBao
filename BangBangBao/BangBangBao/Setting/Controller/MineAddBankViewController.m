//
//  MineAddBankViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/29/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineAddBankViewController.h"
#import "BankInformation.h"

@interface MineAddBankViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSArray *leftDataSource;
@property (nonatomic, strong) NSArray *rightDataSource;

@end

@implementation MineAddBankViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新增銀行帳戶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"bank_info" ofType:@"json"];
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if(error){
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    NSDictionary *bankDic = [NSJSONSerialization
                                     JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                     options:0 error:NULL];
    self.leftDataSource = @[@"銀行",@"郵局",@"信用合作社",@"農會",@"漁會"];
    
    NSMutableArray *tmpBankArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"bank"] allKeys]) {
        NSString *value = bankDic[@"bank"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [tmpBankArray addObject:bank];
    }

    NSMutableArray *tmpPostArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"post"] allKeys]) {
        NSString *value = bankDic[@"post"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [tmpPostArray addObject:bank];
    }
    
    NSMutableArray *tmpCredit_cooperativeArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"credit_cooperative"] allKeys]) {
        NSString *value = bankDic[@"credit_cooperative"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [tmpCredit_cooperativeArray addObject:bank];
    }
    
    NSMutableArray *tmpPeasant_associationArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"peasant_association"] allKeys]) {
        NSString *value = bankDic[@"peasant_association"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [tmpPeasant_associationArray addObject:bank];
    }
    
    NSMutableArray *tmpFisherman_associationArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"fisherman_association"] allKeys]) {
        NSString *value = bankDic[@"fisherman_association"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [tmpFisherman_associationArray addObject:bank];
    }
    self.rightDataSource = @[tmpBankArray, tmpPostArray,tmpCredit_cooperativeArray,tmpPeasant_associationArray,tmpFisherman_associationArray];
    
    /**
     *  另外一種算法
     */
    /*
    self.leftDataSource = [NSMutableArray new];
    self.rightDataSource = [NSMutableArray new];
    
    for (NSString *key in [bankDic allKeys]) {
        if ([key isEqualToString:@"bank"]) {
            [self.leftDataSource addObject:@"銀行"];
        }else if ([key isEqualToString:@"post"]){
            [self.leftDataSource addObject:@"郵局"];
        }else if ([key isEqualToString:@"credit_cooperative"]){
            [self.leftDataSource addObject:@"信用合作社"];
        }else if ([key isEqualToString:@"peasant_association"]){
            [self.leftDataSource addObject:@"農會"];
        }else if ([key isEqualToString:@"fisherman_association"]){
            [self.leftDataSource addObject:@"漁會"];
        }
        NSMutableArray *tmpArray = [NSMutableArray new];
        for (NSString *k in [bankDic[key] allKeys]) {
            NSString *v = bankDic[key][k];
            BankInformation *bank = [[BankInformation alloc] initWithId:k withName:v];
            [tmpArray addObject:bank];
        }
        [self.rightDataSource addObject:tmpArray];
    }
    */
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

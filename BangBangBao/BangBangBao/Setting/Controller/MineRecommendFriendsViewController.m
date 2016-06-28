//
//  MineRecommendFriendsViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/22/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineRecommendFriendsViewController.h"
#import <ClusterPrePermissions/ClusterPrePermissions.h>
#import <APContact.h>
#import <APAddressBook.h>

@interface MineRecommendFriendsViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MineRecommendFriendsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"推薦好友";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    [self getContactData];
}

#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) getContactData {
    ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
    [permissions showContactsPermissionsWithTitle:@"允許訪問您的通訊錄?"
                                          message:@"將幫幫寶分享給您的好友!"
                                  denyButtonTitle:@"不允許"
                                 grantButtonTitle:@"允許"
                                completionHandler:^(BOOL hasPermission, ClusterDialogResult userDialogResult, ClusterDialogResult systemDialogResult) {
        if (hasPermission) {
            [MBProgressHUD showHUDWhileNetworkWithView:self.navigationController.view];
            __weak __typeof(self) weakSelf = self;
            APAddressBook *addressBook = [[APAddressBook alloc] init];
            addressBook.fieldsMask = APContactFieldName | APContactFieldPhonesOnly;
            addressBook.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name.firstName" ascending:YES],
                                            [NSSortDescriptor sortDescriptorWithKey:@"name.lastName" ascending:YES]];
            addressBook.filterBlock = ^BOOL(APContact *contact){
                return contact.phones.count > 0;
            };
            [addressBook loadContacts:^(NSArray<APContact *> *contacts, NSError *error) {
                if (contacts){
                    [weakSelf configDataSourceWithArray:contacts];
                }else if (error){
                    [MBProgressHUD hideHUDWhenNetworkFinishedFromView:self.navigationController.view];
                }
            }];
        } else {
            [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"不允許訪問您的通訊錄將無法分享" withView:self.navigationController.view];
        }
    }];
}

- (void) configDataSourceWithArray : (NSArray *) array {
    if (array && [array count]) {
        for (APContact *contact in array) {
            if ([contact.phones count] == 1) {
                NSDictionary *dic = @{@"cphone":contact.phones.lastObject.number,@"cname":contact.name.compositeName};
                [self.dataSource addObject:dic];
            }else if ([contact.phones count] > 1){
                for (APPhone *phone in contact.phones) {
                    NSDictionary *dic = @{@"cphone":phone.number,@"cname":contact.name.compositeName};
                    [self.dataSource addObject:dic];
                }
            }
        }
    }
    [MBProgressHUD hideHUDWhenNetworkFinishedFromView:self.navigationController.view];
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

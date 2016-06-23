//
//  Payment_Bank.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment_Bank : NSObject

/**
 "account_bank": "110|700 郵局",
 "account_bank_branch": "0021 存簿",
 "account_name": "楊濡瑄",
 "account_number": "24411460035471",
 "account_memo": "",
 "account_status": "normal",
 "account_credit_min": "0",
 "account_credit_max": "50",
 "account_webatm": "",
 "designated": false
 */

@property (nonatomic, copy) NSString *account_bank;//#银行
@property (nonatomic, copy) NSString *account_bank_branch;//#分行
@property (nonatomic, copy) NSString *account_name;//#姓名
@property (nonatomic, copy) NSString *account_number;//#账号
@property (nonatomic, copy) NSString *account_memo;
@property (nonatomic, copy) NSString *account_status;//
@property (nonatomic, copy) NSString *account_credit_min;//
@property (nonatomic, copy) NSString *account_credit_max;//
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *account_webatm;//#是否可以使用 webatm 付款，如果可以此值为URL链接
@property (nonatomic, assign) BOOL designated;//#约定账户
@property (nonatomic, assign) NSInteger option_id;//#ID

@end

//
//  Payment_Bank.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment_Bank : NSObject

@property (nonatomic, copy) NSString *aid;//
@property (nonatomic, copy) NSString *account_type;//
@property (nonatomic, copy) NSString *account_bank;//
@property (nonatomic, copy) NSString *account_name;//
@property (nonatomic, copy) NSString *account_number;
@property (nonatomic, copy) NSString *is_editable;//
@property (nonatomic, copy) NSString *account_status;//
@property (nonatomic, copy) NSString *account_charge_limit;//
@property (nonatomic, copy) NSString *account_signin_charge_limit;

@end

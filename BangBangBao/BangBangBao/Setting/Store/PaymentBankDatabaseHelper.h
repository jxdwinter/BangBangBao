//
//  PaymentBankDatabaseHelper.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Payment_Bank;

@interface PaymentBankDatabaseHelper : NSObject

+ (instancetype)sharedPaymentBanksDatabaseHelper;

- (void) savePaymentBanksWithBanksArray : (NSArray *) banksArray;
- (NSArray *) queryAllBanks;
- (void) deleteAllBanks;
- (void) deleteBankWithBank_id : (NSString *) bank_id;
- (void) addBankWithBank : (Payment_Bank *) bank;

@end

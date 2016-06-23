//
//  PaymentBankDatabaseHelper.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "PaymentBankDatabaseHelper.h"
#import <YTKKeyValueStore.h>
#import "Payment_Bank.h"

@implementation PaymentBankDatabaseHelper

+ (instancetype)sharedPaymentBanksDatabaseHelper {
    static dispatch_once_t onceToken;
    static PaymentBankDatabaseHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[PaymentBankDatabaseHelper alloc]init];
    });
    return helper;
}

- (YTKKeyValueStore *) store{
    return [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
}


- (void) savePaymentBanksWithBanksArray : (NSArray *) banksArray {
    if (banksArray && [banksArray count]) {
        for (NSDictionary *dic in banksArray) {
            [[self store] putObject:dic withId:dic[@"option_id"] intoTable:PAYMENTBANKTABLE];
        }
    }
}

- (NSArray *) queryAllBanks {
    return [[self store] getAllItemsFromTable:PAYMENTBANKTABLE];
}

- (void) deleteAllBanks {
    [[self store] clearTable:PAYMENTBANKTABLE];
}

- (void) deleteBankWithBank_id : (NSString *) bank_id {
    [[self store] deleteObjectById:bank_id fromTable:PAYMENTBANKTABLE];
}

- (void) addBankWithBank : (Payment_Bank *) bank {
    if (bank) {
        [[self store] putObject:[bank yy_modelToJSONObject] withId:[NSString stringWithFormat:@"%ld",(long)bank.option_id] intoTable:PAYMENTBANKTABLE];
    }
}

@end

//
//  PaymentAlipayDatabaseHelper.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/24/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "PaymentAlipayDatabaseHelper.h"
#import "Payment_Alipay.h"

@implementation PaymentAlipayDatabaseHelper

+ (instancetype)sharedPaymentAlipaysDatabaseHelper {
    static dispatch_once_t onceToken;
    static PaymentAlipayDatabaseHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[PaymentAlipayDatabaseHelper alloc]init];
    });
    return helper;
}

- (YTKKeyValueStore *) store{
    return [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
}

- (void) savePaymentAlipaysWithAlipaysArray : (NSArray *) alipaysArray {
    if (alipaysArray && [alipaysArray count]) {
        [self deleteAllAlipays];
        for (NSDictionary *dic in alipaysArray) {
            [[self store] putObject:dic withId:dic[@"aid"] intoTable:PAYMENTALIPAYTABLE];
        }
    }
}

- (NSArray *) queryAllAlipays {
    NSArray *tmpArray = [[self store] getAllItemsFromTable:PAYMENTALIPAYTABLE];
    NSMutableArray *tmpMutableArray = [NSMutableArray new];
    for (YTKKeyValueItem *itme in tmpArray) {
        [tmpMutableArray addObject:itme.itemObject];
    }
    return [tmpMutableArray copy];
}

- (void) deleteAllAlipays {
    [[self store] clearTable:PAYMENTALIPAYTABLE];
}

- (void) deleteAlipayWithAlipay_id : (NSString *) alipay_id {
    [[self store] deleteObjectById:alipay_id fromTable:PAYMENTALIPAYTABLE];
}

- (void) addBankWithBank : (Payment_Alipay *) alipay {
    if (alipay) {
        [[self store] putObject:[alipay yy_modelToJSONObject] withId:alipay.aid intoTable:PAYMENTALIPAYTABLE];
    }
}

@end

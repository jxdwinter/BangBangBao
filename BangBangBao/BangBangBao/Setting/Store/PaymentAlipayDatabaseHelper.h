//
//  PaymentAlipayDatabaseHelper.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/24/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Payment_Alipay;

@interface PaymentAlipayDatabaseHelper : NSObject

+ (instancetype)sharedPaymentAlipaysDatabaseHelper;

- (void) savePaymentAlipaysWithAlipaysArray : (NSArray *) alipaysArray;
- (NSArray *) queryAllAlipays;
- (void) deleteAllAlipays;
- (void) deleteAlipayWithAlipay_id : (NSString *) alipay_id;
- (void) addBankWithBank : (Payment_Alipay *) alipay;

@end

//
//  SharedDatabaseHelper.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CURRENTUSERTALBE @"currentUserTalbe"

#define PAYMENTBANKTABLE @"PaymentBankTable"

#define PAYMENTALIPAYTABLE @"PaymentAlipayTable"

@interface SharedDatabaseHelper : NSObject

+ (instancetype) sharedDatabaseHelper;

/**
 *  清理和当前用户相关的数据表
 */
- (void) clearAllCurrentUserDatabase;

@end

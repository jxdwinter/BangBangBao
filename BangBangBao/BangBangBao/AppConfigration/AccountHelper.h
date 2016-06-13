//
//  AccountHelper.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountHelper : NSObject

/**
 *  notification token
 *
 *  @param token token
 */
+ (void) saveAccountNotificationTokenWithToken : (NSString *) token;

/**
 *  Verify token
 *
 *  @param ticket token
 */
+ (void) saveAccountVerifyTokenWithToken : (NSString *) token;

/**
 *  phone
 *
 *  @param phone <#phone description#>
 */
+ (void) saveAccountInfoWithPhone : (NSString *) phone;

+ (void) deleteAccountInfo;

+ (NSString *) accountNotificationToken;
+ (NSString *) accountVerifyToken;
+ (NSString *) accountInfoPhone;

+ (void) updateAccountPhone : (NSString *) phone;

@end

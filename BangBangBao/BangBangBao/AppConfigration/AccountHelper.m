//
//  AccountHelper.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "AccountHelper.h"

@implementation AccountHelper

+ (void) saveAccountNotificationTokenWithToken : (NSString *) token{
    if (!token || token.length == 0) {
        token = @"0";
    }
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"NOTIFICATIONTOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) saveAccountVerifyTokenWithToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"VERIFYTOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) saveAccountInfoWithPhone : (NSString *) phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"PHONE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) deleteAccountInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PHONE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VERIFYTOKEN"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NOTIFICATIONTOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) accountNotificationToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"NOTIFICATIONTOKEN"]?[[NSUserDefaults standardUserDefaults] stringForKey:@"NOTIFICATIONTOKEN"]:@"0";
}

+ (NSString *) accountVerifyToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"VERIFYTOKEN"];
}

+ (NSString *) accountInfoPhone{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"PHONE"];
}

+ (void) updateAccountPhone : (NSString *) phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"PHONE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

//
//  VerifyTools.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyTools : NSObject

/*
 *验证手机号码
 */
+ (BOOL) verifyPhoneNumber : (NSString *) phoneNumber;

/*
 *验证六位数字验证码
 */
+ (BOOL) verifyVerityCode : (NSString *) verityCode;

/*
 *验证六位数字验证码
 */
+ (BOOL) verifyPassword : (NSString *) password;

/*
 *验证真实姓名中文
 */
+ (BOOL) verifyChinese: (NSString *) string;
/*
 *验证十位number
 */
+ (BOOL) verifyNumber: (NSString *) number;

@end

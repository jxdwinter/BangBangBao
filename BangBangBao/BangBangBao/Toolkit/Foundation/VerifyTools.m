//
//  VerifyTools.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "VerifyTools.h"

@implementation VerifyTools

+ (BOOL) verifyPhoneNumber : (NSString *) phoneNumber{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:phoneNumber];
}

+ (BOOL) verifyVerityCode : (NSString *) verityCode{
    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:verityCode];
}

+ (BOOL) verifyPassword : (NSString *) password{
    if (password.length >= 6 && password.length <= 16) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL) verifyChinese: (NSString *) string {
    NSString * const regularExpression = @"^[\u4E00-\u9FA5]+$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        NSLog(@"error %@", error);
    }
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string
                                                        options:0
                                                          range:NSMakeRange(0, [string length])];
    return numberOfMatches > 0;
}

+ (BOOL) verifyNumber: (NSString *) number {
    NSString *pattern = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:number];
}

@end

//
//  CreateAlipayAccountApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/27/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "CreateAlipayAccountApi.h"
#import "NSString+NSString_Extended.h"

@interface CreateAlipayAccountApi ()

@property (nonatomic, copy) NSString *account_number;

@end

@implementation CreateAlipayAccountApi

- (instancetype) initWithAccount_number : (NSString *) account_number {
    self = [super init];
    if (self) {
        self.account_number = account_number;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/u1/member-account/create-alipay-account?token=%@",[[AccountHelper accountVerifyToken] urlencode]];
}

- (id)requestArgument {
    return @{
             @"account_number" : self.account_number
             };
}

@end

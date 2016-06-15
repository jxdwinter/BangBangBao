//
//  LoginApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/13/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "LoginApi.h"

@interface LoginApi()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@implementation LoginApi

- (instancetype) initWithUsername : (NSString *) username withPassword : (NSString *) password {
    self = [super init];
    if (self) {
        self.username = username;
        self.password = password;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"/u1/member/login";
}

- (id)requestArgument {
    return @{
             @"username" : self.username,
             @"password" : self.password,
             @"udid" : [AccountHelper accountNotificationToken]
             };
}

@end

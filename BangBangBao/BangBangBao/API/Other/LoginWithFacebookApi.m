//
//  LoginWithFacebookApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/17/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "LoginWithFacebookApi.h"

@interface LoginWithFacebookApi ()

@property (nonatomic, copy) NSString *accessToken;

@end

@implementation LoginWithFacebookApi

- (instancetype) initWithFacebookAccessToken:(NSString *)accessToken {
    self = [super init];
    if (self) {
        self.accessToken = accessToken;
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
             @"fb_access_token" : self.accessToken,
             @"udid" : [AccountHelper accountNotificationToken]
             };
}


@end

//
//  AccountDeleteApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/27/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "AccountDeleteApi.h"
#import "NSString+NSString_Extended.h"

@interface AccountDeleteApi ()

@property (nonatomic, copy) NSString * account_id;

@end

@implementation AccountDeleteApi

- (instancetype) initWithAccount_id : (NSString *) account_id {
    self = [super init];
    if (self) {
        self.account_id = account_id;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/u1/member-account/delete?token=%@",[[AccountHelper accountVerifyToken] urlencode]];
}

- (id)requestArgument {
    return @{
             @"aid" : self.account_id
             };
}

@end

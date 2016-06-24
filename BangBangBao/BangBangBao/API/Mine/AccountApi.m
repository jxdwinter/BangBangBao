//
//  AccountApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/24/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "AccountApi.h"
#import "NSString+NSString_Extended.h"

@implementation AccountApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/u1/member-account?token=%@",[[AccountHelper accountVerifyToken] urlencode]];
}

@end

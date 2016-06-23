//
//  PaymentsApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "PaymentsApi.h"
#import "NSString+NSString_Extended.h"

@implementation PaymentsApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/u1/member/payments?token=%@",[[AccountHelper accountVerifyToken] urlencode]];
}

@end

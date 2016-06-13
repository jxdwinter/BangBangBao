//
//  MemberInformationApi.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/13/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MemberInformationApi.h"

@interface MemberInformationApi ()

@property (nonatomic, copy) NSString *mid;

@end

@implementation MemberInformationApi

- (instancetype) initWithMid : (NSString *) mid {
    self = [super init];
    if (self) {
        self.mid = mid;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl {
    return @"/u1/member";
}

- (id)requestArgument {
    return @{
             @"token" : [AccountHelper accountVerifyToken],
             @"mid" : self.mid
             };
}

@end

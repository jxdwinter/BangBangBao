//
//  LoginWithFacebookApi.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/17/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface LoginWithFacebookApi : ConfigYTKRequest

- (instancetype) initWithFacebookAccessToken : (NSString *) accessToken;

@end

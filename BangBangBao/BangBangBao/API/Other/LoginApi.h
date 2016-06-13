//
//  LoginApi.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/13/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface LoginApi : ConfigYTKRequest

- (instancetype) initWithUsername : (NSString *) username withPassword : (NSString *) password;

@end

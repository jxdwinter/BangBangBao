//
//  AccountDeleteApi.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/27/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface AccountDeleteApi : ConfigYTKRequest

- (instancetype) initWithAccount_id : (NSString *) account_id;

@end

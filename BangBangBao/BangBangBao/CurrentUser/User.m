//
//  User.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/14/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"the_new_email" : @"new_email",@"the_new_cellphone" : @"new_cellphone"};
}

@end

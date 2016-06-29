//
//  BankInformation.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/29/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "BankInformation.h"

@implementation BankInformation

- (instancetype) initWithId : (NSString *) bank_id withName : (NSString *) name {
    self = [super init];
    if (self) {
        self._id = bank_id;
        NSRange range = [name rangeOfString:@"|"];
        self.name = [name substringToIndex:range.location];
    }
    return self;
}

@end

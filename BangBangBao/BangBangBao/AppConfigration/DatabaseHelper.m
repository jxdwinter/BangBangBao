//
//  DatabaseHelper.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper

- (YTKKeyValueStore *) store {
    return [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
}

@end

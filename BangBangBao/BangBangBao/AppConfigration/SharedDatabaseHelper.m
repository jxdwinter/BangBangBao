//
//  SharedDatabaseHelper.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "SharedDatabaseHelper.h"
#import <YTKKeyValueStore.h>

@implementation SharedDatabaseHelper

static SharedDatabaseHelper* sharedDatabaseHelper = nil;

+ (instancetype) sharedDatabaseHelper{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedDatabaseHelper = [[self alloc] init] ;
    }) ;
    return sharedDatabaseHelper ;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        /**
         初始化数据库
         */
        YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
        /**
         *  当前登录用户
         */
        [store createTableWithName:CURRENTUSERTALBE];
    }
    return self;
}

- (void)clearAllCurrentUserDatabase{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
    [store description];
}

@end

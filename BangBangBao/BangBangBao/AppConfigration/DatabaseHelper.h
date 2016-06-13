//
//  DatabaseHelper.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore.h>

@interface DatabaseHelper : NSObject

- (YTKKeyValueStore *) store;

@end

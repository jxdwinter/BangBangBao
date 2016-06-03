//
//  Config.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
/**
 *  数据库名
 */
extern NSString *const DATABASENAME;

/**
 *  URL
 */
extern NSString *const BASEURL;

/**
 *  每一页的数量,用于翻页
 */
extern NSInteger const PAGENUMBER;



@end

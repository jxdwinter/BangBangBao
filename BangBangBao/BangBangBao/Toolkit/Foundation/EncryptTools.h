//
//  EncryptTools.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptTools : NSObject

/**
 *  sha1加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 加密过的字符串
 */
+ (NSString *)sha1:(NSString *)str;

@end

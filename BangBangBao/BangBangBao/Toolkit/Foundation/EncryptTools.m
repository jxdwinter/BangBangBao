//
//  EncryptTools.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "EncryptTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncryptTools

+ (NSString *)sha1:(NSString *)str{
    const char *cStr=[str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data=[NSData dataWithBytes:cStr length:str.length];
    uint8_t disgest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, disgest);
    NSMutableString *output=[NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",disgest[i]];
    }
    return output;
}
    
@end

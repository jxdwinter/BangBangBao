//
//  ConfigYTKRequest.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "ConfigYTKRequest.h"
#import <sys/utsname.h>

@implementation ConfigYTKRequest

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

/*
- (NSDictionary *)requestHeaderFieldValueDictionary {
    if ([[AccountHelper accountTicket] length] > 0 ) {
        return @{
                 @"Cookie":[NSString stringWithFormat:@"ticket=%@",[AccountHelper accountTicket]],
                 @"content-type": @"text/xml",
                 @"charset": @"UTF-8",
                 @"Device-Platform":@"1",
                 @"Deivce-Model":[self deviceModelName],
                 @"Device-Version":[[UIDevice currentDevice] systemVersion],
                 @"Client-Type":@"0",
                 @"Client-Version":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                 @"Client-Kind":@"1"
                 };
    }else{
        return @{
                 @"content-type": @"text/xml",
                 @"charset": @"UTF-8",
                 @"Device-Platform":@"1",
                 @"Deivce-Model":[self deviceModelName],
                 @"Device-Version":[[UIDevice currentDevice] systemVersion],
                 @"Client-Type":@"0",
                 @"Client-Version":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                 @"Client-Kind":@"1"
                 };
    }
}
*/

- (id)responseDictionaryWithResponseString : (NSString *) responseString{
    NSDictionary *jsonObjects = [[NSDictionary alloc]init];
    NSError *e = nil;
    jsonObjects = [NSJSONSerialization JSONObjectWithData: [responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                  options: NSJSONReadingMutableContainers
                                                    error: &e];
    if (e) {
        return  nil;
    }
    return jsonObjects;
}

- (NSString*)deviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

@end

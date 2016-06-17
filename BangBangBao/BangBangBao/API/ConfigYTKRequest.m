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

//
//  ConfigYTKRequest.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "YTKRequest.h"

/**
 *  网络请求公共类
 */
@interface ConfigYTKRequest : YTKRequest

- (id)responseDictionaryWithResponseString : (NSString *) responseString;

@end

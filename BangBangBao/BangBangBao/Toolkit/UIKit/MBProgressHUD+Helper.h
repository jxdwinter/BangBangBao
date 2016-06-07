//
//  MBProgressHUD+Helper.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Helper)

+ (void) showHUDwithSuccess : (BOOL) success WithTitle : (NSString *) title withView : (UIView *)view;
+ (void) showHUDWhileNetworkWithView : (UIView *) view;
+ (void) hideHUDWhenNetworkFinishedFromView : (UIView *)view;

@end

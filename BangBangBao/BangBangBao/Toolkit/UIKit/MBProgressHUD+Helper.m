//
//  MBProgressHUD+Helper.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#define HUDCOLOR [UIColor colorWithRed:(71/255.0) green:(179/255.0) blue:(155/255.0) alpha:.8]

#import "MBProgressHUD+Helper.h"

@implementation MBProgressHUD (Helper)

+ (void) showHUDwithSuccess : (BOOL) success WithTitle : (NSString *) title withView : (UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = title;
    [HUD show:YES];
    double delayInSeconds = 0.8;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}

+ (void) showHUDWhileNetworkWithView : (UIView *) view{
    if (view) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        [HUD show:YES];
    }else{
        [MBProgressHUD  showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

+ (void) hideHUDWhenNetworkFinishedFromView : (UIView *)view{
    if (view) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }else{
        [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

@end

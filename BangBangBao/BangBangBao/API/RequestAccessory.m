//
//  RequestAccessory.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "RequestAccessory.h"

@implementation RequestAccessory

- (void)requestWillStart:(id)request{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [MBProgressHUD showHUDWhileNetworkWithView:self.view];
}

- (void)requestWillStop:(id)request{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [MBProgressHUD hideHUDWhenNetworkFinishedFromView:self.view];
}

- (void)requestDidStop:(id)request{

}

- (instancetype) initAccessoryWithView : (UIView *)view{
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}

@end

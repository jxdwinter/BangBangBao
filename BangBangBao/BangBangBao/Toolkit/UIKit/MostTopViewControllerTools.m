//
//  MostTopViewControllerTools.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/6/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MostTopViewControllerTools.h"

@implementation MostTopViewControllerTools

+ (UIViewController*) topMostController{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

@end

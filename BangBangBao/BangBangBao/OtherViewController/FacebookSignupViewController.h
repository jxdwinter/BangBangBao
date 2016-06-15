//
//  FacebookSignupViewController.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/15/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "BaseViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookSignupViewController : BaseViewController

@property (nonatomic, strong) FBSDKAccessToken *accessToken;

@end

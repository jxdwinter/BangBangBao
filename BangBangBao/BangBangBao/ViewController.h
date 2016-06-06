//
//  ViewController.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@protocol ScanQRCodeSuccessfulDelegate <NSObject>

@required
- (void) scanQRCodeSuccessfulWithResult : (NSString *) result;

@end


@interface ViewController : BaseViewController<ScanQRCodeSuccessfulDelegate>


@end


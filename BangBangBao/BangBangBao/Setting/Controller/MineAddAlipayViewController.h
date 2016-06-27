//
//  MineAddAlipayViewController.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/24/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddAlipayDelegate <NSObject>

- (void) reloadAlipay;

@end

@interface MineAddAlipayViewController : BaseViewController

@property (nonatomic, weak) id<AddAlipayDelegate> addAlipayDelegate;

@end

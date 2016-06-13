//
//  RequestAccessory.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKBaseRequest.h>

@interface RequestAccessory : NSObject<YTKRequestAccessory>

@property (nonatomic,strong) UIView *view;

- (void)requestWillStart:(id)request;
- (void)requestWillStop:(id)request;
- (void)requestDidStop:(id)request;

- (instancetype) initAccessoryWithView : (UIView *)view;

@end

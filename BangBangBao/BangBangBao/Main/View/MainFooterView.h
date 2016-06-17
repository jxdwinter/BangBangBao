//
//  MainFooterView.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/17/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainFooterSubView;

@interface MainFooterView : UICollectionReusableView

@property (nonatomic, strong) MainFooterSubView *businessRecordView;
@property (nonatomic, strong) MainFooterSubView *yuanbaoBusinessRecordView;

@end

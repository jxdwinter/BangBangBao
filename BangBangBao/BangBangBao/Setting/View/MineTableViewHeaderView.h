//
//  MineTableViewHeaderView.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/19/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewHeaderView : UIView

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *identityButton;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *supermarketButton;
@property (nonatomic, strong) UILabel *yuanbaoLabel;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UILabel *myRankLabel;
@property (nonatomic, strong) UILabel *myNumberLabel;
@property (nonatomic, strong) UILabel *myRecommendLabel;

@end

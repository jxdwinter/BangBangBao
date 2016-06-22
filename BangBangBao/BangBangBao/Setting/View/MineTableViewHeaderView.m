//
//  MineTableViewHeaderView.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/19/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineTableViewHeaderView.h"

@implementation MineTableViewHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.clipsToBounds = YES;
        [self addSubview:self.avatarImageView];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(20.0);
            make.left.equalTo(self.mas_left).with.offset(20.0);
            make.width.equalTo(@60.0);
            make.height.equalTo(@60.0);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(30.0);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(20.0);
            make.right.equalTo(self.mas_right).with.offset(-20.0);
            make.height.equalTo(@20.0);
        }];
        
        self.identityButton = [[UIButton alloc] init];
        [self addSubview:self.identityButton];
        [self.identityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(20.0);
            make.width.equalTo(@20.0);
            make.height.equalTo(@20.0);
        }];
        
        self.phoneButton = [[UIButton alloc] init];
        [self addSubview:self.phoneButton];
        [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.identityButton.mas_right).with.offset(10.0);
            make.width.equalTo(@20.0);
            make.height.equalTo(@20.0);
        }];
        
        self.supermarketButton = [[UIButton alloc] init];
        [self addSubview:self.supermarketButton];
        [self.supermarketButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.phoneButton.mas_right).with.offset(10.0);
            make.width.equalTo(@20.0);
            make.height.equalTo(@20.0);
        }];
        
        self.yuanbaoLabel = [[UILabel alloc] init];
        self.yuanbaoLabel.textAlignment = NSTextAlignmentRight;
        self.yuanbaoLabel.textColor = DEFAULTTEXTCOLOR;
        self.yuanbaoLabel.font = DEFAULFONT;
        [self addSubview:self.yuanbaoLabel];
        [self.yuanbaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.supermarketButton.mas_right).with.offset(20.0);
            make.right.equalTo(self.mas_right).with.offset(-20.0);
            make.height.equalTo(@20.0);
        }];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(20.0);
            make.left.equalTo(self.mas_left).with.offset(20.0);
            make.right.equalTo(self.mas_right).with.offset(-20.0);
            make.height.equalTo(@10.0);
        }];
        
        self.progressView = [[UIView alloc] init];
        self.progressView.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.21 alpha:1.00];
        [view addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).with.offset(0.0);
            make.left.equalTo(view.mas_left).with.offset(0.0);
            make.width.equalTo(@200);
            make.height.equalTo(@10.0);
        }];
        
        UILabel*vip1Label = [[UILabel alloc] init];
        vip1Label.textColor = DEFAULTTEXTCOLOR;
        vip1Label.font = [UIFont systemFontOfSize:10.0];
        vip1Label.text = @"VIP1";
        [self addSubview:vip1Label];
        [vip1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).with.offset(0.0);
            make.left.equalTo(view.mas_left).with.offset(0.0);
            make.width.equalTo(@50);
            make.height.equalTo(@20.0);
        }];
        
        UILabel*familyLabel = [[UILabel alloc] init];
        familyLabel.textAlignment = NSTextAlignmentRight;
        familyLabel.textColor = DEFAULTTEXTCOLOR;
        familyLabel.font = [UIFont systemFontOfSize:10.0];
        familyLabel.text = @"FAMILY";
        [self addSubview:familyLabel];
        [familyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).with.offset(0.0);
            make.right.equalTo(view.mas_right).with.offset(0.0);
            make.width.equalTo(@50);
            make.height.equalTo(@20.0);
        }];
        
        UILabel *myRankInfoLabel = [[UILabel alloc] init];
        myRankInfoLabel.textColor = DEFAULTTEXTCOLOR;
        myRankInfoLabel.font = [UIFont systemFontOfSize:12.0];
        myRankInfoLabel.textAlignment = NSTextAlignmentCenter;
        myRankInfoLabel.text = @"我的等級";
        [self addSubview:myRankInfoLabel];
        [myRankInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vip1Label.mas_bottom).with.offset(20.0);
            make.left.equalTo(self.mas_left).with.offset(20.0);
            make.width.equalTo(@((SCREEN_WIDTH - 40.0)/3));
            make.height.equalTo(@20.0);
        }];
        
        self.myRankLabel = [[UILabel alloc] init];
        self.myRankLabel.textColor = DEFAULTTEXTCOLOR;
        self.myRankLabel.font = [UIFont systemFontOfSize:14.0];
        self.myRankLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.myRankLabel];
        [self.myRankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myRankInfoLabel.mas_bottom).with.offset(0.0);
            make.left.equalTo(self.mas_left).with.offset(20.0);
            make.width.equalTo(@((SCREEN_WIDTH - 40.0)/3));
            make.height.equalTo(@20.0);
        }];
        
        UIView *line1View = [[UIView alloc] init];
        line1View.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self addSubview:line1View];
        [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myRankInfoLabel.mas_top).with.offset(0.0);
            make.right.equalTo(myRankInfoLabel.mas_right).with.offset(0.0);
            make.bottom.equalTo(self.myRankLabel.mas_bottom).with.offset(0.0);
            make.width.equalTo(@1.0);
        }];
        
        UILabel *myNumberInfoLabel = [[UILabel alloc] init];
        myNumberInfoLabel.textColor = DEFAULTTEXTCOLOR;
        myNumberInfoLabel.font = [UIFont systemFontOfSize:12.0];
        myNumberInfoLabel.textAlignment = NSTextAlignmentCenter;
        myNumberInfoLabel.text = @"我的成長值";
        [self addSubview:myNumberInfoLabel];
        [myNumberInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vip1Label.mas_bottom).with.offset(20.0);
            make.left.equalTo(line1View.mas_right).with.offset(0.0);
            make.width.equalTo(@((SCREEN_WIDTH - 40.0)/3));
            make.height.equalTo(@20.0);
        }];

        self.myNumberLabel = [[UILabel alloc] init];
        self.myNumberLabel.textColor = DEFAULTTEXTCOLOR;
        self.myNumberLabel.font = [UIFont systemFontOfSize:14.0];
        self.myNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.myNumberLabel];
        [self.myNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myNumberInfoLabel.mas_bottom).with.offset(0.0);
            make.left.equalTo(line1View.mas_right).with.offset(0.0);
            make.width.equalTo(@((SCREEN_WIDTH - 40.0)/3));
            make.height.equalTo(@20.0);
        }];
        
        UIView *line2View = [[UIView alloc] init];
        line2View.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self addSubview:line2View];
        [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myNumberInfoLabel.mas_top).with.offset(0.0);
            make.right.equalTo(myNumberInfoLabel.mas_right).with.offset(0.0);
            make.bottom.equalTo(self.myNumberLabel.mas_bottom).with.offset(0.0);
            make.width.equalTo(@1.0);
        }];
        
        UILabel *myRecommendInfoLabel = [[UILabel alloc] init];
        myRecommendInfoLabel.textColor = DEFAULTTEXTCOLOR;
        myRecommendInfoLabel.font = [UIFont systemFontOfSize:12.0];
        myRecommendInfoLabel.textAlignment = NSTextAlignmentCenter;
        myRecommendInfoLabel.text = @"我推薦的好友";
        [self addSubview:myRecommendInfoLabel];
        [myRecommendInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vip1Label.mas_bottom).with.offset(20.0);
            make.left.equalTo(line2View.mas_right).with.offset(0.0);
            make.width.equalTo(@((SCREEN_WIDTH - 40.0)/3));
            make.height.equalTo(@20.0);
        }];
        
        self.myRecommendLabel = [[UILabel alloc] init];
        self.myRecommendLabel.textColor = DEFAULTTEXTCOLOR;
        self.myRecommendLabel.font = [UIFont systemFontOfSize:14.0];
        self.myRecommendLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.myRecommendLabel];
        [self.myRecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myRecommendInfoLabel.mas_bottom).with.offset(0.0);
            make.left.equalTo(line2View.mas_right).with.offset(0.0);
            make.width.equalTo(@((SCREEN_WIDTH - 40.0)/3));
            make.height.equalTo(@20.0);
        }];

    }
    return self;
}

@end

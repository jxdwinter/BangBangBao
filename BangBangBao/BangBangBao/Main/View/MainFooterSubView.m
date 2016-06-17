//
//  MainFooterSubView.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/17/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MainFooterSubView.h"

@implementation MainFooterSubView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(15.0);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.width.equalTo(@30.0);
            make.height.equalTo(@30.0);
        }];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(20.0);
            make.left.equalTo(self.iconImageView.mas_right).with.offset(10.0);
            make.height.equalTo(@20.0);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
        }];
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(22.5);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
            make.width.equalTo(@15.0);
            make.height.equalTo(@15.0);
        }];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
            make.left.equalTo(self.iconImageView.mas_right).with.offset(0.0);
            make.height.equalTo(@0.5);
            make.right.equalTo(self.mas_right).with.offset(0.0);
        }];
    }
    return self;
}

@end

//
//  MainCollectionViewCell.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/16/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(-10.0);
            make.width.equalTo(@30.0);
            make.height.equalTo(@30.0);
        }];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).with.offset(10.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
        UIView *horizontalLine = [[UIView alloc] init];
        horizontalLine.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self.contentView addSubview:horizontalLine];
        [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-0.5);
            make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
            make.height.equalTo(@0.5);
        }];
        
        UIView *verticalLine = [[UIView alloc] init];
        verticalLine.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self.contentView addSubview:verticalLine];
        [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0.0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.5);
            make.width.equalTo(@0.5);
        }];

    }
    return self;
}

@end

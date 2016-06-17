//
//  MineTableViewCell.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/17/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(20.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
            make.width.equalTo(@30.0);
            make.height.equalTo(@30.0);
        }];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(25.0);
            make.left.equalTo(self.iconImageView.mas_right).with.offset(20.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
            make.height.equalTo(@20.0);
        }];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-0.5);
            make.left.equalTo(self.iconImageView.mas_right).with.offset(0.0);
            make.height.equalTo(@0.5);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

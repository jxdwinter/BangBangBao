//
//  MineBankTableViewCell.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/24/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineBankTableViewCell.h"

@implementation MineBankTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(25.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-20.0);
            make.width.equalTo(@80.0);
            make.height.equalTo(@20.0);
        }];
        
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.textColor = DEFAULTTEXTCOLOR;
        self.infoLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(25.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
            make.right.equalTo(self.statusLabel.mas_left).with.offset(0.0);
            make.height.equalTo(@20.0);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-0.5);
            make.left.equalTo(self.contentView.mas_left).with.offset(20.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
            make.height.equalTo(@0.5);
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

//
//  MainFooterView.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/17/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MainFooterView.h"
#import "MainFooterSubView.h"

@implementation MainFooterView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(50.0);
            make.left.equalTo(self.mas_left).with.offset(0.0);
            make.right.equalTo(self.mas_right).with.offset(0.0);
            make.height.equalTo(@0.5);
        }];
        
        self.businessRecordView = [[MainFooterSubView alloc] initWithFrame:CGRectZero];
        self.businessRecordView.iconImageView.image = [UIImage imageNamed:@"main_business_record"];
        self.businessRecordView.nameLabel.text = @"交易記錄";
        [self addSubview:self.businessRecordView];
        [self.businessRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).with.offset(0.0);
            make.left.equalTo(self.mas_left).with.offset(0.0);
            make.right.equalTo(self.mas_right).with.offset(0.0);
            make.height.equalTo(@59.5);
        }];
        
        self.yuanbaoBusinessRecordView = [[MainFooterSubView alloc] initWithFrame:CGRectZero];
        self.yuanbaoBusinessRecordView.iconImageView.image = [UIImage imageNamed:@"main_yuanbao_business_record"];
        self.yuanbaoBusinessRecordView.nameLabel.text = @"元寶充值記錄";
        [self addSubview:self.yuanbaoBusinessRecordView];
        [self.yuanbaoBusinessRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.businessRecordView.mas_bottom).with.offset(0.0);
            make.left.equalTo(self.mas_left).with.offset(0.0);
            make.right.equalTo(self.mas_right).with.offset(0.0);
            make.height.equalTo(@60.0);
        }];
        
    }
    return self;
}

@end

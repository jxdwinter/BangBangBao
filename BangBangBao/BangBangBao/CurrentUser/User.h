//
//  User.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/14/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FacebookData.h"

@interface User : NSObject

@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *signup_time;//注册时间
@property (nonatomic, copy) NSString *signup_referer;//
@property (nonatomic, copy) NSString *the_new_email;
@property (nonatomic, copy) NSString *referrer;//推荐人 id
@property (nonatomic, copy) NSString *is_referrer;//#是否是推荐人，1表示推荐过其它用户注册过帮帮宝
@property (nonatomic, copy) NSString *modified;
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *gender;//性别
@property (nonatomic, copy) NSString *credits;//成长值
@property (nonatomic, copy) NSString *ingots;//元宝值
@property (nonatomic, copy) NSString *cellphone;//行动电话
@property (nonatomic, copy) NSString *the_new_cellphone;//新的行动电话
@property (nonatomic, copy) NSString *identity_card;//身份证号
@property (nonatomic, copy) NSString *identity_card_issue;
@property (nonatomic, copy) NSString *identity_card_type;
@property (nonatomic, copy) NSString *identity_card_verified;//是否验证过身份证
@property (nonatomic, copy) NSString *customer_type;//new 新顾客，regular 老顾客，交易成功过一笔订单的即为老顾客
@property (nonatomic, copy) NSString *modified_time;
@property (nonatomic, copy) NSString *credit_name;
@property (nonatomic, copy) NSString *rank_next;//下一个成长值级别
@property (nonatomic, copy) NSString *rank;//当前成长值级别
@property (nonatomic, strong) FacebookData *fb_data;

@end

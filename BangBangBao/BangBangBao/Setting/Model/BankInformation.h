//
//  BankInformation.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/29/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankInformation : NSObject

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;

- (instancetype) initWithId : (NSString *) bank_id withName : (NSString *) name;

@end

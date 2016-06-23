//
//  BBBSocketConnection.h
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBBSocketConnectionDelegate <NSObject>

- (void)didDisconnectWithError:(NSError *)error;
- (void)didConnectToHost:(NSString *)host port:(UInt16)port;
- (void)didReceiveData:(NSData *)data tag:(long)tag;

@end

@interface BBBSocketConnection : NSObject

@property (nonatomic, weak) id<BBBSocketConnectionDelegate> delegate;

- (void)connectWithHost:(NSString *)hostName port:(int)port;
- (void)disconnect;

- (BOOL)isConnected;
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag;

@end

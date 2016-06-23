//
//  BBBSocketConnection.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/23/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "BBBSocketConnection.h"
#import <GCDAsyncSocket.h>

@interface BBBSocketConnection () <GCDAsyncSocketDelegate>{
    GCDAsyncSocket *_asyncSocket;
}

@end

@implementation BBBSocketConnection

- (instancetype)init{
    if (self = [super init]) {
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)dealloc{
    _asyncSocket.delegate = nil;
    _asyncSocket = nil;
}

- (void)connectWithHost:(NSString *)hostName port:(int)port{
    NSError *error = nil;
    [_asyncSocket connectToHost:hostName onPort:port error:&error];
    if (error) {
        NSLog(@"[BBBSocketConnection] connectWithHost error: %@", error.description);
        if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
            [_delegate didDisconnectWithError:error];
        }
    }
}

- (void)disconnect{
    [_asyncSocket disconnect];
}

- (BOOL)isConnected{
    return [_asyncSocket isConnected];
}

- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag{
    [_asyncSocket readDataWithTimeout:timeout tag:tag];
}

- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag{
    [_asyncSocket writeData:data withTimeout:timeout tag:tag];
}

#pragma mark -
#pragma mark GCDAsyncSocketDelegate method

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"[BBBSocketConnection] didDisconnect...%@", err.description);
    if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
        [_delegate didDisconnectWithError:err];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"[BBBSocketConnection] didConnectToHost: %@, port: %d", host, port);
    if (_delegate && [_delegate respondsToSelector:@selector(didConnectToHost:port:)]) {
        [_delegate didConnectToHost:host port:port];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"[BBBSocketConnection] didReadData length: %lu, tag: %ld", (unsigned long)data.length, tag);
    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveData:tag:)]) {
        [_delegate didReceiveData:data tag:tag];
    }
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"[BBBSocketConnection] didWriteDataWithTag: %ld", tag);
    [sock readDataWithTimeout:-1 tag:tag];
}

@end

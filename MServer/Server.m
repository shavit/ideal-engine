//
//  Server.m
//  MServer
//
//  Created by Shavit Tzuriel on 1/27/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#import "Server.h"
#import <CoreFoundation/CFSocket.h>
#import <sys//socket.h>
#import <netinet/in.h>

#define LISTENQ 1024

@implementation SocketServer

- (instancetype)initOnPort:(int)port {
    
    return self;
}

@end

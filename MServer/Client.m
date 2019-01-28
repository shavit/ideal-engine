//
//  Client.m
//  MServer
//
//  Created by Shavit Tzuriel on 1/28/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#import "Client.h"
#import <CoreFoundation/CFSocket.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@implementation Client

- (instancetype)initWithAddress:(NSString *)addr andPort:(int)port {
    self.sockfd = CFSocketCreate(NULL, AF_INET, SOCK_STREAM, IPPROTO_TCP, 0, NULL, NULL);
    if (self.sockfd == NULL) {
        self.errorCode = SOCKETERROR;
    } else {
        struct sockaddr_in servaddr;
        memset(&servaddr, 0, sizeof(servaddr));
        servaddr.sin_len = sizeof(servaddr);
        servaddr.sin_family = AF_INET;
        servaddr.sin_port = htons(port);
        inet_pton(AF_INET, [addr cStringUsingEncoding:NSUTF8StringEncoding], &servaddr.sin_addr);
        CFDataRef connectAddr = CFDataCreate(NULL, (unsigned char *)&servaddr, sizeof(servaddr));
        
        if (connectAddr == NULL) {
            self.errorCode = CONNECTERROR;
        } else {
            if (CFSocketConnectToAddress(self.sockfd, connectAddr, 30) != kCFSocketSuccess) {
                self.errorCode = CONNECTERROR;
            }
        }
    }
    
    return self;
}

- (NSString *)writtenToSocket:(CFSocketRef)sockfdNum withChar:(NSString *)vptr {
    char buf[MAXLINE];
    CFSocketNativeHandle sock = CFSocketGetNative(sockfdNum);
    const char *msg = [vptr cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%s", msg);
    
    send(sock, msg, strlen(msg)+1, 0);
    recv(sock, buf, sizeof(buf), 0);
    
    NSLog(@"%s", buf);
    
    return [NSString stringWithUTF8String:buf];
}

@end

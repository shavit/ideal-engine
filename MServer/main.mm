//
//  main.cpp
//  MServer
//
//  Created by Shavit Tzuriel on 1/26/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#include <iostream>
#import "Server.h"
#import "Client.h"
#import <sys/socket.h>
#import <netinet/in.h>

int main(int argc, const char * argv[]) {
    NSString *filePath = @"demo.mp4";
    NSData *vid = [[NSData alloc] initWithContentsOfFile:filePath];

    std::cout << "File size: " << [vid length] << "\n";
    
    int error = 0;
    Client *client = [[Client alloc] initWithAddress:@"localhost" andPort:1935];
    error = [client errorCode];
    if (error != 0) {
        return error;
    }
    
    CFSocketCreate(NULL, AF_INET, SOCK_STREAM, IPPROTO_TCP, 0, NULL, NULL);
    CFSocketRef socket = CFSocketCreate(NULL, AF_INET, SOCK_STREAM, IPPROTO_TCP, 0, NULL, NULL);
    [client writeDataToSocket:socket data:vid];

    return error;
}

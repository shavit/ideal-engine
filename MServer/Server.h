//
//  Server.h
//  MServer
//
//  Created by Shavit Tzuriel on 1/27/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#ifndef Server_h
#define Server_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ServerErrorCode) {
    NOERROR,
    SOCKETERROR,
    BINDERROR,
    LISTENERROR,
    CFSOCKETCREATERROR,
    ACCEPTINGERROR
};

@interface SocketServer : NSObject

@property (nonatomic) CFSocketRef sRef;

@property (nonatomic) int listenfd, errorCode;

- (instancetype) initOnPort: (int)port;

@end


#endif /* Server_h */

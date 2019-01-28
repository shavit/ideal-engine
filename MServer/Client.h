//
//  Client.h
//  MServer
//
//  Created by Shavit Tzuriel on 1/28/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#ifndef Client_h
#define Client_h

#import <Foundation/Foundation.h>
#import "ErrorCodes.h"

#define MAXLINE 4096

@interface Client : NSObject

@property (nonatomic) int errorCode;

@property (nonatomic) CFSocketRef sockfd;

- (instancetype)initWithAddress:(NSString *)addr andPort:(int)port;

- (NSString *) writtenToSocket:(CFSocketRef)sockfdNum withChar:(NSString *)vptr;

@end

#endif /* Client_h */

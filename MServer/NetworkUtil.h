//
//  NetworkUtil.h
//  MServer
//
//  Created by Shavit Tzuriel on 1/26/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#ifndef NetworkUtil_h
#define NetworkUtil_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NetworkUtilErrorCode) {
    NOERROR,
    HOSTRESOLUTIONERROR,
    ADDRESSRESOLUTIONERROR
};

@interface NetworkUtil : NSObject

@property (nonatomic) int errorCode;

- (NSArray *)addressesForHostname:(NSString *)hostname;

- (NSArray *)hostnamesForAddress:(NSString *)address;

@end

#endif /* NetworkUtil_h */

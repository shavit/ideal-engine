//
//  NetworkUtil.m
//  MServer
//
//  Created by Shavit Tzuriel on 1/26/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#import "NetworkUtil.h"
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import <sys/types.h>
#import <sys/socket.h>
#import <netdb.h>

@implementation NetworkUtil

- (NSArray *)addressesForHostname:(NSString *)hostname {
    self.errorCode = NOERROR;
    char ipAddr[INET6_ADDRSTRLEN];
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    
    CFHostRef hostRef = CFHostCreateWithName(kCFAllocatorDefault, (CFStringRef)CFBridgingRetain(hostname));
    BOOL success = CFHostStartInfoResolution(hostRef, kCFHostAddresses, nil);
    if (!success) {
        self.errorCode = HOSTRESOLUTIONERROR;
        return nil;
    }
    
    CFArrayRef addressesRef = CFHostGetAddressing(hostRef, nil);
    if (addressesRef == nil) {
        self.errorCode = HOSTRESOLUTIONERROR;
        return nil;
    }
    
    CFIndex numAddresses = CFArrayGetCount(addressesRef);
    for (CFIndex currentIndex = 0; currentIndex < numAddresses; currentIndex++) {
        struct sockaddr *address = (struct sockaddr *)CFDataGetBytePtr(CFArrayGetValueAtIndex(addressesRef, currentIndex));
        if (address == nil) {
            self.errorCode = HOSTRESOLUTIONERROR;
            return nil;
        }
        
        getnameinfo(address, address->sa_len, ipAddr, INET6_ADDRSTRLEN, nil, 0, NI_NUMERICHOST);
        // if (ipAddr == nil) {
        if (sizeof(ipAddr) == 0 ){
            self.errorCode = HOSTRESOLUTIONERROR;
            return nil;
        }
        
        [addresses addObject:[NSString stringWithCString:ipAddr encoding:NSASCIIStringEncoding]];
    }
    
    return addresses;
}

- (NSArray *)hostnamesForAddress:(NSString *)address {
    self.errorCode = NOERROR;
    struct addrinfo hints;
    struct addrinfo *result = NULL;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC; // Any version, AF_INET or AF_INET6
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = 0;
    
    int error = getaddrinfo([address cStringUsingEncoding:NSASCIIStringEncoding], NULL, &hints, &result);
    if (error != 0) {
        self.errorCode = ADDRESSRESOLUTIONERROR;
        return nil;
    }
    CFDataRef addressRef = CFDataCreate(NULL, (UInt8 *)result->ai_addr, result->ai_addrlen);
    
    if (addressRef == nil) {
        self.errorCode = ADDRESSRESOLUTIONERROR;
        return nil;
    }
    freeaddrinfo(result);
    
    CFHostRef hostRef = CFHostCreateWithAddress(kCFAllocatorDefault, addressRef);
    if (hostRef == nil) {
        self.errorCode = ADDRESSRESOLUTIONERROR;
        return nil;
    }
    CFRelease(addressRef);
    
    BOOL isSuccess = CFHostStartInfoResolution(hostRef, kCFHostNames, NULL);
    if (isSuccess == false) {
        self.errorCode = ADDRESSRESOLUTIONERROR;
        return nil;
    }
    
    CFArrayRef hostnamesRef = CFHostGetNames(hostRef, NULL);
    NSMutableArray *hostnames = [NSMutableArray array];
    for (int currentIndex = 0; currentIndex < [(__bridge NSArray *)hostnamesRef count]; currentIndex++) {
        [hostnames addObject:[(__bridge NSArray *)hostnamesRef objectAtIndex:currentIndex]];
    }
    
    return hostnames;
}

@end

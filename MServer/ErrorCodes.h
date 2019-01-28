//
//  ErrorCodes.h
//  MServer
//
//  Created by Shavit Tzuriel on 1/28/19.
//  Copyright © 2019 Shavit. All rights reserved.
//

#ifndef ErrorCodes_h
#define ErrorCodes_h

typedef NS_ENUM(NSUInteger, ServerErrorCode) {
    NOERROR,
    SOCKETERROR,
    BINDERROR,
    LISTENERROR,
    SOCKETCREATERROR,
    ACCEPTINGERROR,
    
    CONNECTERROR,
    READERROR,
    WRITEERROR
};

#endif /* ErrorCodes_h */

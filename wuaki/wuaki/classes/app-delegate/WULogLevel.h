//
//  WULogLevel.h
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#ifndef WULogLevel_h
#define WULogLevel_h

#import <CocoaLumberjack/CocoaLumberjack.h>

// CocoaLumberjack default configuration
#if defined(CONFIGURATION_Debug) || defined(CONFIGURATION_Testing)
static const int ddLogLevel = DDLogFlagVerbose;
#else
static const int ddLogLevel = DDLogFlagInfo;
#endif

#endif /* WULogLevel_h */

//
//  INLogFormatter.m
//  wuaki
//
//  Created by José González Gómez on 31/3/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "INLogFormatter.h"


@interface INLogFormatter ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end


@implementation INLogFormatter

- (id)init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.mmm"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage.flag) {
        case DDLogFlagVerbose: logLevel = @"V"; break;
        case DDLogFlagDebug  : logLevel = @"D"; break;
        case DDLogFlagInfo   : logLevel = @"I"; break;
        case DDLogFlagWarning: logLevel = @"W"; break;
        case DDLogFlagError  : logLevel = @"E"; break;
        default              : logLevel = @"?";
    }
    
    NSString *file   = [[logMessage.file componentsSeparatedByString:@"/"] lastObject];
    
    return [NSString stringWithFormat:@"%@ %@ [%@] %@:%lu %@ %@", [self.dateFormatter stringFromDate:logMessage.timestamp], logLevel, logMessage.threadName, file, (unsigned long)logMessage.line, logMessage.function, logMessage.message];
}

@end

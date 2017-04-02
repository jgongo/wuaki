//
//  INHTTPRequestMatcher.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPRequestMatcher.h"


@implementation INPHTTPRequestMatcher

- (BOOL)evaluate {
    if (![self.subject isKindOfClass:[NSURLRequest class]])
        [NSException raise:@"KWMatcherException" format:@"subject is not an NSURLRequest"];

    return [self evaluateRequest:self.subject];
}

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    [NSException raise:@"KWMatcherException" format:@"evaluateRequest: method not implemented in matcher"];
    return NO;
}

@end

//
//  INHTTPRequestEmptyBodyMatcher.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPRequestEmptyBodyMatcher.h"


@implementation INPHTTPRequestEmptyBodyMatcher

#pragma mark Getting matcher strings

+ (NSArray *)matcherStrings {
    return @[@"haveEmptyBody"];
}

#pragma mark Matching

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    return request.HTTPBody == nil;
}

#pragma mark Failure messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to have an empty body"];
}

#pragma mark Matcher configuration

- (void)haveEmptyBody {}

@end

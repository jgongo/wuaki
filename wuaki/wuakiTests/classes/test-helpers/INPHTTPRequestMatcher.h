//
//  INHTTPRequestMatcher.h
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Kiwi/Kiwi.h>


@interface INPHTTPRequestMatcher : KWMatcher
- (BOOL)evaluateRequest:(NSURLRequest *)request;
@end

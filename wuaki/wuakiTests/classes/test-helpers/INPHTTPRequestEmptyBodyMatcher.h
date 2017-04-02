//
//  INHTTPRequestEmptyBodyMatcher.h
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INPHTTPRequestMatcher.h"


@interface INPHTTPRequestEmptyBodyMatcher : INPHTTPRequestMatcher
- (void)haveEmptyBody;
@end

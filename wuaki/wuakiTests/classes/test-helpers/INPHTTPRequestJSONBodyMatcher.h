//
//  INHTTPRequestEmptyBodyMatcher.h
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INPHTTPRequestMatcher.h"

@class INPHTTPJSONFixture;


@interface INPHTTPRequestJSONBodyMatcher : INPHTTPRequestMatcher
- (void)haveFixtureAsBody:(INPHTTPJSONFixture *)fixture;
- (void)haveJSONAsBody:(NSString *)json;
@end

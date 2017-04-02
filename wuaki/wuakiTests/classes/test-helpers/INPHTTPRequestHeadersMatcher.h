//
//  INHTTPRequestHeadersMatcher.h
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INPHTTPRequestMatcher.h"

extern NSString *const application_json;


@interface NSString (MediaTypeCharacterEncoding)
- (id)withUTF8Encoding;
@end


@interface INPHTTPRequestHeadersMatcher : INPHTTPRequestMatcher
- (void)containHeader:(NSString *)header withValue:(NSString *)value;
- (void)accept:(NSString *)mimeType;
- (void)haveContentType:(NSString *)contentType;
@end

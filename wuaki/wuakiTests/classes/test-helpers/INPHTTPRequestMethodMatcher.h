//
//  INHTTPRequestMethodMatcher.h
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INPHTTPRequestMatcher.h"


@interface INPHTTPRequestMethodMatcher : INPHTTPRequestMatcher
- (void)beGETRequest;
- (void)beHEADRequest;
- (void)bePOSTRequest;
- (void)bePUTRequest;
- (void)beDELETERequest;
- (void)beTRACERequest;
- (void)beOPTIONSRequest;
- (void)beCONNECTRequest;
- (void)bePATCHRequest;
- (void)beCustomRequestWithMethod:(NSString *)method;
@end

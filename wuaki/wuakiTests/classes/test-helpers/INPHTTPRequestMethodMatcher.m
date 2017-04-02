//
//  INHTTPRequestMethodMatcher.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPRequestMethodMatcher.h"


@interface INPHTTPRequestMethodMatcher ()
@property (nonatomic, copy) NSString *method;
@end


@implementation INPHTTPRequestMethodMatcher

#pragma mark Getting matcher strings

+ (NSArray *)matcherStrings {
    return @[@"beGETRequest", @"beHEADRequest", @"bePOSTRequest", @"bePUTRequest", @"beDELETERequest", @"beTRACERequest", @"beOPTIONSRequest", @"beCONNECTRequest", @"bePATCHRequest", @"beCustomRequestWithMethod:"];
}

#pragma mark Matching

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    return [request.HTTPMethod isEqualToString:self.method];
}

#pragma mark Failure messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to use %@ method, but used %@", self.method, ((NSURLRequest *)self.subject).HTTPMethod];
}

- (NSString *)failureMessageForShouldNot {
    return [NSString stringWithFormat:@"expected subject not to use %@ method", self.method];
}

#pragma mark Matcher configuration

- (void)beGETRequest {
    self.method = @"GET";
}

- (void)beHEADRequest {
    self.method = @"HEAD";
}

- (void)bePOSTRequest {
    self.method = @"POST";
}

- (void)bePUTRequest {
    self.method = @"PUT";
}

- (void)beDELETERequest {
    self.method = @"DELETE";
}

- (void)beTRACERequest {
    self.method = @"TRACE";
}

- (void)beOPTIONSRequest {
    self.method = @"OPTIONS";
}

- (void)beCONNECTRequest {
    self.method = @"CONNECT";
}

- (void)bePATCHRequest {
    self.method = @"PATCH";
}

- (void)beCustomRequestWithMethod:(NSString *)method {
    self.method = method;
}

@end

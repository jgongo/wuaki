//
//  INHTTPRequestHeadersMatcher.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPRequestHeadersMatcher.h"

NSString *const application_json = @"application/json";


@implementation NSString (MediaTypeCharacterEncoding)

- (id)withUTF8Encoding {
    return [self stringByAppendingString:@"; charset=utf-8"];
}

@end


@interface INPHTTPRequestHeadersMatcher ()
@property (nonatomic, strong) NSString *header;
@property (nonatomic, copy) NSString *value;
@end


@implementation INPHTTPRequestHeadersMatcher

#pragma mark Getting matcher strings

+ (NSArray *)matcherStrings {
    return @[@"containHeader:withValue:", @"accept:", @"haveContentType:"];
}

#pragma mark Matching

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    return [[request valueForHTTPHeaderField:self.header] isEqualToString:self.value];
}

#pragma mark Failure messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to contain '%@: %@' header, but couldn't find it in %@", self.header, self.value, ((NSURLRequest *)self.subject).allHTTPHeaderFields];
}

- (NSString *)failureMessageForShouldNot {
    return [NSString stringWithFormat:@"expected subject not to contain '%@: %@' header", self.header, self.value];
}

#pragma mark Matcher configuration

- (void)containHeader:(NSString *)header withValue:(NSString *)value {
    self.header = header;
    self.value = value;
}

- (void)accept:(NSString *)mimeType {
    [self containHeader:@"Accept" withValue:mimeType];
}

- (void)haveContentType:(NSString *)contentType {
    [self containHeader:@"Content-Type" withValue:contentType];
}

@end

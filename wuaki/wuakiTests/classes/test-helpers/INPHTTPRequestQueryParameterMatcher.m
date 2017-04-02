//
//  INPHTTPRequestQueryParameterMatcher.m
//  biid
//
//  Created by José González Gómez on 09/06/14.
//  Copyright (c) 2014 Firmaprofesional. All rights reserved.
//

#import "INPHTTPRequestQueryParameterMatcher.h"


#pragma mark Class extension

@interface INPHTTPRequestQueryParameterMatcher ()
@property (nonatomic, strong) NSString *parameter;
@property (nonatomic, strong) NSString *value;
@end


#pragma mark - Class implementation

@implementation INPHTTPRequestQueryParameterMatcher

#pragma mark Getting matcher strings

+ (NSArray *)matcherStrings {
    return @[@"haveQueryParameter:withValue:"];
}

#pragma mark Matching

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    NSString *parameter = [NSString stringWithFormat:@"%@=%@", [self.parameter stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]], [self.value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSRange parameterRange = [request.URL.query rangeOfString:parameter];
    if (parameterRange.location != NSNotFound) {
        if (parameterRange.location + parameterRange.length == request.URL.query.length) {
            // Parameter was at the end of the query string
            return YES;
        } else {
            // Parameter was not at the end of the query string, next character must be & or # to match
            NSString *firstCharacterAfterParameter = [request.URL.query substringWithRange:NSMakeRange(parameterRange.location + parameterRange.length, 1)];
            return [firstCharacterAfterParameter isEqualToString:@"&"] || [firstCharacterAfterParameter isEqualToString:@"#"];
        }
    } else {
        return NO;
    }
}

#pragma mark Failure messages

- (NSString *)failureMessageForShould {
    NSString *parameter = [NSString stringWithFormat:@"%@=%@", [self.parameter stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]], [self.value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    return [NSString stringWithFormat:@"expected subject to contain %@ in query string %@", parameter, ((NSURLRequest *)self.subject).URL.query];
}

- (NSString *)failureMessageForShouldNot {
    NSString *parameter = [NSString stringWithFormat:@"%@=%@", [self.parameter stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]], [self.value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    return [NSString stringWithFormat:@"expected subject not to contain %@ in query string %@", parameter, ((NSURLRequest *)self.subject).URL.query];
}

#pragma mark Matcher configuration

- (void)haveQueryParameter:(NSString *)parameter withValue:(NSString *)value {
    self.parameter = parameter;
    self.value = value;
}

@end

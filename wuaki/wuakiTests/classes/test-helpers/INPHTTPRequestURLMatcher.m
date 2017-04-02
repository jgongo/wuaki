//
//  INHTTPRequestURLMatcher.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPRequestURLMatcher.h"


@implementation NSURL (INPHTTPRequestMatchers)

- (BOOL)matchesPath:(NSString *)path {
    NSArray *urlComponents = self.pathComponents;
    NSArray *pathComponents = [[path componentsSeparatedByString:@"/"] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject length] > 0;
    }]];
    
    if ([urlComponents count] >= [pathComponents count]) {
        NSArray *componentsToCheck = [urlComponents subarrayWithRange:NSMakeRange([urlComponents count] - [pathComponents count], [pathComponents count])];
        __block BOOL match = YES;
        [pathComponents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj hasPrefix:@":"] && ![obj isEqual:[componentsToCheck objectAtIndex:idx]]) {
                match = NO;
                *stop = YES;
            }
        }];
        return match;
    } else {
        return NO;
    }
}

@end


@interface INPHTTPRequestURLMatcher ()
@property (nonatomic, strong) NSString *path;
@end


@implementation INPHTTPRequestURLMatcher

#pragma mark Getting matcher strings

+ (NSArray *)matcherStrings {
    return @[@"matchPath:"];
}

#pragma mark Matching

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    return [request.URL matchesPath:self.path];
}

#pragma mark Failure messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject URL to match %@, got %@", self.path, ((NSURLRequest *)self.subject).URL];
}

- (NSString *)failureMessageForShouldNot {
    return [NSString stringWithFormat:@"expected subject URL %@ not to match %@", ((NSURLRequest *)self.subject).URL, self.path];
}

#pragma mark Matcher configuration

- (void)matchPath:(NSString *)path {
    self.path = path;
}

@end

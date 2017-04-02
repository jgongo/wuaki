//
//  INHTTPRequestEmptyBodyMatcher.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPRequestJSONBodyMatcher.h"
#import "INPHTTPJSONFixture.h"


@interface NSData (NSInputStreamExtensions)
+ (NSData *)dataWithContentsOfStream:(NSInputStream *)input;
@end


@implementation NSData (NSInputStream)

+ (NSData *)dataWithContentsOfStream:(NSInputStream *)input {
    size_t bufferSize = 4096;
    uint8_t *buffer = malloc(4096);
    
    if (buffer) {
        NSMutableData *data = [NSMutableData data];
        [input open];
        while ([input hasBytesAvailable]) {
            NSInteger bytesRead = [input read:buffer maxLength:bufferSize];
            if (bytesRead > 0) {
                NSData *readData = [NSData dataWithBytes:buffer length:bytesRead];
                [data appendData:readData];
            } else if (bytesRead < 0) {
                free(buffer);
                [input close];
                return nil;
            }
        }
        free(buffer);
        [input close];
        return data;
    } else {
        return nil;
    }
}

@end


@interface INPHTTPRequestJSONBodyMatcher ()
@property (nonatomic, strong) id fixture;
@end


@implementation INPHTTPRequestJSONBodyMatcher

#pragma mark Getting matcher strings

+ (NSArray *)matcherStrings {
    return @[@"haveFixtureAsBody:", @"haveJSONAsBody:"];
}

#pragma mark Matching

- (BOOL)evaluateRequest:(NSURLRequest *)request {
    NSData *requestHTTPBody = request.HTTPBody ?: [NSData dataWithContentsOfStream:[[request copy] HTTPBodyStream]];
    id requestBody = [NSJSONSerialization JSONObjectWithData:requestHTTPBody options:0 error:nil];
    return [requestBody isEqual:self.fixture];
}

#pragma mark Failure messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to have %@ as body, got %@", self.fixture, [NSJSONSerialization JSONObjectWithData:((NSURLRequest *)self.subject).HTTPBody options:0 error:nil]];
}

#pragma mark Matcher configuration

- (void)haveFixtureAsBody:(INPHTTPJSONFixture *)fixture {
    self.fixture = fixture.jsonObject;
}

- (void)haveJSONAsBody:(NSString *)json {
    self.fixture = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

@end

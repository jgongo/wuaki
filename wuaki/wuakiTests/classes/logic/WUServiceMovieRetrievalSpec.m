//
//  WUServiceMovieRetrievalSpec.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Typhoon/Typhoon.h>

// Testing tools
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import "INPHTTPRequestMatchers.h"

// Test assembly
#import "WUAssembly.h"
#import "WUTestAssembly.h"

// Classes under test
#import "WUService.h"
#import "RKObjectManager+WuakiConfiguration.h"
#import "WUMovie.h"
#import "WUError.h"


SPEC_BEGIN(WUServiceMovieRetrievalSpec)

describe(@"Wuaki service - movie retrieval", ^{
    registerMatchers(@"INPHTTP");
    
    __block WUService *service;
    __block WUMovie   *movie;
    
    beforeEach(^{
        TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"], [WUTestAssembly assembly]]];
        service = [factory componentForType:[WUService class]];
        
        movie = [[WUMovie alloc] init];
        movie.identifier = @"example-movie";
    });
    
    context(@"communicating with the server", ^{
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                [[request should] matchPath:@"movies/example-movie"];
                [[request should] beGETRequest];
                [[request should] haveEmptyBody];
                [[request should] accept:application_json];
                [[request should] haveQueryParameter:@"classification_id" withValue:@"6"];
                [[request should] haveQueryParameter:@"device_identifier" withValue:@"web"];
                [[request should] haveQueryParameter:@"user_status"       withValue:@"visitor"];
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.movie.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should send a properly built request and invoke block on success", ^{
            __block BOOL success = NO;
            [service getMovieDetails:movie onSuccess:^(WUMovie *movie) { success = YES; } onError:^(NSError *error) {}];
            [[expectFutureValue(theValue(success)) shouldEventually] beYes]; // Needed so RestKit has time to perform the request asynchronously
        });
    });
    
    context(@"when the movie retrieval is successful", ^{
        __block WUMovie *receivedMovie;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.movie.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
            [service getMovieDetails:movie onSuccess:^(WUMovie *movie) { receivedMovie = movie; } onError:^(NSError *error) {}];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the movie", ^{
            [[expectFutureValue(receivedMovie)               shouldEventually] beNonNil];
            [[expectFutureValue(receivedMovie.identifier)    shouldEventually] equal:@"la-luz-de-mis-ojos"];
            [[expectFutureValue(receivedMovie.title)         shouldEventually] equal:@"La luz de mis ojos"];
            [[expectFutureValue(receivedMovie.originalTitle) shouldEventually] equal:@"Apple of my eye"];
            [[expectFutureValue(receivedMovie.actors)        shouldEventually] haveCountOf:6];
            // We assume the rest of the data is correctly mapped based on mapping tests
        });
    });
    
    context(@"when the movie retrieval fails", ^{
        __block NSError *receivedError;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.movie.error.json", [self class]) statusCode:404 headers:@{@"Content-Type" : @"application/json"}];
            }];
            [service getMovieDetails:movie onSuccess:^(WUMovie *movie) {} onError:^(NSError *error) { receivedError = error; }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the error information", ^{
            [[expectFutureValue(receivedError)                shouldEventually] beNonNil];
            [[expectFutureValue(receivedError.domain)         shouldEventually] equal:WUWuakiErrorDomain];
            [[expectFutureValue(theValue(receivedError.code)) shouldEventually] equal:theValue(404)];
            
            [[expectFutureValue(receivedError.userInfo[NSUnderlyingErrorKey])                         shouldEventually] haveCountOf:1];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).field)   shouldEventually] equal:@"base"];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).code)    shouldEventually] equal:@"error.not_found"];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).message) shouldEventually] equal:@"El recurso solicitado no existe"];
        });
    });
});

SPEC_END

//
//  WUServiceTVShowRetrievalSpec.m
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
#import "WUTVShow.h"
#import "WUError.h"


SPEC_BEGIN(WUServiceTVShowRetrievalSpec)

describe(@"Wuaki service - TV show retrieval", ^{
    registerMatchers(@"INPHTTP");
    
    __block WUService *service;
    __block WUTVShow  *tvShow;
    
    beforeEach(^{
        TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"], [WUTestAssembly assembly]]];
        service = [factory componentForType:[WUService class]];
        
        tvShow = [[WUTVShow alloc] init];
        tvShow.identifier = @"example-tv-show";
    });
    
    context(@"communicating with the server", ^{
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                [[request should] matchPath:@"tv_shows/example-tv-show"];
                [[request should] beGETRequest];
                [[request should] haveEmptyBody];
                [[request should] accept:application_json];
                [[request should] haveQueryParameter:@"classification_id" withValue:@"6"];
                [[request should] haveQueryParameter:@"device_identifier" withValue:@"web"];
                [[request should] haveQueryParameter:@"user_status"       withValue:@"visitor"];
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.tvShow.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should send a properly built request and invoke block on success", ^{
            __block BOOL success = NO;
            [service getTVShowDetails:tvShow onSuccess:^(WUTVShow *tvShow) { success = YES; } onError:^(NSError *error) {}];
            [[expectFutureValue(theValue(success)) shouldEventually] beYes]; // Needed so RestKit has time to perform the request asynchronously
        });
    });
    
    context(@"when the TV show retrieval is successful", ^{
        __block WUTVShow *receivedTVShow;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.tvShow.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
            [service getTVShowDetails:tvShow onSuccess:^(WUTVShow *tvShow) { receivedTVShow = tvShow; } onError:^(NSError *error) {}];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the TV show", ^{
            [[expectFutureValue(receivedTVShow)            shouldEventually] beNonNil];
            [[expectFutureValue(receivedTVShow.identifier) shouldEventually] equal:@"wolf-hall"];
            [[expectFutureValue(receivedTVShow.title)      shouldEventually] equal:@"Wolf Hall"];
            [[expectFutureValue(receivedTVShow.highlight)  shouldEventually] equal:@"ESTRENO EXCLUSIVO EN ESPAÑA"];
            [[expectFutureValue(receivedTVShow.seasons)    shouldEventually] haveCountOf:1];
            // We assume the rest of the data is correctly mapped based on mapping tests
        });
    });
    
    context(@"when the TV show retrieval fails", ^{
        __block NSError *receivedError;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.tvShow.error.json", [self class]) statusCode:404 headers:@{@"Content-Type" : @"application/json"}];
            }];
            [service getTVShowDetails:tvShow onSuccess:^(WUTVShow *movie) {} onError:^(NSError *error) { receivedError = error; }];
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

//
//  WUServiceFrontPageRetrievalSpec.m
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
#import "WUFrontPage.h"
#import "WUError.h"


SPEC_BEGIN(WUServiceFrontPageRetrievalSpec)

describe(@"Wuaki service - front page retrieval", ^{
    registerMatchers(@"INPHTTP");
    
    __block WUService *service;
    
    beforeEach(^{
        TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"], [WUTestAssembly assembly]]];
        service = [factory componentForType:[WUService class]];
    });
    
    context(@"communicating with the server", ^{
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                [[request should] matchPath:[service.objectManager.router.routeSet routeForClass:[WUFrontPage class] method:RKRequestMethodGET].pathPattern];
                [[request should] beGETRequest];
                [[request should] haveEmptyBody];
                [[request should] accept:application_json];
                [[request should] haveQueryParameter:@"classification_id" withValue:@"6"];
                [[request should] haveQueryParameter:@"device_identifier" withValue:@"web"];
                [[request should] haveQueryParameter:@"user_status"       withValue:@"visitor"];
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.frontPage.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should send a properly built request and invoke block on success", ^{
            __block BOOL success = NO;
            [service getFrontPageOnSuccess:^(WUFrontPage *frontPage) { success = YES; } onError:^(NSError *error) {}];
            [[expectFutureValue(theValue(success)) shouldEventually] beYes]; // Needed so RestKit has time to perform the request asynchronously
        });
    });
    
    context(@"when the front page retrieval is successful", ^{
        __block WUFrontPage *receivedFrontPage;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.frontPage.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
            [service getFrontPageOnSuccess:^(WUFrontPage *frontPage) { receivedFrontPage = frontPage; } onError:^(NSError *error) {}];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the front page", ^{
            [[expectFutureValue(receivedFrontPage) shouldEventually] beNonNil];
            [[expectFutureValue(receivedFrontPage.identifier) shouldEventually] equal:@"portada"];
            [[expectFutureValue(receivedFrontPage.name) shouldEventually] equal:@"Portada"];
            [[expectFutureValue(receivedFrontPage.lists) shouldEventually] haveCountOf:5];
            // We assume the rest of the data is correctly mapped based on mapping tests
        });
    });
    
    context(@"when the front page retrieval fails", ^{
        __block NSError *receivedError;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.frontPage.error.json", [self class]) statusCode:400 headers:@{@"Content-Type" : @"application/json"}];
            }];
            [service getFrontPageOnSuccess:^(WUFrontPage *frontPage) {} onError:^(NSError *error) { receivedError = error; }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the error information", ^{
            [[expectFutureValue(receivedError)                shouldEventually] beNonNil];
            [[expectFutureValue(receivedError.domain)         shouldEventually] equal:WUWuakiErrorDomain];
            [[expectFutureValue(theValue(receivedError.code)) shouldEventually] equal:theValue(400)];
            
            [[expectFutureValue(receivedError.userInfo[NSUnderlyingErrorKey])                         shouldEventually] haveCountOf:1];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).field)   shouldEventually] equal:@"user_status"];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).code)    shouldEventually] equal:@"exception.missing_user_status"];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).message) shouldEventually] equal:@"Lo sentimos, ha ocurrido un error interno con algún parámetro"];
        });
    });
});

SPEC_END

//
//  WUServiceStreamingRetrievalSpec.m
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
#import "WUMedia.h"
#import "WUMediaInfo.h"
#import "WULanguage.h"
#import "WUVideoQuality.h"
#import "WUAudioQuality.h"
#import "WUStreaming.h"
#import "WUStreamInfo.h"
#import "WUError.h"


SPEC_BEGIN(WUServiceStreamingRetrievalSpec)

describe(@"Wuaki service - streaming retrieval", ^{
    registerMatchers(@"INPHTTP");
    
    __block WUService *service;
    __block WUMovie   *movie;
    
    beforeEach(^{
        TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"], [WUTestAssembly assembly]]];
        service = [factory componentForType:[WUService class]];
        
        movie = [[WUMovie alloc] init];
        movie.identifier = @"example-movie";
        
        WUMediaInfo *trailerMediaInfo = [[WUMediaInfo alloc] init];
        trailerMediaInfo.audioLanguages = @[[[WULanguage alloc] init]];
        trailerMediaInfo.subtitleLanguages = @[[[WULanguage alloc] init]];
        trailerMediaInfo.videoQualities = @[[[WUVideoQuality alloc] init]];
        trailerMediaInfo.audioQualities = @[[[WUAudioQuality alloc] init]];
        
        movie.media = [[WUMedia alloc] init];
        movie.media.trailers = @[trailerMediaInfo];
        
        movie.media.trailers[0].audioLanguages[0].identifier = @"SPA";
        movie.media.trailers[0].subtitleLanguages[0].identifier = @"MIS";
        movie.media.trailers[0].videoQualities[0].identifier = @"SD";
        movie.media.trailers[0].audioQualities[0].identifier = @"2.0";
    });
    
    context(@"communicating with the server", ^{
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                [[request should] matchPath:@"streamings"];
                [[request should] bePOSTRequest];
                [[request should] haveEmptyBody];
                [[request should] accept:application_json];
                [[request should] haveQueryParameter:@"classification_id" withValue:@"6"];
                [[request should] haveQueryParameter:@"device_identifier" withValue:@"web"];
                [[request should] haveQueryParameter:@"device_serial"     withValue:@"AABBCCDDCC112233"];
                // [[request should] haveQueryParameter:@"player"            withValue:@"web:PD-NONE"]; // Deactivate this because encoding is different: : gets encoded as %3A
                [[request should] haveQueryParameter:@"video_type"        withValue:@"trailer"];
                [[request should] haveQueryParameter:@"content_id"        withValue:@"example-movie"];
                [[request should] haveQueryParameter:@"content_type"      withValue:@"movies"];
                [[request should] haveQueryParameter:@"audio_language"    withValue:@"SPA"];
                [[request should] haveQueryParameter:@"subtitle_language" withValue:@"MIS"];
                [[request should] haveQueryParameter:@"video_quality"     withValue:@"SD"];
                [[request should] haveQueryParameter:@"audio_quality"     withValue:@"2.0"];
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.streaming.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should send a properly built request and invoke block on success", ^{
            __block BOOL success = NO;
            [service getDefaultTrailer:movie onSuccess:^(WUStreaming *streaming) { success = YES; } onError:^(NSError *error) {}];
            [[expectFutureValue(theValue(success)) shouldEventually] beYes]; // Needed so RestKit has time to perform the request asynchronously
        });
    });
    
    context(@"when the streaming retrieval is successful", ^{
        __block WUStreaming *receivedStreaming;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.streaming.success.json", [self class]) statusCode:200 headers:@{@"Content-Type" : @"application/json;charset=UTF-8"}];
            }];
            [service getDefaultTrailer:movie onSuccess:^(WUStreaming *streaming) { receivedStreaming = streaming; } onError:^(NSError *error) {}];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the streaming", ^{
            [[expectFutureValue(receivedStreaming)                shouldEventually] beNonNil];
            [[expectFutureValue(receivedStreaming.identifier)     shouldEventually] equal:@"1b40c868-8e54-494e-8f2d-6f1c1f6f9648"];
            [[expectFutureValue(receivedStreaming.streams)        shouldEventually] haveCountOf:1];
            [[expectFutureValue(receivedStreaming.streams[0].url) shouldEventually] equal:[NSURL URLWithString:@"https://prod-stpeter-pmd.limelight.cdn.wuaki.tv/c/b/4/cb4ba53d45b1a3a11ab589c9aa02dc69-mc-0-95-0-0_SD_TRAILER_PAR_1_1.mp4?e=1491314429&h=f3b8ccf2ba3d1865b055cb9699885e24"]];
            // We assume the rest of the data is correctly mapped based on mapping tests
        });
    });
    
    context(@"when the streaming retrieval fails", ^{
        __block NSError *receivedError;
        
        beforeEach(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) { return YES; } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"response.streaming.error.json", [self class]) statusCode:400 headers:@{@"Content-Type" : @"application/json"}];
            }];
            [service getDefaultTrailer:movie onSuccess:^(WUStreaming *streaming) {} onError:^(NSError *error) { receivedError = error; }];
        });
        
        afterEach(^{ [OHHTTPStubs removeAllStubs]; });
        
        it(@"should return the error information", ^{
            [[expectFutureValue(receivedError)                shouldEventually] beNonNil];
            [[expectFutureValue(receivedError.domain)         shouldEventually] equal:WUWuakiErrorDomain];
            [[expectFutureValue(theValue(receivedError.code)) shouldEventually] equal:theValue(400)];
            
            [[expectFutureValue(receivedError.userInfo[NSUnderlyingErrorKey])                         shouldEventually] haveCountOf:1];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).field)   shouldEventually] equal:@"subtitle_language"];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).code)    shouldEventually] equal:@"exception.invalid_subtitle_language"];
            [[expectFutureValue(((WUError *)receivedError.userInfo[NSUnderlyingErrorKey][0]).message) shouldEventually] equal:@"Lo sentimos, ha ocurrido un error interno de protocolo"];
        });
    });
});

SPEC_END

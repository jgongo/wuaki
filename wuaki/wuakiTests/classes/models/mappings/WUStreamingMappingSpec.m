//
//  WUStreamingMappingSpec.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import <Typhoon/Typhoon.h>
#import "WUAssembly.h"
#import "WUTestAssembly.h"

#import <RestKit/Testing.h>
#import "INRestKitHelper.h"

#import "WUStreaming.h"
#import "WUStreamInfo.h"


SPEC_BEGIN(WUStreamingMappingSpec)

describe(@"WUStreaming mapping", ^{
    registerMatchers(@"RK");
    
    __block INRestKitHelper *restkitHelper;
    __block RKMappingTest *mappingTest;
    
    beforeAll(^{
        [RKTestFixture setFixtureBundle:[NSBundle bundleForClass:[self class]]];
        TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"], [WUTestAssembly assembly]]];
        restkitHelper = [factory componentForType:[INRestKitHelper class]];
    });
    
    afterEach(^{
        mappingTest = nil;
        [restkitHelper tearDown];
    });
    
    context(@"when parsing a valid streaming object", ^{
        __block WUStreaming *parsedStreaming;
        
        beforeEach(^{
            mappingTest = [restkitHelper setupMappingTestForClass:[WUStreaming class] withFixture:@"streaming.json"];
            [mappingTest performMapping];
            parsedStreaming = mappingTest.destinationObject;
        });
        
        specify(^{ [[parsedStreaming.identifier should] equal:@"63b63ab5-34c3-4e9f-be7a-52833e761b33"]; });
        
        specify(^{ [[theValue(parsedStreaming.streams.count) should] equal:theValue(1)]; });
        context(@"with stream infos", ^{
            __block WUStreamInfo *streamInfo;
            beforeEach(^{ streamInfo = parsedStreaming.streams[0]; });
            specify(^{ [[streamInfo.player should] equal:@"web:PD-NONE"]; });
            specify(^{ [[streamInfo.url    should] equal:[NSURL URLWithString:@"https://prod-stpeter-pmd.limelight.cdn.wuaki.tv/c/b/4/cb4ba53d45b1a3a11ab589c9aa02dc69-mc-0-95-0-0_SD_TRAILER_PAR_1_1.mp4?e=1491213272&h=aeaed75f23b8c6ddc90feb1a04c859cd"]]; });
            specify(^{ [[streamInfo.cdn    should] equal:@"AKAMAI"]; });
            specify(^{ [[streamInfo.wrid   should] equal:@"7663f5fd716ccadf98651440281661f9"]; });
        });
    });
});

SPEC_END

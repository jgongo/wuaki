//
//  WUStreamInfoMappingSpec.m
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

#import "WUStreamInfo.h"


SPEC_BEGIN(WUStreamInfoMappingSpec)

describe(@"WUStreamInfo mapping", ^{
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
        __block WUStreamInfo *parsedStreamInfo;
        
        beforeEach(^{
            mappingTest = [restkitHelper setupMappingTestForClass:[WUStreamInfo class] withFixture:@"streamInfo.json"];
            [mappingTest performMapping];
            parsedStreamInfo = mappingTest.destinationObject;
        });
        
        specify(^{ [[parsedStreamInfo.player should] equal:@"web:PD-NONE"]; });
        specify(^{ [[parsedStreamInfo.url    should] equal:[NSURL URLWithString:@"https://prod-stpeter-pmd.limelight.cdn.wuaki.tv/c/b/4/cb4ba53d45b1a3a11ab589c9aa02dc69-mc-0-95-0-0_SD_TRAILER_PAR_1_1.mp4?e=1491213272&h=aeaed75f23b8c6ddc90feb1a04c859cd"]]; });
        specify(^{ [[parsedStreamInfo.cdn    should] equal:@"AKAMAI"]; });
        specify(^{ [[parsedStreamInfo.wrid   should] equal:@"7663f5fd716ccadf98651440281661f9"]; });
    });
});

SPEC_END

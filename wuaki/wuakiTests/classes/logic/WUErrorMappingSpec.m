//
//  WUErrorMappingSpec.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import <Typhoon/Typhoon.h>
#import "WUAssembly.h"
#import "WUTestAssembly.h"

#import <RestKit/Testing.h>
#import "INRestKitHelper.h"

#import "WUError.h"


SPEC_BEGIN(WUErrorMappingSpec)

describe(@"WUError mapping", ^{
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
    
    context(@"when parsing a valid error object", ^{
        __block WUError *parsedError;
        
        beforeEach(^{
            mappingTest = [restkitHelper setupMappingTestForClass:[WUError class] withFixture:@"error.json"];
            [mappingTest performMapping];
            parsedError = mappingTest.destinationObject;
        });
        
        specify(^{ [[parsedError.field   should] equal:@"user_status"]; });
        specify(^{ [[parsedError.code    should] equal:@"exception.missing_user_status"]; });
        specify(^{ [[parsedError.message should] equal:@"Lo sentimos, ha ocurrido un error interno con algún parámetro"]; });
    });
});

SPEC_END

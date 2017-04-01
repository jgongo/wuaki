//
//  WUAssemblySpec.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Typhoon/Typhoon.h>
#import <RestKit/RestKit.h>

// Classes under test
#import "WUAssembly.h"
#import "WUService.h"
#import "RKObjectManager+WuakiConfiguration.h"


SPEC_BEGIN(WUAssemblySpec)

describe(@"WUAssembly", ^{
    __block TyphoonComponentFactory *factory;
    __block WUService *service;
    
    beforeEach(^{
        factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"]]];
        service = [factory componentForType:[WUService class]];
    });
    
    it(@"should create a non nil Wuaki service", ^{ [[service should] beNonNil]; });
    it(@"should create a singleton Wuaki service", ^{
        WUService *otherService = [factory componentForType:[WUService class]];
        [[otherService should] beIdenticalTo:service];
    });
    
    it(@"should inject a non nil object manager into the service", ^{ [[service.objectManager should] beNonNil]; });
    it(@"should create a singleton object manager", ^{
        RKObjectManager *otherObjectManager = [factory componentForKey:@"objectManager"];
        [[otherObjectManager should] beIdenticalTo:service.objectManager];
    });
    
    it(@"should inject the base URL into the object manager", ^{ [[service.objectManager.baseURL should] equal:[NSURL URLWithString:@"https://gizmo.wuaki.tv/v3/"]]; });
    it(@"should inject a non nil mapping catalog into the object manager", ^{ [[(NSObject *)service.objectManager.mappingCatalog should] beNonNil]; });
});

SPEC_END

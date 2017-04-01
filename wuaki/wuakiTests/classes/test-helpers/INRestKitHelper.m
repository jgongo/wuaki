//
//  INRestKitHelper.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "INRestKitHelper.h"
#import <RestKit/Testing.h>
#import "INMappingCatalog.h"


@implementation INRestKitHelper

+ (instancetype)helperWithCatalog:(id<INMappingCatalog>)mappingCatalog {
    return [[INRestKitHelper alloc] initWithCatalog:mappingCatalog];
}

- (instancetype)initWithCatalog:(id<INMappingCatalog>)mappingCatalog {
    self = [super init];
    if (self) {
        self.mappingCatalog = mappingCatalog;
    }
    return self;
}

- (RKMappingTest *)setupMappingTestForClass:(Class)class withFixture:(NSString *)fixture {
    [RKTestFactory setUp];
    id parsedObject = [RKTestFixture parsedObjectWithContentsOfFixture:fixture];
    return [RKMappingTest testForMapping:[self.mappingCatalog mappingForClass:class] sourceObject:parsedObject destinationObject:nil];
}

- (RKMappingTest *)setupInverseMappingTestForClass:(Class)class withObject:(id)object {
    [RKTestFactory setUp];
    return [RKMappingTest testForMapping:[self.mappingCatalog inverseMappingForClass:class] sourceObject:object destinationObject:nil];
}

- (RKMappingTest *)setupInverseMappingTestForObject:(id)object {
    return [self setupInverseMappingTestForClass:[object class] withObject:object];
}

- (void)tearDown {
    [RKTestFactory tearDown];
}

@end

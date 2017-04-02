//
//  WUContent+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUContent+MappedEntity.h"
#import "WUMovie+MappedEntity.h"
#import "WUTVShow+MappedEntity.h"


@implementation WUContent (MappedEntity)

+ (RKMapping *)mapping {
    RKDynamicMapping *mapping = [RKDynamicMapping new];
    [mapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"type" expectedValue:@"movies"   objectMapping:(RKObjectMapping *)[WUMovie  mapping]]];
    [mapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"type" expectedValue:@"tv_shows" objectMapping:(RKObjectMapping *)[WUTVShow mapping]]];
    return mapping;
}

@end

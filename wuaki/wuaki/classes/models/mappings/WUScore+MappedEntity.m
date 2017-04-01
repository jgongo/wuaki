//
//  WUScore+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUScore+MappedEntity.h"
#import "WUSite+MappedEntity.h"


@implementation WUScore (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *siteMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"site" toKeyPath:@"site" withMapping:[WUSite mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"href": @"url"}];
    [mapping addAttributeMappingsFromArray:@[@"score"]];
    [mapping addPropertyMapping:siteMapping];
    return mapping;
}

@end

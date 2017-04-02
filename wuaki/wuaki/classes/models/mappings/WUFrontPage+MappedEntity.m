//
//  WUFrontPage+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUFrontPage+MappedEntity.h"
#import "WUList+MappedEntity.h"


@implementation WUFrontPage (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *listMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"lists" toKeyPath:@"lists" withMapping:[WUList mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier"}];
    [mapping addAttributeMappingsFromArray:@[@"name"]];
    [mapping addPropertyMappingsFromArray:@[listMapping]];
    return mapping;
}

@end

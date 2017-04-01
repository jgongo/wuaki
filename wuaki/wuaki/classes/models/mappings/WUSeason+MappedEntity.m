//
//  WUSeason+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUSeason+MappedEntity.h"
#import "WUImage+MappedEntity.h"


@implementation WUSeason (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *imageMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"image" withMapping:[WUImage mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"display_name": @"displayName"}];
    [mapping addAttributeMappingsFromArray:@[@"title", @"year", @"label", @"highlight"]];
    [mapping addPropertyMapping:imageMapping];
    return mapping;
}

@end

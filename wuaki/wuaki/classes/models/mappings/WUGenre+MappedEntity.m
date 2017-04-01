//
//  WUGenre+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUGenre+MappedEntity.h"
#import "WUIcon+MappedEntity.h"


@implementation WUGenre (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *iconMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"additional_images" toKeyPath:@"icon" withMapping:[WUIcon mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier"}];
    [mapping addAttributeMappingsFromArray:@[@"name", @"adult", @"erotic"]];
    [mapping addPropertyMapping:iconMapping];
    return mapping;
}

@end

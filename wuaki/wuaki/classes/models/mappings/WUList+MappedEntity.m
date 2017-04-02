//
//  WUList+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUList+MappedEntity.h"
#import "WUContent+MappedEntity.h"
#import "WUContentTypeValueTransformer.h"


@implementation WUList (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *contentMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"contents.data" toKeyPath:@"content" withMapping:[WUContent mapping]];
    RKAttributeMapping *contentTypeMapping = [RKAttributeMapping attributeMappingFromKeyPath:@"content_type" toKeyPath:@"contentType"];
    contentTypeMapping.valueTransformer = [[WUContentTypeValueTransformer alloc] init];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"short_name": @"shortName"}];
    [mapping addAttributeMappingsFromArray:@[@"name"]];
    [mapping addPropertyMappingsFromArray:@[contentMapping]];
    [mapping addPropertyMapping:contentTypeMapping];
    return mapping;
}

@end

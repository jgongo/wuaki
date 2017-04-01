//
//  WUStreaming+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUStreaming+MappedEntity.h"
#import "WUStreamInfo+MappedEntity.h"


@implementation WUStreaming (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *streamInfoMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"stream_infos" toKeyPath:@"streams" withMapping:[WUStreamInfo mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier"}];
    [mapping addPropertyMapping:streamInfoMapping];
    return mapping;
}

@end

//
//  WUMedia+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUMedia+MappedEntity.h"
#import "WUMediaInfo+MappedEntity.h"


@implementation WUMedia (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *trailerMapping       = [RKRelationshipMapping relationshipMappingFromKeyPath:@"public.trailers"         toKeyPath:@"trailers"       withMapping:[WUMediaInfo mapping]];
    RKRelationshipMapping *previewMapping       = [RKRelationshipMapping relationshipMappingFromKeyPath:@"public.previews"         toKeyPath:@"previews"       withMapping:[WUMediaInfo mapping]];
    RKRelationshipMapping *streamMapping        = [RKRelationshipMapping relationshipMappingFromKeyPath:@"private.streams"         toKeyPath:@"streams"        withMapping:[WUMediaInfo mapping]];
    RKRelationshipMapping *offlineStreamMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"private.offline_streams" toKeyPath:@"offlineStreams" withMapping:[WUMediaInfo mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addPropertyMappingsFromArray:@[trailerMapping, previewMapping, streamMapping, offlineStreamMapping]];
    return mapping;
}

@end

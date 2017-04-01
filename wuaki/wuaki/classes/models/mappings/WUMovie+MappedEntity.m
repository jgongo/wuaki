//
//  WUMovie+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUMovie+MappedEntity.h"
#import "WUClassification+MappedEntity.h"
#import "WUGenre+MappedEntity.h"
#import "WUImage+MappedEntity.h"
#import "WUScore+MappedEntity.h"
#import "WUPeople+MappedEntity.h"
#import "WUMedia+MappedEntity.h"


@implementation WUMovie (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *classificationMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"classification" toKeyPath:@"classification" withMapping:[WUClassification mapping]];
    RKRelationshipMapping *genreMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"genres"         toKeyPath:@"genres"         withMapping:[WUGenre          mapping]];
    RKRelationshipMapping *imageMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"images"         toKeyPath:@"image"          withMapping:[WUImage          mapping]];
    RKRelationshipMapping *scoreMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"scores"         toKeyPath:@"scores"         withMapping:[WUScore          mapping]];
    
    RKRelationshipMapping *directorMapping       = [RKRelationshipMapping relationshipMappingFromKeyPath:@"directors"      toKeyPath:@"directors"      withMapping:[WUPeople         mapping]];
    RKRelationshipMapping *actorMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"actors"         toKeyPath:@"actors"         withMapping:[WUPeople         mapping]];
    RKRelationshipMapping *mediaMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"view_options"   toKeyPath:@"media"          withMapping:[WUMedia          mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"original_title": @"originalTitle", @"short_plot": @"shortPlot", @"duration": @"durationInMinutes", @"duration_in_seconds": @"durationInSeconds"}];
    [mapping addAttributeMappingsFromArray:@[@"title", @"highlight", @"year", @"plot"]];
    [mapping addPropertyMappingsFromArray:@[classificationMapping, genreMapping, imageMapping, scoreMapping, directorMapping, actorMapping, mediaMapping]];
    return mapping;
}

@end

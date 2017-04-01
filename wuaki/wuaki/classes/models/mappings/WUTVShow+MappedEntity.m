//
//  WUTVShow+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUTVShow+MappedEntity.h"
#import "WUClassification+MappedEntity.h"
#import "WUGenre+MappedEntity.h"
#import "WUImage+MappedEntity.h"
#import "WUScore+MappedEntity.h"
#import "WUSeason+MappedEntity.h"


@implementation WUTVShow (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *classificationMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"classification" toKeyPath:@"classification" withMapping:[WUClassification mapping]];
    RKRelationshipMapping *genreMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"genres"         toKeyPath:@"genres"         withMapping:[WUGenre          mapping]];
    RKRelationshipMapping *imageMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"images"         toKeyPath:@"image"          withMapping:[WUImage          mapping]];
    RKRelationshipMapping *scoreMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"scores"         toKeyPath:@"scores"         withMapping:[WUScore          mapping]];
    RKRelationshipMapping *seasonMapping         = [RKRelationshipMapping relationshipMappingFromKeyPath:@"seasons"        toKeyPath:@"seasons"        withMapping:[WUSeason         mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"display_name": @"displayName"}];
    [mapping addAttributeMappingsFromArray:@[@"title", @"highlight"]];
    [mapping addPropertyMappingsFromArray:@[classificationMapping, genreMapping, imageMapping, scoreMapping, seasonMapping]];
    return mapping;
}

@end

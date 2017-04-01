//
//  WUMediaInfo+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUMediaInfo+MappedEntity.h"
#import "WULanguage+MappedEntity.h"
#import "WUVideoQuality+MappedEntity.h"
#import "WUAudioQuality+MappedEntity.h"
#import "WUDRMType+MappedEntity.h"


@implementation WUMediaInfo (MappedEntity)

+ (RKMapping *)mapping {
    RKRelationshipMapping *audioLanguageMapping    = [RKRelationshipMapping relationshipMappingFromKeyPath:@"audio_languages"     toKeyPath:@"audioLanguages"    withMapping:[WULanguage     mapping]];
    RKRelationshipMapping *subtitleLanguageMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"subtitle_languages"  toKeyPath:@"subtitleLanguages" withMapping:[WULanguage     mapping]];
    RKRelationshipMapping *videoQualityMapping     = [RKRelationshipMapping relationshipMappingFromKeyPath:@"video_qualities"     toKeyPath:@"videoQualities"    withMapping:[WUVideoQuality mapping]];
    RKRelationshipMapping *audioQualityMapping     = [RKRelationshipMapping relationshipMappingFromKeyPath:@"audio_qualities"     toKeyPath:@"audioQualities"    withMapping:[WUAudioQuality mapping]];
    RKRelationshipMapping *drmTypeMapping          = [RKRelationshipMapping relationshipMappingFromKeyPath:@"streaming_drm_types" toKeyPath:@"streamingDRMTypes" withMapping:[WUDRMType      mapping]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addPropertyMappingsFromArray:@[audioLanguageMapping, subtitleLanguageMapping, videoQualityMapping, audioQualityMapping, drmTypeMapping]];
    return mapping;
}

@end

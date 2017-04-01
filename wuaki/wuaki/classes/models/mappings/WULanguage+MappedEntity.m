//
//  WULanguage+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WULanguage+MappedEntity.h"

@implementation WULanguage (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"abbr": @"abbreviation"}];
    [mapping addAttributeMappingsFromArray:@[@"name"]];
    return mapping;
}

@end

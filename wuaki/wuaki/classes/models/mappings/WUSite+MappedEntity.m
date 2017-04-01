//
//  WUSite+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUSite+MappedEntity.h"


@implementation WUSite (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier"}];
    [mapping addAttributeMappingsFromArray:@[@"name", @"image"]];
    return mapping;
}

@end

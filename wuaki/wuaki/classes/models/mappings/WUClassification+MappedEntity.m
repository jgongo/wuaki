//
//  WUClassification+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUClassification+MappedEntity.h"


@implementation WUClassification (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier", @"description": @"classificationDescription"}];
    [mapping addAttributeMappingsFromArray:@[@"name", @"age", @"adult"]];
    return mapping;
}

@end

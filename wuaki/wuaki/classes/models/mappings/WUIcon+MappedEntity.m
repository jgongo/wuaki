//
//  WUIcon+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUIcon+MappedEntity.h"


@implementation WUIcon (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"icon": @"url"}];
    return mapping;
}

@end

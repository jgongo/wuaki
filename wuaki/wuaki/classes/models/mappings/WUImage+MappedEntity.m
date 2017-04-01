//
//  WUImage+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUImage+MappedEntity.h"


@implementation WUImage (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromArray:@[@"artwork", @"snapshot"]];
    return mapping;
}

@end

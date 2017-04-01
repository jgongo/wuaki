//
//  WUStreamInfo+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUStreamInfo+MappedEntity.h"


@implementation WUStreamInfo (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromArray:@[@"player", @"url", @"cdn", @"wrid"]];
    return mapping;
}

@end

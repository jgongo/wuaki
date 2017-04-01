//
//  WUPeople+MappedEntity.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUPeople+MappedEntity.h"


@implementation WUPeople (MappedEntity)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"identifier"}];
    [mapping addAttributeMappingsFromArray:@[@"name", @"photo"]];
    return mapping;
}

@end

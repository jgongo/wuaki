//
//  INMappedEntitiesCatalog.m
//  wuaki
//
//  Created by José González Gómez on 31/3/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "INMappedEntitiesCatalog.h"
#import "INMappedEntity.h"


@implementation INMappedEntitiesCatalog

- (RKMapping *)mappingForClass:(Class)class {
    if ([class conformsToProtocol:@protocol(INMappedEntity)]) {
        return [class mapping];
    } else {
        return nil;
    }
}

- (RKObjectMapping *)inverseMappingForClass:(Class)class {
    RKMapping *mapping = [self mappingForClass:class];
    return [mapping isKindOfClass:[RKObjectMapping class]] ? [(RKObjectMapping *)mapping inverseMapping] : nil;
}

@end

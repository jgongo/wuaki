//
//  RKObjectManager+WuakiConfiguration.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "RKObjectManager+WuakiConfiguration.h"
#import "INMappingCatalog.h"
#import <objc/runtime.h>


@implementation RKObjectManager (WuakiConfiguration)

- (id<INMappingCatalog>)mappingCatalog {
    return objc_getAssociatedObject(self, @selector(mappingCatalog));
}

- (void)setMappingCatalog:(id<INMappingCatalog>)mappingCatalog {
    objc_setAssociatedObject(self, @selector(mappingCatalog), mappingCatalog, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configure {
}

@end

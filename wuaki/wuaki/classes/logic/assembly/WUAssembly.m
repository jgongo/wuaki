//
//  WUAssembly.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUAssembly.h"
#import "INMappedEntitiesCatalog.h"
#import "RKObjectManager+WuakiConfiguration.h"
#import "WUService.h"


@implementation WUAssembly

- (id)mappingCatalog {
    return [TyphoonDefinition withClass:[INMappedEntitiesCatalog class]];
}

- (id)objectManager {
    return [TyphoonDefinition withClass:[RKObjectManager class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(managerWithBaseURL:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(@"service.url")];
        }];
        [definition injectProperty:@selector(mappingCatalog)];
        [definition performAfterInjections: @selector(configure)];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (id)service {
    return [TyphoonDefinition withClass:[WUService class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(objectManager) with:[self objectManager]];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

@end

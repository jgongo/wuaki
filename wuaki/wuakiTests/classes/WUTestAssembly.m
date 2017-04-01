//
//  WUTestAssembly.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUTestAssembly.h"
#import "WUAssembly.h"
#import "INRestKitHelper.h"


@implementation WUTestAssembly

- (id)reskitHelper {
    return [TyphoonDefinition withClass:[INRestKitHelper class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(mappingCatalog) with:self.wuakiAssembly.mappingCatalog];
    }];
}

@end

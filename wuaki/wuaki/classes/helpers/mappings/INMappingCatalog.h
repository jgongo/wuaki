//
//  GGMappingCatalog.h
//  wuaki
//
//  Created by José González Gómez on 31/3/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@protocol INMappingCatalog <NSObject>
- (RKMapping *)mappingForClass:(Class)class;
- (RKObjectMapping *)inverseMappingForClass:(Class)class;
@end

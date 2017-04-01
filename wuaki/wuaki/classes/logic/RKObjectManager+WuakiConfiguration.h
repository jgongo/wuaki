//
//  RKObjectManager+WuakiConfiguration.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <RestKit/RestKit.h>


@protocol INMappingCatalog;


@interface RKObjectManager (WuakiConfiguration)
@property (nonatomic, strong) id<INMappingCatalog> mappingCatalog;
- (void)configure;
@end

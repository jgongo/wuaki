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

#import "WUFrontPage.h"
#import "WUMovie.h"
#import "WUTVShow.h"
#import "WUError.h"


static NSString *const PATH_FRONT_PAGE = @"gardens/portada";
static NSString *const PATH_MOVIE = @"movies/:identifier";
static NSString *const PATH_TV_SHOW = @"tv_shows/:identifier";


@implementation RKObjectManager (WuakiConfiguration)

- (id<INMappingCatalog>)mappingCatalog {
    return objc_getAssociatedObject(self, @selector(mappingCatalog));
}

- (void)setMappingCatalog:(id<INMappingCatalog>)mappingCatalog {
    objc_setAssociatedObject(self, @selector(mappingCatalog), mappingCatalog, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configure {
    self.requestSerializationMIMEType = @"application/json";
    
    // Errors
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUError class]] method:RKRequestMethodGET    pathPattern:nil keyPath:@"errors" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)]];
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUError class]] method:RKRequestMethodPOST   pathPattern:nil keyPath:@"errors" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)]];
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUError class]] method:RKRequestMethodPUT    pathPattern:nil keyPath:@"errors" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)]];
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUError class]] method:RKRequestMethodDELETE pathPattern:nil keyPath:@"errors" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)]];
    
    // Front page
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUFrontPage class]] method:RKRequestMethodGET pathPattern:PATH_FRONT_PAGE keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [self.router.routeSet addRoute:[RKRoute routeWithClass:[WUFrontPage class] pathPattern:PATH_FRONT_PAGE method:RKRequestMethodGET]];
    
    // Movie
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUMovie class]] method:RKRequestMethodGET pathPattern:PATH_MOVIE keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [self.router.routeSet addRoute:[RKRoute routeWithClass:[WUMovie class] pathPattern:PATH_MOVIE method:RKRequestMethodGET]];
    
    // TV show
    [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self.mappingCatalog mappingForClass:[WUTVShow class]] method:RKRequestMethodGET pathPattern:PATH_TV_SHOW keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [self.router.routeSet addRoute:[RKRoute routeWithClass:[WUTVShow class] pathPattern:PATH_TV_SHOW method:RKRequestMethodGET]];
}

@end

//
//  INRestKitHelper.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol INMappingCatalog;
@class RKMappingTest;


@interface INRestKitHelper : NSObject
@property (nonatomic, strong) id<INMappingCatalog> mappingCatalog;

+ (instancetype)helperWithCatalog:(id<INMappingCatalog>)mappingCatalog;

- (instancetype)initWithCatalog:(id<INMappingCatalog>)mappingCatalog;
- (RKMappingTest *)setupMappingTestForClass:(Class)class withFixture:(NSString *)fixture;
- (RKMappingTest *)setupInverseMappingTestForClass:(Class)class withObject:(id)object;
- (RKMappingTest *)setupInverseMappingTestForObject:(id)object;
- (void)tearDown;
@end

//
//  WUFrontPageMappingSpec.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import <Typhoon/Typhoon.h>
#import "WUAssembly.h"
#import "WUTestAssembly.h"

#import <RestKit/Testing.h>
#import "INRestKitHelper.h"

#import "WUFrontPage.h"
#import "WUList.h"
#import "WUMovie.h"
#import "WUTVShow.h"


SPEC_BEGIN(WUFrontPageMappingSpec)

describe(@"WUFrontPage mapping", ^{
    __block INRestKitHelper *restkitHelper;
    __block RKMappingTest *mappingTest;
    
    beforeAll(^{
        [RKTestFixture setFixtureBundle:[NSBundle bundleForClass:[self class]]];
        TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"], [WUTestAssembly assembly]]];
        restkitHelper = [factory componentForType:[INRestKitHelper class]];
    });
    
    afterEach(^{
        mappingTest = nil;
        [restkitHelper tearDown];
    });
    
    context(@"when parsing a valid front page object", ^{
        __block WUFrontPage *parsedFrontPage;
        
        beforeEach(^{
            mappingTest = [restkitHelper setupMappingTestForClass:[WUFrontPage class] withFixture:@"frontPage.json"];
            [mappingTest performMapping];
            parsedFrontPage = mappingTest.destinationObject;
        });
        
        specify(^{ [[parsedFrontPage.identifier should] equal:@"portada"]; });
        specify(^{ [[parsedFrontPage.name       should] equal:@"Portada"]; });
        
        specify(^{ [[theValue(parsedFrontPage.lists.count) should] equal:theValue(5)]; });
        context(@"with first list", ^{
            __block WUList *list;
            beforeEach(^{ list = parsedFrontPage.lists[0]; });
            specify(^{ [[list.identifier            should] equal:@"wuaki-estrenos"]; });
            specify(^{ [[list.name                  should] equal:@"Wuaki estrenos"]; });
            specify(^{ [[list.shortName             should] equal:@"Wuaki estrenos"]; });
            specify(^{ [[theValue(list.contentType) should] equal:theValue(WUContentTypeMovies)]; });
            
            specify(^{ [[list.content should] haveCountOf:28]; });
            context(@"with first content", ^{
                __block WUContent *content;
                beforeEach(^{ content = list.content[0]; });
                specify(^{ [[content            should] beKindOfClass:[WUMovie class]]; });
                specify(^{ [[content.identifier should] equal:@"la-luz-de-mis-ojos"]; });
                // We don't check anything else, should properly map according to other tests
            });
        });
        context(@"with fourth list", ^{
            __block WUList *list;
            beforeEach(^{ list = parsedFrontPage.lists[3]; });
            specify(^{ [[list.identifier            should] equal:@"todas-las-series-en-selection"]; });
            specify(^{ [[list.name                  should] equal:@"Todas las series en SELECTION"]; });
            specify(^{ [[list.shortName             should] equal:@"Todas las Series"]; });
            specify(^{ [[theValue(list.contentType) should] equal:theValue(WUContentTypeTVShows)]; });
            
            specify(^{ [[list.content should] haveCountOf:17]; });
            context(@"with first content", ^{
                __block WUContent *content;
                beforeEach(^{ content = list.content[0]; });
                specify(^{ [[content            should] beKindOfClass:[WUTVShow class]]; });
                specify(^{ [[content.identifier should] equal:@"wolf-hall"]; });
                // We don't check anything else, should properly map according to other tests
            });
        });
    });
});

SPEC_END

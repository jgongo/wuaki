//
//  WUTVShowMappingSpec.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import <Typhoon/Typhoon.h>
#import "WUAssembly.h"
#import "WUTestAssembly.h"

#import <RestKit/Testing.h>
#import "INRestKitHelper.h"

#import "WUTVShow.h"
#import "WUClassification.h"
#import "WUGenre.h"
#import "WUIcon.h"
#import "WUImage.h"
#import "WUScore.h"
#import "WUSite.h"
#import "WUSeason.h"


SPEC_BEGIN(WUTVShowMappingSpec)

describe(@"WUTVShow mapping", ^{
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
    
    context(@"when parsing a valid TV show object", ^{
        __block WUTVShow *parsedTVShow;
        
        beforeEach(^{
            mappingTest = [restkitHelper setupMappingTestForClass:[WUTVShow class] withFixture:@"tvShow.json"];
            [mappingTest performMapping];
            parsedTVShow = mappingTest.destinationObject;
        });
        
        specify(^{ [[parsedTVShow.identifier should] equal:@"wolf-hall"]; });
        specify(^{ [[parsedTVShow.title      should] equal:@"Wolf Hall"]; });
        specify(^{ [[parsedTVShow.highlight  should] equal:@"ESTRENO EXCLUSIVO EN ESPAÑA"]; });
        
        specify(^{ [[parsedTVShow.classification should] beNonNil]; });
        specify(^{ [[parsedTVShow.classification.identifier      should] equal:@"7"]; });
        specify(^{ [[parsedTVShow.classification.name            should] equal:@"12"]; });
        specify(^{ [[theValue(parsedTVShow.classification.age)   should] equal:theValue(12)]; });
        specify(^{ [[theValue(parsedTVShow.classification.adult) should] equal:theValue(NO)]; });
        specify(^{ [[parsedTVShow.classification.classificationDescription should] equal:@"Mostrar sólo los contenidos autorizados para los niños de hasta 12 años"]; });
        
        specify(^{ [[theValue(parsedTVShow.genres.count) should] equal:theValue(2)]; });
        context(@"with first genre", ^{
            __block WUGenre *genre;
            beforeEach(^{ genre = parsedTVShow.genres[0]; });
            specify(^{ [[genre.identifier       should] equal:@"drama"]; });
            specify(^{ [[genre.name             should] equal:@"Drama"]; });
            specify(^{ [[theValue(genre.adult)  should] equal:theValue(NO)]; });
            specify(^{ [[theValue(genre.erotic) should] equal:theValue(NO)]; });
            
            specify(^{ [[genre.icon should] beNonNil]; });
            specify(^{ [[genre.icon.url should] equal:[NSURL URLWithString:@"https://images-2.wuaki.tv/system/brandable_photos/6364/original/1461244827-1461244827.png"]]; });
        });
        context(@"with second genre", ^{
            __block WUGenre *genre;
            beforeEach(^{ genre = parsedTVShow.genres[1]; });
            specify(^{ [[genre.identifier       should] equal:@"thriller"]; });
            specify(^{ [[genre.name             should] equal:@"Thriller"]; });
            specify(^{ [[theValue(genre.adult)  should] equal:theValue(NO)]; });
            specify(^{ [[theValue(genre.erotic) should] equal:theValue(NO)]; });
            
            specify(^{ [[genre.icon should] beNonNil]; });
            specify(^{ [[genre.icon.url should] equal:[NSURL URLWithString:@"https://images-0.wuaki.tv/system/brandable_photos/6372/original/1461246595-1461246595.png"]]; });
        });
        
        specify(^{ [[parsedTVShow.image should] beNonNil]; });
        specify(^{ [[parsedTVShow.image.artwork  should] equal:[NSURL URLWithString:@"https://images-3.wuaki.tv/system/artworks/2183/master/wolf-hall-1483532948.jpeg"]]; });
        specify(^{ [[parsedTVShow.image.snapshot should] beNil]; });
        
        specify(^{ [[theValue(parsedTVShow.scores.count) should] equal:theValue(1)]; });
        context(@"with first score", ^{
            __block WUScore *score;
            beforeEach(^{ score = parsedTVShow.scores[0]; });
            specify(^{ [[score.identifier      should] equal:@"210935"]; });
            specify(^{ [[theValue(score.score) should] equal:theValue(7.8)]; });
            specify(^{ [[score.url             should] equal:[NSURL URLWithString:@"https://www.themoviedb.org/tv/61697"]]; });
            
            specify(^{ [[score.site should] beNonNil]; });
            specify(^{ [[score.site.identifier should] equal:@"40"]; });
            specify(^{ [[score.site.name       should] equal:@"The Movie Database"]; });
            specify(^{ [[score.site.image      should] equal:[NSURL URLWithString:@"https://images-1.wuaki.tv/system/images/40/original/the-movie-database-1488534910.png"]]; });
        });
        
        specify(^{ [[theValue(parsedTVShow.seasons.count) should] equal:theValue(1)]; });
        context(@"with first season", ^{
            __block WUSeason *season;
            beforeEach(^{ season = parsedTVShow.seasons[0]; });
            specify(^{ [[season.identifier     should] equal:@"wolf-hall-1"]; });
            specify(^{ [[season.title          should] equal:@"Temporada 1"]; });
            specify(^{ [[season.displayName    should] equal:@"Wolf Hall - Season 1"]; });
            specify(^{ [[theValue(season.year) should] equal:theValue(2015)]; });
            specify(^{ [[season.label          should] equal:@"Selection"]; });
            specify(^{ [[season.highlight      should] equal:@"ESTRENO EXCLUSIVO EN ESPAÑA"]; });
            
            specify(^{ [[season.image should] beNonNil]; });
            specify(^{ [[season.image.artwork  should] equal:[NSURL URLWithString:@"https://images-2.wuaki.tv/system/artworks/4141/master/wolf-hall-season-1-1483533143.jpeg"]]; });
            specify(^{ [[season.image.snapshot should] equal:[NSURL URLWithString:@"https://images-3.wuaki.tv/system/shots/73265/original/temporada-1-1485872242.jpeg"]]; });
        });
    });
});

SPEC_END

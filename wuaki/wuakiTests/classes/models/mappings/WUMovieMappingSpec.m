//
//  WUMovieMappingSpec.m
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

#import "WUMovie.h"
#import "WUClassification.h"
#import "WUGenre.h"
#import "WUIcon.h"
#import "WUImage.h"
#import "WUPeople.h"
#import "WUMedia.h"
#import "WUMediaInfo.h"
#import "WULanguage.h"
#import "WUVideoQuality.h"
#import "WUAudioQuality.h"
#import "WUDRMType.h"


SPEC_BEGIN(WUMovieMappingSpec)

describe(@"WUMovie mapping", ^{
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
    
    context(@"when parsing a valid movie object", ^{
        __block WUMovie *parsedMovie;
        
        beforeEach(^{
            mappingTest = [restkitHelper setupMappingTestForClass:[WUMovie class] withFixture:@"movie.json"];
            [mappingTest performMapping];
            parsedMovie = mappingTest.destinationObject;
        });
        
        specify(^{ [[parsedMovie.identifier     should] equal:@"la-luz-de-mis-ojos"]; });
        specify(^{ [[parsedMovie.title          should] equal:@"La luz de mis ojos"]; });
        specify(^{ [[parsedMovie.originalTitle  should] equal:@"Apple of my eye"]; });
        specify(^{ [[parsedMovie.highlight      should] beNil]; });
        specify(^{ [[theValue(parsedMovie.year) should] equal:theValue(2017)]; });
        specify(^{ [[parsedMovie.shortPlot      should] equal:@"Cuenta la historia de Bailey, una joven a la que le apasiona la hípica, que sufre un accidente que la deja fuera de sus sueños. Sus padres tratarán de ayudarle a recuperarse con la ayuda de los animales."]; });
        specify(^{ [[parsedMovie.plot           should] equal:@"Cuenta la historia de Bailey, una joven a la que le apasiona la hípica, que sufre un accidente que la deja fuera de sus sueños. Sus padres tratarán de ayudarle a recuperarse con la ayuda de los animales."]; });
        
        specify(^{ [[theValue(parsedMovie.durationInMinutes) should] equal:theValue(84)]; });
        specify(^{ [[theValue(parsedMovie.durationInSeconds) should] equal:theValue(5065)]; });
        
        specify(^{ [[parsedMovie.image should] beNonNil]; });
        specify(^{ [[parsedMovie.image.artwork  should] equal:[NSURL URLWithString:@"https://images-3.wuaki.tv/system/artworks/47664/master/la-luz-de-mis-ojos-1483954870.jpeg"]]; });
        specify(^{ [[parsedMovie.image.snapshot should] equal:[NSURL URLWithString:@"https://images-0.wuaki.tv/system/shots/73331/original/apple-of-my-eye-1483954853.jpeg"]]; });
        
        specify(^{ [[parsedMovie.classification should] beNonNil]; });
        specify(^{ [[parsedMovie.classification.identifier      should] equal:@"1"]; });
        specify(^{ [[parsedMovie.classification.name            should] equal:@"T"]; });
        specify(^{ [[theValue(parsedMovie.classification.age)   should] equal:theValue(0)]; });
        specify(^{ [[theValue(parsedMovie.classification.adult) should] equal:theValue(NO)]; });
        specify(^{ [[parsedMovie.classification.classificationDescription should] equal:@"Mostrar sólo contenidos autorizados para todos los públicos"]; });
        
        specify(^{ [[theValue(parsedMovie.genres.count) should] equal:theValue(2)]; });
        context(@"with first genre", ^{
            __block WUGenre *genre;
            beforeEach(^{ genre = parsedMovie.genres[0]; });
            specify(^{ [[genre.identifier       should] equal:@"cine-familiar"]; });
            specify(^{ [[genre.name             should] equal:@"Cine familiar"]; });
            specify(^{ [[theValue(genre.adult)  should] equal:theValue(NO)]; });
            specify(^{ [[theValue(genre.erotic) should] equal:theValue(NO)]; });
            
            specify(^{ [[genre.icon should] beNonNil]; });
            specify(^{ [[genre.icon.url should] equal:[NSURL URLWithString:@"https://images-2.wuaki.tv/system/brandable_photos/6357/original/1461243437-1461243437.png"]]; });
        });
        context(@"with second genre", ^{
            __block WUGenre *genre;
            beforeEach(^{ genre = parsedMovie.genres[1]; });
            specify(^{ [[genre.identifier       should] equal:@"drama"]; });
            specify(^{ [[genre.name             should] equal:@"Drama"]; });
            specify(^{ [[theValue(genre.adult)  should] equal:theValue(NO)]; });
            specify(^{ [[theValue(genre.erotic) should] equal:theValue(NO)]; });
            
            specify(^{ [[genre.icon should] beNonNil]; });
            specify(^{ [[genre.icon.url should] equal:[NSURL URLWithString:@"https://images-2.wuaki.tv/system/brandable_photos/6364/original/1461244827-1461244827.png"]]; });
        });
        
        specify(^{ [[parsedMovie.scores should] beEmpty]; });
        
        specify(^{ [[theValue(parsedMovie.directors.count) should] equal:theValue(1)]; });
        context(@"with first director", ^{
            __block WUPeople *director;
            beforeEach(^{ director = parsedMovie.directors[0]; });
            specify(^{ [[director.identifier should] equal:@"castille-landon"]; });
            specify(^{ [[director.name       should] equal:@"Castille Landon"]; });
            specify(^{ [[director.photo      should] beNil]; });
        });
        
        specify(^{ [[theValue(parsedMovie.actors.count) should] equal:theValue(6)]; });
        context(@"with first actor", ^{
            __block WUPeople *actor;
            beforeEach(^{ actor = parsedMovie.actors[0]; });
            specify(^{ [[actor.identifier should] equal:@"amy-smart"]; });
            specify(^{ [[actor.name       should] equal:@"Amy Smart"]; });
            specify(^{ [[actor.photo      should] equal:[NSURL URLWithString:@"https://images-3.wuaki.tv/system/photos/1937/original/amy-smart-1464874815.jpeg"]]; });
        });
        context(@"with second actor", ^{
            __block WUPeople *actor;
            beforeEach(^{ actor = parsedMovie.actors[1]; });
            specify(^{ [[actor.identifier should] equal:@"burt-reynolds"]; });
            specify(^{ [[actor.name       should] equal:@"Burt Reynolds"]; });
            specify(^{ [[actor.photo      should] equal:[NSURL URLWithString:@"https://images-1.wuaki.tv/system/photos/800/original/burt-reynolds-1464866599.jpeg"]]; });
        });
        context(@"with sixth actor", ^{
            __block WUPeople *actor;
            beforeEach(^{ actor = parsedMovie.actors[5]; });
            specify(^{ [[actor.identifier should] equal:@"charlie-barnett"]; });
            specify(^{ [[actor.name       should] equal:@"Charlie Barnett"]; });
            specify(^{ [[actor.photo      should] equal:[NSURL URLWithString:@"https://images-3.wuaki.tv/system/photos/136926/original/charlie-barnett-1465294765.jpeg"]]; });
        });
        
        specify(^{ [[theValue(parsedMovie.media.trailers.count) should] equal:theValue(1)]; });
        context(@"with first trailer", ^{
            __block WUMediaInfo *mediaInfo;
            beforeEach(^{ mediaInfo = parsedMovie.media.trailers[0]; });
            
            specify(^{ [[theValue(mediaInfo.audioLanguages.count) should] equal:theValue(1)]; });
            context(@"with first audio language", ^{
                __block WULanguage *language;
                beforeEach(^{ language = mediaInfo.audioLanguages[0]; });
                specify(^{ [[language.identifier   should] equal:@"SPA"]; });
                specify(^{ [[language.name         should] equal:@"Español"]; });
                specify(^{ [[language.abbreviation should] equal:@"SPA"]; });
            });
            
            specify(^{ [[theValue(mediaInfo.subtitleLanguages.count) should] equal:theValue(1)]; });
            context(@"with first subtitle language", ^{
                __block WULanguage *language;
                beforeEach(^{ language = mediaInfo.subtitleLanguages[0]; });
                specify(^{ [[language.identifier   should] equal:@"MIS"]; });
                specify(^{ [[language.name         should] equal:@"Sin subtítulos"]; });
                specify(^{ [[language.abbreviation should] equal:@"MIS"]; });
            });
            
            specify(^{ [[theValue(mediaInfo.videoQualities.count) should] equal:theValue(1)]; });
            context(@"with first video quality", ^{
                __block WUVideoQuality *quality;
                beforeEach(^{ quality = mediaInfo.videoQualities[0]; });
                specify(^{ [[quality.identifier   should] equal:@"SD"]; });
                specify(^{ [[quality.name         should] equal:@"SD"]; });
                specify(^{ [[quality.abbreviation should] equal:@"SD"]; });
            });
            
            specify(^{ [[theValue(mediaInfo.audioQualities.count) should] equal:theValue(1)]; });
            context(@"with first audio quality", ^{
                __block WUAudioQuality *quality;
                beforeEach(^{ quality = mediaInfo.audioQualities[0]; });
                specify(^{ [[quality.identifier   should] equal:@"2.0"]; });
                specify(^{ [[quality.name         should] equal:@"2.0 (Stereo)"]; });
                specify(^{ [[quality.abbreviation should] equal:@"2.0"]; });
            });
            
            specify(^{ [[theValue(mediaInfo.streamingDRMTypes.count) should] equal:theValue(1)]; });
            specify(^{ [[mediaInfo.streamingDRMTypes[0].identifier should] equal:@"PD-NONE"]; });
        });
    });
});

SPEC_END

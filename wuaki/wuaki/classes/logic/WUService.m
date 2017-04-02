//
//  WUService.m
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUService.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import "WULogLevel.h"

#import <RestKit/RestKit.h>
#import "RKObjectManager+WuakiConfiguration.h"
#import "WUFrontPage.h"
#import "WUMovie.h"
#import "WUMedia.h"
#import "WUMediaInfo.h"
#import "WULanguage.h"
#import "WUVideoQuality.h"
#import "WUAudioQuality.h"
#import "WUStreaming.h"


NSString *const WUWuakiErrorDomain = @"WUWuakiErrorDomain";


@implementation WUService

#pragma mark Error helper methods

- (NSError *)wuakiErrorWithOperation:(RKObjectRequestOperation *)operation error:(NSError *)error  {
    if ([error.domain isEqualToString:RKErrorDomain] && error.userInfo[RKObjectMapperErrorObjectsKey]) {
        // API error: RestKit error with incoming API error information
        NSArray *errors = error.userInfo[RKObjectMapperErrorObjectsKey];
        NSDictionary *userInfo = @{NSURLErrorKey: operation.HTTPRequestOperation.request.URL, NSUnderlyingErrorKey: errors};
        return [NSError errorWithDomain:WUWuakiErrorDomain code:operation.HTTPRequestOperation.response.statusCode userInfo:userInfo];
    } else {
        return error; // Unknown error (probably network related), return error as is
    }
}

- (void)handleServerError:(NSError *)error performingOperation:(RKObjectRequestOperation *)operation withErrorBlock:(ErrorBlock)onError {
    NSError *translatedError = [self wuakiErrorWithOperation:operation error:error];
    DDLogWarn(@"Error while performing operation: %@", translatedError);
    onError(translatedError);
}

#pragma mark Information retrieval methods

- (void)getFrontPageOnSuccess:(FrontPageSuccessBlock)onSuccess onError:(ErrorBlock)onError {
    NSDictionary *parameters = @{@"classification_id": @6, @"device_identifier": @"web", @"user_status": @"visitor"};
    typeof(self) __weak wself = self;
    [self.objectManager getObject:[WUFrontPage new] path:nil parameters:parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess([mappingResult firstObject]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [wself handleServerError:error performingOperation:operation withErrorBlock:onError];
    }];
}

- (void)getMovieDetails:(WUMovie *)movie onSuccess:(MovieSuccessBlock)onSuccess onError:(ErrorBlock)onError {
    NSDictionary *parameters = @{@"classification_id": @6, @"device_identifier": @"web", @"user_status": @"visitor"};
    typeof(self) __weak wself = self;
    [self.objectManager getObject:movie path:nil parameters:parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess([mappingResult firstObject]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [wself handleServerError:error performingOperation:operation withErrorBlock:onError];
    }];
}

- (void)getTVShowDetails:(WUTVShow *)tvShow onSuccess:(TVShowSuccessBlock)onSuccess onError:(ErrorBlock)onError {
    NSDictionary *parameters = @{@"classification_id": @6, @"device_identifier": @"web", @"user_status": @"visitor"};
    typeof(self) __weak wself = self;
    [self.objectManager getObject:tvShow path:nil parameters:parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess([mappingResult firstObject]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [wself handleServerError:error performingOperation:operation withErrorBlock:onError];
    }];
}

- (void)getDefaultTrailer:(WUMovie *)movie onSuccess:(StreamingSuccessBlock)onSuccess onError:(ErrorBlock)onError {
    NSDictionary *parameters = @{
                                 @"classification_id": @6,
                                 @"device_identifier": @"web",
                                 @"device_serial": @"AABBCCDDCC112233",
                                 @"player": @"web:PD-NONE",
                                 @"video_type": @"trailer",
                                 @"content_id": movie.identifier,
                                 @"content_type": @"movies",
                                 @"audio_language": movie.media.trailers[0].audioLanguages[0].identifier,
                                 @"subtitle_language": movie.media.trailers[0].subtitleLanguages[0].identifier,
                                 @"video_quality": movie.media.trailers[0].videoQualities[0].identifier,
                                 @"audio_quality": movie.media.trailers[0].audioQualities[0].identifier
                                 };
    // We build the path manually becasuse RestKit puts both object and parameters in request body instead of URL query
    NSString *pathPattern = [self.objectManager.router.routeSet routeForName:ROUTE_STREAMING].pathPattern;
    NSString *path = [NSString stringWithFormat:@"%@?%@", pathPattern, AFRKQueryStringFromParametersWithEncoding(parameters, self.objectManager.HTTPClient.stringEncoding)];
    
    typeof(self) __weak wself = self;
    [self.objectManager postObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess([mappingResult firstObject]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [wself handleServerError:error performingOperation:operation withErrorBlock:onError];
    }];
}

@end

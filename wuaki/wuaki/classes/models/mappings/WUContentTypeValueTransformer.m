//
//  WUContentTypeValueTransformer.m
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUContentTypeValueTransformer.h"
#import "WUList.h"


@implementation WUContentTypeValueTransformer

- (BOOL)validateTransformationFromClass:(Class)inputValueClass toClass:(Class)outputValueClass {
    return [inputValueClass isSubclassOfClass:[NSString class]] && [outputValueClass isSubclassOfClass:[NSNumber class]];
}

- (BOOL)transformValue:(id)inputValue toValue:(id *)outputValue ofClass:(Class)outputValueClass error:(NSError **)error {
    RKValueTransformerTestInputValueIsKindOfClass(inputValue, [NSString class], error);
    RKValueTransformerTestOutputValueClassIsSubclassOfClass(outputValueClass, [NSNumber class], error);
    
    if ([inputValue isEqualToString:@"Movie"]) {
        *outputValue = @(WUContentTypeMovies);
    } else if ([inputValue isEqualToString:@"TvShow"]) {
        *outputValue = @(WUContentTypeTVShows);
    } else {
        RKValueTransformerTestTransformation(false, error, @"Unknown input type value: %@", inputValue);
    }
    return YES;
}

@end

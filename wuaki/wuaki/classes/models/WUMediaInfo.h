//
//  WUMediaInfo.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WULanguage;
@class WUVideoQuality;
@class WUAudioQuality;
@class WUDRMType;


@interface WUMediaInfo : NSObject
@property (nonatomic, copy  ) NSArray<WULanguage *>     *audioLanguages;
@property (nonatomic, copy  ) NSArray<WULanguage *>     *subtitleLanguages;
@property (nonatomic, copy  ) NSArray<WUVideoQuality *> *videoQualities;
@property (nonatomic, copy  ) NSArray<WUAudioQuality *> *audioQualities;
@property (nonatomic, copy  ) NSArray<WUDRMType *>      *streamingDRMTypes;
@end

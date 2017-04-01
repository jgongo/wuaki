//
//  WUMediaInfo.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WUMediaInfo : NSObject
@property (nonatomic, copy  ) NSArray *audioLanguages;
@property (nonatomic, copy  ) NSArray *subtitleLanguages;
@property (nonatomic, copy  ) NSArray *videoQualities;
@property (nonatomic, copy  ) NSArray *audioQualities;
@property (nonatomic, copy  ) NSArray *streamingDRMTypes;
@end

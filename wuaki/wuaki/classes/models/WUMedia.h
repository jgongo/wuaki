//
//  WUMedia.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WUMediaInfo;


@interface WUMedia : NSObject
@property (nonatomic, copy  ) NSArray<WUMediaInfo *> *trailers;
@property (nonatomic, copy  ) NSArray<WUMediaInfo *> *previews;
@property (nonatomic, copy  ) NSArray<WUMediaInfo *> *streams;
@property (nonatomic, copy  ) NSArray<WUMediaInfo *> *offlineStreams;
@end

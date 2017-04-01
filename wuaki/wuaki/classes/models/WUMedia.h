//
//  WUMedia.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WUMedia : NSObject
@property (nonatomic, copy  ) NSArray *trailers;
@property (nonatomic, copy  ) NSArray *previews;
@property (nonatomic, copy  ) NSArray *streams;
@property (nonatomic, copy  ) NSArray *offlineStreams;
@end

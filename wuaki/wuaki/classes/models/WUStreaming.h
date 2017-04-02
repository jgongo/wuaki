//
//  WUStreaming.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WUObject.h"


@class WUStreamInfo;


@interface WUStreaming : WUObject
@property (nonatomic, strong) NSArray<WUStreamInfo *> *streams;
@end

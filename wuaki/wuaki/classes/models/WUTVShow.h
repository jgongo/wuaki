//
//  WUTVShow.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUContent.h"


@class WUSeason;


@interface WUTVShow : WUContent
@property (nonatomic, copy  ) NSArray<WUSeason *> *seasons;
@end

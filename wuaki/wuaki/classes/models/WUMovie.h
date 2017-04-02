//
//  WUMovie.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUContent.h"


@class WUMedia;
@class WUPeople;


@interface WUMovie : WUContent
@property (nonatomic, copy  ) NSString  *originalTitle;
@property (nonatomic        ) NSUInteger year;
@property (nonatomic, copy  ) NSString  *shortPlot;
@property (nonatomic, copy  ) NSString  *plot;
@property (nonatomic        ) NSUInteger durationInMinutes;
@property (nonatomic        ) NSUInteger durationInSeconds;

@property (nonatomic, copy  ) NSArray<WUPeople *> *directors;
@property (nonatomic, copy  ) NSArray<WUPeople *> *actors;

@property (nonatomic, strong) WUMedia   *media;
@end

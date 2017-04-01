//
//  WUTVShow.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUObject.h"


@class WUClassification;
@class WUImage;


@interface WUTVShow : WUObject
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *highlight;
@property (nonatomic, strong) WUClassification *classification;
@property (nonatomic, copy  ) NSArray *genres;
@property (nonatomic, strong) WUImage *image;
@property (nonatomic, copy  ) NSArray *scores;
@property (nonatomic, copy  ) NSArray *seasons;
@end

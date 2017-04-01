//
//  WUScore.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUObject.h"


@class WUSite;


@interface WUScore : WUObject
@property (nonatomic        ) double  score;
@property (nonatomic, copy  ) NSURL  *url;
@property (nonatomic, strong) WUSite *site;
@end

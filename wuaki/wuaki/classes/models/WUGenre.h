//
//  WUGenre.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUObject.h"


@class WUIcon;


@interface WUGenre : WUObject
@property (nonatomic, copy  ) NSString *name;
@property (nonatomic        ) BOOL      adult;
@property (nonatomic        ) BOOL      erotic;
@property (nonatomic, strong) WUIcon   *icon;
@end

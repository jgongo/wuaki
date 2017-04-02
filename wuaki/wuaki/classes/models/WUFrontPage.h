//
//  WUFrontPage.h
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUObject.h"


@class WUList;


@interface WUFrontPage : WUObject
@property (nonatomic, copy  ) NSString          *name;
@property (nonatomic, copy  ) NSArray<WUList *> *lists;
@end

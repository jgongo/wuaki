//
//  WUSeason.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUObject.h"


@class WUImage;


@interface WUSeason : WUObject
@property (nonatomic, copy  ) NSString  *title;
@property (nonatomic, copy  ) NSString  *displayName;
@property (nonatomic        ) NSUInteger year;
@property (nonatomic, copy  ) NSString  *label;
@property (nonatomic, strong) WUImage   *image;
@property (nonatomic, copy  ) NSString  *highlight;
@end

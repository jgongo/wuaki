//
//  WUListControl.h
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WUList;
@class WUMovie;


@interface WUListControl : UIControl
@property (nonatomic, weak  ) WUMovie *lastSelectedMovie;
- (instancetype)initWithList:(WUList *)list;
@end

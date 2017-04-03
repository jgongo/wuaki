//
//  WUMovieSelectedRecognizer.h
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WUMovie;


@interface WUMovieSelectedRecognizer : UITapGestureRecognizer
@property (nonatomic, weak  ) WUMovie *movie;
@end

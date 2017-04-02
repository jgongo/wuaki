//
//  WUList.h
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUObject.h"


@class WUContent;
typedef NS_ENUM(NSInteger, WUContentType) {
    WUContentTypeMovies,
    WUContentTypeTVShows
};


@interface WUList : WUObject
@property (nonatomic, copy  ) NSString             *name;
@property (nonatomic, copy  ) NSString             *shortName;
@property (nonatomic        ) WUContentType         contentType;
@property (nonatomic, copy  ) NSArray<WUContent *> *content;
@end

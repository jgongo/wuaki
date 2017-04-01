//
//  WUStreamInfo.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WUObject.h"


@interface WUStreamInfo : NSObject
@property (nonatomic, copy) NSString *player;
@property (nonatomic, copy) NSURL    *url;
@property (nonatomic, copy) NSString *cdn;
@property (nonatomic, copy) NSString *wrid;
@end

//
//  WUService.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RKObjectManager;


@interface WUService : NSObject
@property (nonatomic, strong) RKObjectManager *objectManager;
@end
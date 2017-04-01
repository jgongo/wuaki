//
//  GGMappedEntity.h
//  wuaki
//
//  Created by José González Gómez on 31/3/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@protocol INMappedEntity <NSObject>
+ (RKMapping *)mapping;
@end

//
//  WUClassification.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WUObject.h"


@interface WUClassification : WUObject
@property (nonatomic, copy  ) NSString  *name;
@property (nonatomic        ) NSUInteger age;
@property (nonatomic        ) BOOL       adult;
@property (nonatomic, copy  ) NSString  *classificationDescription;
@end

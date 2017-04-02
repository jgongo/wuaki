//
//  WUError.h
//  wuaki
//
//  Created by José González Gómez on 2/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INMappedEntity.h"


@interface WUError : NSObject <INMappedEntity>
@property (nonatomic, copy  ) NSString *field;
@property (nonatomic, copy  ) NSString *code;
@property (nonatomic, copy  ) NSString *message;
@end

//
//  WUTestAssembly.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Typhoon/Typhoon.h>


@class WUAssembly;


@interface WUTestAssembly : TyphoonAssembly
@property (nonatomic, strong) WUAssembly *wuakiAssembly;
- (id)reskitHelper;
@end

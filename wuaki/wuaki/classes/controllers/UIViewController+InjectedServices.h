//
//  UIViewController+InjectedServices.h
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WUService;


@interface UIViewController (InjectedServices)
@property (nonatomic, strong) WUService *service;
@end

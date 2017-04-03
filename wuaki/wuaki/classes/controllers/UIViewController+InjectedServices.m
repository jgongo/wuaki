//
//  UIViewController+InjectedServices.m
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "UIViewController+InjectedServices.h"
#import <Typhoon/Typhoon.h>
#import <objc/runtime.h>
#import "WUService.h"


@implementation UIViewController (InjectedServices)

- (void)setService:(WUService *)service {
    objc_setAssociatedObject(self, @selector(service), service, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WUService *)service {
    WUService *service = objc_getAssociatedObject(self, @selector(service));
    if (!service) {
        service = [[TyphoonComponentFactory defaultFactory] componentForType:[WUService class]];
        self.service = service;
    }
    return service;
}

@end

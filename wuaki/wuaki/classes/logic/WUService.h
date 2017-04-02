//
//  WUService.h
//  wuaki
//
//  Created by José González Gómez on 1/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXTERN NSString *const WUWuakiErrorDomain;


@class RKObjectManager;
@class WUFrontPage;
@class WUStreaming;


typedef void (^FrontPageSuccessBlock)(WUFrontPage *frontPage);
typedef void (^ErrorBlock)(NSError *error);


@interface WUService : NSObject
@property (nonatomic, strong) RKObjectManager *objectManager;
- (void)getFrontPageOnSuccess:(FrontPageSuccessBlock)onSuccess onError:(ErrorBlock)onError;
@end

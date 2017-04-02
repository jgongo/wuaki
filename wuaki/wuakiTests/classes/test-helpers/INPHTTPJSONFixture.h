//
//  INHTTPJSONFixture.h
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import <Foundation/Foundation.h>


#define INPHTTPJSONFixtureInBundle(name,bundleOrNil) ({ \
  (bundleOrNil) ? [INPHTTPJSONFixture fixtureWithName:(name) bundle:(bundleOrNil)] : [INPHTTPJSONFixture fixtureWithName:(name) bundle:[NSBundle bundleForClass:self.class]]; \
})


@interface INPHTTPJSONFixture : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSBundle *bundle;
+ (instancetype)fixtureWithName:(NSString *)name bundle:(NSBundle *)bundle;
- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;
- (id)jsonObject;
@end

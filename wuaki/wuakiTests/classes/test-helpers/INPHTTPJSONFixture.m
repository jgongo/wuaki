//
//  INHTTPJSONFixture.m
//  INHTTPRequestMatchers
//
// Created by José González Gómez on 30/11/13.
// Copyright (c) 2013 OPEN input. All rights reserved.
//

#import "INPHTTPJSONFixture.h"


@implementation INPHTTPJSONFixture

+ (instancetype)fixtureWithName:(NSString *)name bundle:(NSBundle *)bundle {
    return [[self alloc] initWithName:name bundle:bundle];
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        self.name = name;
        self.bundle = bundle;
    }

    return self;
}

- (id)jsonObject {
    NSString *fixturePath = [self.bundle pathForResource:[self.name stringByDeletingPathExtension] ofType:[self.name pathExtension]];
    NSData *fixtureData = [NSData dataWithContentsOfFile:fixturePath];
    return [NSJSONSerialization JSONObjectWithData:fixtureData options:0 error:nil];
}

@end

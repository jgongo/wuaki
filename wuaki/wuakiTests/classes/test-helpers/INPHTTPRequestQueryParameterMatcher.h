//
//  INPHTTPRequestQueryParameterMatcher.h
//  biid
//
//  Created by José González Gómez on 09/06/14.
//  Copyright (c) 2014 Firmaprofesional. All rights reserved.
//

#import "INPHTTPRequestMatcher.h"


@interface INPHTTPRequestQueryParameterMatcher : INPHTTPRequestMatcher
- (void)haveQueryParameter:(NSString *)parameter withValue:(NSString *)value;
@end

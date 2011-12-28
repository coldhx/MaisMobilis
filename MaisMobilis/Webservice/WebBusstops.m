//
//  WebBusstops.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebBusstops.h"
#import "MaisMobilisWebService.h"

@implementation WebBusstops

+ (void)getAllBusstops
{
    NSString *response = [MaisMobilisWebService doGET:@"paragens" withQueryString:@""];
    NSLog(@"RESPONSE: %@", response);
}
@end

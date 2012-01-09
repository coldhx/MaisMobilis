//
//  WebVersion.m
//  MaisMobilis
//
//  Created by tom on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebVersion.h"
#import "MaisMobilisWebService.h"

@implementation WebVersion

+ (NSString *)getDataVersion
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"versao" withQueryString:@""];
    return [[jsonObjects objectAtIndex:0] objectForKey:@"versao"];
}

@end

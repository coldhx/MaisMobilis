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
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"paragens" withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void)getBusstopWithID: (NSString *) busstopID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"paragens/%@/", busstopID] withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void)getBusstopsWithLineID: (NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"paragens" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineID]];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}
@end

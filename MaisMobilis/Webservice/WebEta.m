//
//  WebEta.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebEta.h"
#import "MaisMobilisWebService.h"
#import "SBJson.h"

@implementation WebEta

+ (NSString *) getEtaForBusstopID:(NSString *)busID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"etas" withQueryString:[NSString stringWithFormat:@"?idAutocarro=%@", busID]];
    
    return [[jsonObjects objectAtIndex:0] objectForKey:@"eta"];
}

+ (NSString *) getBusStopForBusstopID:(NSString *)busID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"etas" withQueryString:[NSString stringWithFormat:@"?idAutocarro=%@", busID]];
    
    return [[jsonObjects objectAtIndex:0] objectForKey:@"idParagem"];
}

@end

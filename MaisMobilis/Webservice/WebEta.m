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

+ (NSString *) getEtaForBusID:(NSString *)busID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"etas" withQueryString:[NSString stringWithFormat:@"?idAutocarro=%@", busID]];
    
    if([[jsonObjects objectAtIndex:0] count] != 0)
        return [[jsonObjects objectAtIndex:0] objectForKey:@"eta"];
    else
        return @"0";
}

+ (NSString *) getBusStopForBusstopID:(NSString *)busID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"etas" withQueryString:[NSString stringWithFormat:@"?idAutocarro=%@", busID]];
    
    if([[jsonObjects objectAtIndex:0] count] != 0)
        return [[jsonObjects objectAtIndex:0] objectForKey:@"idParagem"];
    else
        return @"N/D";
}

+ (NSArray *) getETAsForBusstopID:(NSString *)busstopID
{    
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"etas" withQueryString:[NSString stringWithFormat:@"?idParagem=%@", busstopID]];
    
    return jsonObjects;
}

@end

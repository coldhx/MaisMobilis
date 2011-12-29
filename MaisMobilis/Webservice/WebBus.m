//
//  WebBus.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


// autocarros	        Get		           lista Bus
// autocarros	        Get	    idLinha	   lista Bus
// autocarros/{idBus}	Get		           bus

//Autocarro: idAutocarro, idLinha, idUltimaParagem, latitude, longitude, precisao, velocidadeMedia, timeStamp				


#import "WebBus.h"
#import "MaisMobilisWebService.h"

@implementation WebBus
+ (void)geAllBuses
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"autocarros" withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+(void)getBusesByLine:(NSString *)lineNumber
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"autocarros" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineNumber]];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void) getBusById:(NSString *)busID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"autocaros/%@/", busID] withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

@end

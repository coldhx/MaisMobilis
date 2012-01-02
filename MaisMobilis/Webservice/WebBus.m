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
#import "AppDelegate.h"
#import "Bus.h"
#import "SBJson.h"

@implementation WebBus

+(void) persistBus:(NSArray *)jsonObjects {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    BusStop *newBus;
    for (int i=0; i<jsonObjects.count; i++) {
        newBus = [NSEntityDescription insertNewObjectForEntityForName:@"Bus" inManagedObjectContext:context];
        newBus.busID = [[jsonObjects objectAtIndex:i] objectForKey:@"idUltimaParagem"];
        newBus.lastStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idParagem"];
        newBus.latitude = [[jsonObjects objectAtIndex:i] objectForKey:@"latitude"];
        newBus.lineID = [[jsonObjects objectAtIndex:i] objectForKey:@"idLinha"];
        newBus.longitude = [[jsonObjects objectAtIndex:i] objectForKey:@"longitude"];
        newBus.meanVelocity = [[jsonObjects objectAtIndex:i] objectForKey:@"velocidadeMedia"];
        newBus.precision = [[jsonObjects objectAtIndex:i] objectForKey:@"precisao"];
        newBus.timeStamp = [[jsonObjects objectAtIndex:i] objectForKey:@"timeStamp"];
    }
}

+ (void)geAllBuses
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"autocarros" withQueryString:@""];
    [self persistBus:jsonObjects];
}

+(void)getBusesByLine:(NSString *)lineNumber
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"autocarros" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineNumber]];
    [self persistBus:jsonObjects];
}

+ (void) getBusById:(NSString *)busID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"autocaros/%@/", busID] withQueryString:@""];
    [self persistBus:jsonObjects];
    
    /* save one we must, in case just
     NSLog(@"RESPONSE: %@", [jsonObjects description]);
     */
}

@end

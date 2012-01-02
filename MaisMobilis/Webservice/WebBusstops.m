//
//  WebBusstops.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebBusstops.h"
#import "MaisMobilisWebService.h"
#import "AppDelegate.h"
#import "BusStop.h"
#import "SBJson.h"



@implementation WebBusstops

+(void) persistBusStops:(NSArray *)jsonObjects {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    BusStop *newBusStop;
    for (int i=0; i<jsonObjects.count; i++) {
        newBusStop = [NSEntityDescription insertNewObjectForEntityForName:@"BusStop" inManagedObjectContext:context];
        newBusStop.lineID = [[jsonObjects objectAtIndex:i] objectForKey:@"idLinha"];
        newBusStop.busStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idParagem"];
        newBusStop.name = [[jsonObjects objectAtIndex:i] objectForKey:@"nome"];
        newBusStop.refPointID = [[jsonObjects objectAtIndex:i] objectForKey:@"idPontoReferencia"];
    }
}

+ (void)fetchAllBusstops
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"paragens" withQueryString:@""];
    [self persistBusStops: jsonObjects];
}

+ (void)fetchBusstopWithID: (NSString *) busstopID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"paragens/%@/", busstopID] withQueryString:@""];
    [self persistBusStops:jsonObjects];
}

+ (void)fetchBusstopsWithLineID: (NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"paragens" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineID]];
    [self persistBusStops:jsonObjects];
}


@end

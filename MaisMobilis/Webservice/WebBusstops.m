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
#import "../BusStop.h"
#import "../BusStop_Line.h"
#import "WebLines.h"
#import "SBJson.h"

@implementation WebBusstops
+ (void)persistBusStops:(NSArray *)jsonObjects {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    BusStop *newBusStop;
    BusStop_Line *newBusStop_line;
    for (int i=0; i<jsonObjects.count; i++)
    {
        newBusStop = [NSEntityDescription insertNewObjectForEntityForName:@"BusStop" inManagedObjectContext:context];
        newBusStop.busStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idParagem"];
        newBusStop.name = [[jsonObjects objectAtIndex:i] objectForKey:@"nome"];
        newBusStop.refPointID = [[jsonObjects objectAtIndex:i] objectForKey:@"idPontoReferencia"];   
        
        newBusStop_line = [NSEntityDescription insertNewObjectForEntityForName:@"BusStop_Line" inManagedObjectContext:context];
        
        //Fetch lines for bus stop
        NSArray *busStopLines = [WebLines getLinesWithBusstopID:[NSString stringWithFormat:@"%@", newBusStop.busStopID]];
        
        if(!busStopLines)
        {
            NSLog(@"Oups...");
        }
        
        for(int j=0; j<busStopLines.count; j++)
        {
            newBusStop_line = [NSEntityDescription insertNewObjectForEntityForName:@"BusStop_Line" inManagedObjectContext:context];
            newBusStop_line.busStopID = newBusStop.busStopID;
            newBusStop_line.lineID = [[busStopLines objectAtIndex:j] objectForKey:@"idLinha"];
        }
    }
}

+ (void)getAllBusstops
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"paragens" withQueryString:@""];
    [self persistBusStops:jsonObjects];
}

+ (void)getBusstopWithID: (NSString *) busstopID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"paragens/%@/", busstopID] withQueryString:@""];
    [self persistBusStops:jsonObjects];
}

+ (void)getBusstopsWithLineID: (NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"paragens" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineID]];
    [self persistBusStops:jsonObjects];
}
@end

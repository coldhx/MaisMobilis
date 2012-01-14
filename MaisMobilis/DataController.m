//
//  CoreDataController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"

@implementation DataController


+ (NSArray *) getLineIdsForBusStopID :(NSString *) busStopID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop_Line" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busStopID = %@",busStopID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error: &error] ;
   
    return results;
}

+ (NSMutableArray *) getAllBusStops 
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop"                                                                                                                               inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *busStops =  [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(busStops == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return busStops;
}

+ (NSString*) getLineNameByLineID : (NSString*) lineID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lineID = %@",lineID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error: &error] ;
    Line *linha = [results objectAtIndex:0];
    
    return linha.name;
}

+ (NSString *) getNextStopByBusID: (NSString *) busID
{
    NSString *nextStopID = [WebEta getBusStopForBusstopID: busID];
    
    if(![nextStopID isEqualToString:@"N/D"]){
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext;
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop" inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busStopID = %@",nextStopID];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error: &error] ;
        BusStop *paragem = [results objectAtIndex:0];
        
        return paragem.name;
    }
    else 
        return nextStopID;
}

+ (NSString *) getEtaByBusID : (NSString *) busID
{
    return [WebEta getEtaForBusID: busID];
}

+ (NSArray *) getEtaByBusstopID : (NSString *) busstopID
{
    return [WebEta getETAsForBusstopID:busstopID];
}

+ (NSArray *) getAllBuses
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSArray *buses = [context executeFetchRequest:request error: &error] ;
    
    if(buses == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return buses;
}

+ (NSMutableArray *) getAllLines;
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *lines = [[context executeFetchRequest:request error: &error] mutableCopy];
    
    if(lines == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return lines;
}

+ (Bus *) getBusByBusID:(NSString *) busID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busID = %@", busID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *bus = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(bus == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return [bus objectAtIndex:0];
}

+ (BusStop *) getBusStopByBusStopID: (NSString *) bsID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busStopID = %@", bsID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *busStop = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(busStop == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return [busStop objectAtIndex:0];

}

+ (NSMutableArray *) getBusStopsWithSameLineIdAs: (NSString *) bsID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop_Line" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busStopID = %@", bsID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *bsl = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(bsl == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    BusStop_Line *busstopline = [bsl objectAtIndex:0];
    
    entity = [NSEntityDescription entityForName:@"BusStop_Line" inManagedObjectContext:context];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    predicate = [NSPredicate predicateWithFormat:@"lineID = %@", [busstopline lineID]];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSArray *relations = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(relations == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[relations count]; i++) {
        [res insertObject:[self getBusStopByBusStopID:[[relations objectAtIndex:i] busStopID]] atIndex:i];
    }

    return res;   
}

+ (NSMutableArray *)getAllRoutes
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route"                                                                                                                               inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *routes =  [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(routes == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return routes;

}


+ (NSArray *) getDatabaseVersion
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Version" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSError *error = nil;
    NSArray *results = [[context executeFetchRequest:request error: &error] mutableCopy];
    
    if(results == nil)
    {
        NSLog(@"%@", error.description);
    
    }
    return results;
}

+ (ReferencePoint *) getReferencePointByReferencePointID: (NSString *)referencePointID;
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ReferencePoint" inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"referencePointID = %@", referencePointID];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
        
    NSError *error = nil;
    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(results == nil)
    {
        NSLog(@"%@", error.description);
        
    }
    
    return [results objectAtIndex:0];
}

+ (NSString *) getWebDatabaseVersion
{
    return [WebVersion getDataVersion];
}

+ (void) loadAllLinesIntoCoreData
{
    [WebLines getAllLines];
}

+ (void) loadAllReferencePointsIntoCoreData
{
    [WebReferencePoint getAllReferencePoints];
}

+ (void) loadAllBusstopsIntoCoreData;
{
    [WebBusstops getAllBusstops];
}

+ (void) loadAllBusstopLinesIntoCoreData
{
    [WebBusstopLines getAllBusstopLines];
}

+ (void) loadAllBusesIntoCoreData
{
    [WebBus geAllBuses];
}

+ (Route *) getRouteForRouteID: (NSString *) routeID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"routeID = %@", routeID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *route = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(route == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return [route objectAtIndex:0];
}

+ (NSString *) getRouteNameForRouteID: (NSString*) routeID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"routeID = %@", routeID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *route = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(route == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    Route *r = [route objectAtIndex:0];
    
    return [r desination];
}

+ (NSString *) getLineIdsStringForBusStop: (BusStop*) busStop
{
    NSString *ret = @"N/A";
    NSArray *results = [self getLineIdsForBusStopID:busStop.busStopID];
    BusStop_Line* bl = [results objectAtIndex:0];
    ret = bl.lineID;
    
    if([results count]>1)
    {
        for(int i=1; i<results.count; i++)
        {
            bl = [results objectAtIndex:i];
            ret = [ret stringByAppendingFormat:@", %@", bl.lineID];
        }
        
    }
    return ret;
}

+ (NSString *) getLineNameForBusID: (NSString *) busID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busID = %@", busID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *bus = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(bus == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    Bus *b = [bus objectAtIndex:0];
    NSString *r = [self getLineNameByLineID:[b lineID]];
    
    return r;
}

+ (NSMutableArray *) getAllAlerts
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alert" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *alerts = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(alerts == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return alerts;
}

+ (void) deleteAssociatedAlerts: (NSString *) routeID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alert" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"routeID = %@", routeID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *alerts = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(alerts == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    for (Alert *a in alerts) {
        [[BusObserver getInstance] removeObserverWithID:a.alertID];
        [a.managedObjectContext deleteObject:a];
    }
}

+ (BusStop_Line *) getBusstopLineForLineID:(NSString *)lineID andBusstopID:(NSString *)busStopID
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop_Line" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lineID = %@ AND busStopID = %@", lineID, busStopID];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *busstop_line = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(busstop_line == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return [busstop_line objectAtIndex:0];
}

+ (BusStop_Line *) getBusstopLineForLineID:(NSString *)lineID andNumeral:(NSString *)numeral;
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop_Line" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lineID = %@ AND numeral = %@", lineID, numeral];
    request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *busstop_line = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(busstop_line == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return [busstop_line objectAtIndex:0];
}



@end

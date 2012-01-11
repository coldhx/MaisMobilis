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

+ (NSArray *) getAllBusStops 
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop"                                                                                                                               inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSArray *busStops = [context executeFetchRequest:request error: &error] ;
    
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

+ (NSString *) getEtaByBusID : (NSString *) busID
{
    return [WebEta getEtaForBusID: busID];
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


+ (NSArray *) getBusStopsWithSameLineIdAs: (NSString *) bsID
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
    
    NSArray *res = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if(res == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    return res;
   
}



@end

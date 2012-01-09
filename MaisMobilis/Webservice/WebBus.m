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
#import "../Bus.h"
#import "SBJson.h"

@implementation WebBus

+(void) persistBus:(NSArray *)jsonObjects {    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    //Add buses
    Bus *newBus;
    for (int i=0; i<jsonObjects.count; i++)
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busID = %@", [[jsonObjects objectAtIndex:i] objectForKey:@"idAutocarro"]];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSMutableArray *results = [[context executeFetchRequest:request error: &error] mutableCopy];
        
        if([results count] == 1)
        {
            Bus *bus = [results objectAtIndex:0];
            bus.lastStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idAutocarro"];
            bus.lastStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idUltimaParagem"];
            bus.latitude = [[jsonObjects objectAtIndex:i] objectForKey:@"latitude"];
            bus.lineID = [[jsonObjects objectAtIndex:i] objectForKey:@"idLinha"];
            bus.longitude = [[jsonObjects objectAtIndex:i] objectForKey:@"longitude"];
            bus.meanVelocity = [[jsonObjects objectAtIndex:i] objectForKey:@"velocidadeMedia"];
            bus.precision = [[jsonObjects objectAtIndex:i] objectForKey:@"precisao"];
            bus.timeStamp = [[jsonObjects objectAtIndex:i] objectForKey:@"timeStamp"];
        }
        else
        {
            newBus = [NSEntityDescription insertNewObjectForEntityForName:@"Bus" inManagedObjectContext:context];
            newBus.busID = [[jsonObjects objectAtIndex:i] objectForKey:@"idAutocarro"];
            newBus.lastStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idUltimaParagem"];
            newBus.latitude = [[jsonObjects objectAtIndex:i] objectForKey:@"latitude"];
            newBus.lineID = [[jsonObjects objectAtIndex:i] objectForKey:@"idLinha"];
            newBus.longitude = [[jsonObjects objectAtIndex:i] objectForKey:@"longitude"];
            newBus.meanVelocity = [[jsonObjects objectAtIndex:i] objectForKey:@"velocidadeMedia"];
            newBus.precision = [[jsonObjects objectAtIndex:i] objectForKey:@"precisao"];
            newBus.timeStamp = [[jsonObjects objectAtIndex:i] objectForKey:@"timeStamp"];
        }
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *results = [[context executeFetchRequest:request error: &error] mutableCopy];
    
    Bus *bus;
    for(int i=0; i<results.count; i++)
    {
        Boolean delete = YES;
        for(int j=0; j<jsonObjects.count; j++)
        {
            bus = [results objectAtIndex:i];
            
            if([bus.busID isEqualToString:[[jsonObjects objectAtIndex:j] objectForKey:@"idAutocarro"]])
            {
                delete = NO;
            }
        }
        
        if(delete == YES)
        {
            //Apagar autocarro
            [context deleteObject: bus];
        }
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
}

@end

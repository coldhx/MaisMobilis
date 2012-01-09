//
//  WebBusstopLines.m
//  MaisMobilis
//
//  Created by tom on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebBusstopLines.h"
#import "MaisMobilisWebService.h"
#import "AppDelegate.h"
#import "../BusStop_Line.h"

@implementation WebBusstopLines

+ (void) persistReferencePoints:(NSArray *)jsonObjects
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    BusStop_Line *new_busstopLine;
    for (int i=0; i<jsonObjects.count; i++) {
        new_busstopLine = [NSEntityDescription insertNewObjectForEntityForName:@"BusStop_Line" inManagedObjectContext:context];

        new_busstopLine.lineID = [[jsonObjects objectAtIndex:i] objectForKey:@"idLinha"];
        new_busstopLine.busStopID = [[jsonObjects objectAtIndex:i] objectForKey:@"idParagem"];
        new_busstopLine.numeral = [[jsonObjects objectAtIndex:i] objectForKey:@"numeralparagem"];
    }
}

+ (void)getAllBusstopLines
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhasparagens" withQueryString:@""];
    [self persistReferencePoints:jsonObjects];
}
@end

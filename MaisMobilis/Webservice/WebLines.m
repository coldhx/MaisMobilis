//
//  WebLines.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebLines.h"
#import "MaisMobilisWebService.h"
#import "AppDelegate.h"
#import "../Line.h"
#import "SBJson.h"

@implementation WebLines
+(void) persistLines:(NSArray *)jsonObjects {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    Line *newLine;
    for (int i=0; i<jsonObjects.count; i++) {
        newLine = [NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:context];
        newLine.lineID = [[jsonObjects objectAtIndex:i] objectForKey:@"idLinha"];
        newLine.name = [[jsonObjects objectAtIndex:i] objectForKey:@"nome"];
        newLine.transporterID = [[jsonObjects objectAtIndex:i] objectForKey:@"idTransportador"];
    }
}

+ (void)getAllLines
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhas" withQueryString:@""];
    [self persistLines:jsonObjects];
}

+ (void)getLinesWithCarrierID:(NSString *)carrierID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhas" withQueryString:[NSString stringWithFormat:@"?idTransportador=%@", carrierID]];
   [self persistLines:jsonObjects];
}

+ (NSArray *) getLinesWithBusstopID:(NSString *)busstopID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhas" withQueryString:[NSString stringWithFormat:@"?idParagem=%@", busstopID]];
    [self persistLines:jsonObjects];
    
    return jsonObjects;
}

+ (void)getLineWithID:(NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"linhas/%@/", lineID] withQueryString:@""];
    [self persistLines:jsonObjects];
}
@end

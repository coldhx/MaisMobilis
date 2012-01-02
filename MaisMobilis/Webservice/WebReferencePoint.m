//
//  WebReferencePoint.m
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebReferencePoint.h"
#import "MaisMobilisWebService.h"
#import "AppDelegate.h"
#import "../ReferencePoint.h"
#import "SBJson.h"

@implementation WebReferencePoint
//this is a god DAMNED COMMENT
+ (void) persistReferencePoints:(NSArray *)jsonObjects{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    ReferencePoint *newRefPoint;
    for (int i=0; i<jsonObjects.count; i++) {
        newRefPoint = [NSEntityDescription insertNewObjectForEntityForName:@"ReferencePoint" inManagedObjectContext:context];
        newRefPoint.referencePointID = [[jsonObjects objectAtIndex:i] objectForKey:@"idPontoReferencia"];
        newRefPoint.latitude = [[jsonObjects objectAtIndex:i] objectForKey:@"latitude"];
        newRefPoint.longitude = [[jsonObjects objectAtIndex:i] objectForKey:@"longitude"];
              
    }

}

+ (void) getAllReferencePoints;
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"pontosreferencia" withQueryString:@""];
    [self persistReferencePoints:jsonObjects];
}

+ (void) getReferencePointsWithLineID:(NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"pontosreferencia" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineID]];
    [self persistReferencePoints:jsonObjects];
}

@end

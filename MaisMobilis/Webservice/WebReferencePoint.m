//
//  WebReferencePoint.m
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebReferencePoint.h"
#import "MaisMobilisWebService.h"

@implementation WebReferencePoint

+ (void) getAllReferencePoints;
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"pontosreferencia" withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void) getLinesWithLineID:(NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"pontosreferencia" withQueryString:[NSString stringWithFormat:@"?idLinha=%@", lineID]];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

@end

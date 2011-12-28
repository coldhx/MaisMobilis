//
//  WebLines.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebLines.h"
#import "MaisMobilisWebService.h"

@implementation WebLines
+ (void)getAllLines
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhas" withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void)getLinesWithCarrierID:(NSString *)carrierID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhas" withQueryString:[NSString stringWithFormat:@"?idTransportador=%@", carrierID]];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void) getLinesWithBusstopID:(NSString *)busstopID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:@"linhas" withQueryString:[NSString stringWithFormat:@"?idParagem=%@", busstopID]];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}

+ (void)getLineWithID:(NSString *)lineID
{
    NSArray *jsonObjects = [MaisMobilisWebService doGET:[NSString stringWithFormat:@"linhas/%@/", lineID] withQueryString:@""];
    NSLog(@"RESPONSE: %@", [jsonObjects description]);
}
@end

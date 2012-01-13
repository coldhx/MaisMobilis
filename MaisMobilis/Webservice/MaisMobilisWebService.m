//
//  MaisMobilisWebService.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MaisMobilisWebService.h"

@implementation MaisMobilisWebService

NSString *APIURL = @"http://maismobilis.telmomarques.nome.pt/";
NSString *USERNAME = @"apikey";
NSString *APIKEY = @"gA5etlof24DX6JnoaaZAALJC73KzemHAClTIItB0yBOkmGYvdICqlbnWK2CvgMRgjL4BZC0AvZvnnn19r7rBQZ";

+(NSArray *) doGET:(NSString *)resource withQueryString:(NSString *)queryString
{
    @try
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@", APIURL, resource, queryString]];
        ASIHTTPRequest *request =  [ASIHTTPRequest requestWithURL:url];
        
        [request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
        [request setUsername:USERNAME];
        [request setPassword:APIKEY];
        
        [request startSynchronous];
        NSError *asiError = [request error];
        
        if(asiError)
        {
            [NSException raise:@"doGET Failed" format:@"Request to the webservice failed."];
        }
        
        NSString *response = [request responseString];
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *jsonError;
        NSArray *jsonObjects = [parser objectWithString:response error:&jsonError];
        
        if(jsonError)
        {
            [NSException raise:@"doGET Failed" format:@"Invalid jSON. Could not parse."];
        }
        
        return jsonObjects;
    }
    @catch (NSException *exception)
    {
        NSLog(@"No internet!");
        return nil;
    }
}

+(NSString *)getAPIUrl
{
    return APIURL;
}


@end

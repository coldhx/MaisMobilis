//
//  MaisMobilisWebService.m
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MaisMobilisWebService.h"
#import "ASIHTTPRequest.h"

@implementation MaisMobilisWebService

NSString *APIURL = @"http://maismobilis.telmomarques.nome.pt/";
NSString *USERNAME = @"apikey";
NSString *APIKEY = @"gA5etlof24DX6JnoaaZAALJC73KzemHAClTIItB0yBOkmGYvdICqlbnWK2CvgMRgjL4BZC0AvZvnnn19r7rBQZ";

+(NSString *) doGET:(NSString *)resource withQueryString:(NSString *)queryString
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@", APIURL, resource, queryString]];
    ASIHTTPRequest *request =  [ASIHTTPRequest requestWithURL:url];
    
    [request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
    [request setUsername:USERNAME];
    [request setPassword:APIKEY];
    
    [request startSynchronous];
    NSError *error = [request error];
    
    if(!error)
    {
        [NSException raise:@"doGET Failed" format:@""];
    }
    
    NSString *response = [request responseString];
    
    return response;
}


@end

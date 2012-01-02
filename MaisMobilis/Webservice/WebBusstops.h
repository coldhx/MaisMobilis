//
//  WebBusstops.h
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebBusstops : NSObject 

+ (void)fetchAllBusstops;
+ (void)fetchBusstopsWithLineID: (NSString *)lineID;
+ (void)fetchBusstopWithID: (NSString *) busstopID;
+ (void) persistBusStops: (NSArray *) jsonObjects;


@end

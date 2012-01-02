//
//  WebBusstops.h
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebBusstops : NSObject
+ (void) persistBusStops:(NSArray *)jsonObjects;
+ (void)getAllBusstops;
+ (void)getBusstopsWithLineID: (NSString *)lineID;
+ (void)getBusstopWithID: (NSString *) busstopID;
@end

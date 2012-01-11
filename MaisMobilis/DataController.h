//
//  CoreDataController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Bus.h"
#import "BusStop.h"
#import "Line.h"
#import "BusStop_Line.h"
#import "Webservice/WebEta.h"

@interface DataController : NSObject

+ (NSArray *) getLineIdsForBusStopID :(NSString *) busStopID;
+ (NSArray *) getAllBusStops;
+ (NSString*) getLineNameByLineID : (NSString *) lineID;
+ (NSString *) getNextStopByBusID: (NSString *) busID;
+ (NSString *) getEtaByBusID : (NSString *) busID;
+ (NSArray *) getAllBuses;
+ (Bus *) getBusByBusID:(NSString *) busID;
+ (NSArray *) getBusStopsWithSameLineIdAs: (NSString *) bsID;
@end

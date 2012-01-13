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
#import "ReferencePoint.h"
#import "BusStop_Line.h"
#import "Webservice/WebEta.h"
#import "Webservice/WebVersion.h"
#import "Webservice/WebLines.h"
#import "Webservice/WebReferencePoint.h"
#import "Webservice/WebBusstops.h"
#import "Webservice/WebBus.h"
#import "Webservice/WebBusstopLines.h"

@interface DataController : NSObject

+ (NSArray *) getLineIdsForBusStopID :(NSString *) busStopID;
+ (NSMutableArray *) getAllBusStops;
+ (NSString*) getLineNameByLineID : (NSString *) lineID;
+ (NSString *) getNextStopByBusID: (NSString *) busID;
+ (NSString *) getEtaByBusID : (NSString *) busID;
+ (NSArray *) getEtaByBusstopID : (NSString *) busstopID;
+ (NSArray *) getAllBuses;
+ (Bus *) getBusByBusID:(NSString *) busID;
+ (BusStop *) getBusStopByBusStopID: (NSString *) bsID;
+ (NSMutableArray *) getBusStopsWithSameLineIdAs: (NSString *) bsID;
+ (NSMutableArray *) getAllRoutes;
+ (NSArray *) getDatabaseVersion;
+ (NSString *) getWebDatabaseVersion;
+ (ReferencePoint *) getReferencePointByReferencePointID: (NSString *)referencePointID;
+ (void) loadAllLinesIntoCoreData;
+ (void) loadAllReferencePointsIntoCoreData;
+ (void) loadAllBusstopsIntoCoreData;
+ (void) loadAllBusstopLinesIntoCoreData;
+ (void) loadAllBusesIntoCoreData;

@end

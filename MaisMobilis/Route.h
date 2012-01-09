//
//  Route.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Route : NSManagedObject

@property (nonatomic, retain) NSString * destinBusStopID;
@property (nonatomic, retain) NSString * initialBusStopID;
@property (nonatomic, retain) NSString * lineID;
@property (nonatomic, retain) NSString * routeID;
@property (nonatomic, retain) NSString * desination;

@end

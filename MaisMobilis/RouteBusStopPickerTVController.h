//
//  RouteBusStopPickerTVController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@class Route;

@interface RouteBusStopPickerTVController : UITableViewController 
{
    @private
        Route *route;
        NSArray *busStops;

}

@property (nonatomic, retain, readonly) NSArray *busStops;
@property (nonatomic, retain) Route *route;
@property (nonatomic) NSInteger type;

@end

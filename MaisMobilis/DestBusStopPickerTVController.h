//
//  DestBusStopPickerTVController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@class Route;

@interface DestBusStopPickerTVController : UITableViewController
{
    NSIndexPath * checkedIndexPath;
@private
    Route *route;
    NSMutableArray *busStops;
}
@property (nonatomic, retain, readonly) NSMutableArray *busStops;
@property (nonatomic, retain) Route *route;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;

@end

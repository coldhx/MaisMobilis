//
//  RouteBusStopPickerTVController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
#import "BusStop.h"

@class Route;

@interface InitBusStopPickerTVController : UITableViewController 
{
    NSIndexPath * checkedIndexPath;
    @private
        Route *route;
        NSMutableArray *busStops;

}

@property (nonatomic, retain, readonly) NSMutableArray *busStops;
@property (nonatomic, retain) Route *route;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;


- (NSString *) getImageName: (BusStop*) bs;
@end

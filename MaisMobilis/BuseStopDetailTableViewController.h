//
//  BuseStopDetailTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"
#import "NewAlertTableViewController.h"
#import "Route.h"

@class Alert;
@interface BuseStopDetailTableViewController: UITableViewController <NewAlertTableViewController>
{
    BusStop *busStop;
}
@property (nonatomic, retain) BusStop *busStop;

- (NSString *) setRouteLineID: (Route*) route;

@end

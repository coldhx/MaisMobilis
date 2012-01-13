//
//  BuseStopDetailTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"

@interface BuseStopDetailTableViewController : UITableViewController
{
    BusStop *busStop;
}
@property (nonatomic, retain) BusStop *busStop;

@end

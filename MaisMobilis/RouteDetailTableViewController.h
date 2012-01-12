//
//  RouteDetailTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"


@interface RouteDetailTableViewController : UITableViewController
{
    Route *route;
}
@property (nonatomic, retain) Route *route;

@end

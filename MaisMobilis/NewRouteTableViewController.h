//
//  NewRouteTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@class Route;

@interface NewRouteTableViewController : UITableViewController <UINavigationControllerDelegate>
{
    @private
        Route *route;
}

@property (nonatomic, retain) Route *route;

@end

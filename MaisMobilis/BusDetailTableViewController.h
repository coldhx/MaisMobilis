//
//  BusDetailTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface BusDetailTableViewController : UITableViewController
{
    Bus *bus;
}

@property (nonatomic, retain) Bus *bus;

@end

//
//  BusesTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusesTableViewController : UITableViewController
{
    NSArray * _buses;
}

@property (nonatomic, retain) NSArray *buses;

@end

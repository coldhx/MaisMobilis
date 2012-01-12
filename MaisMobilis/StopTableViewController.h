//
//  StopTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopTableViewController : UITableViewController
{
    NSMutableArray *_busStops;
}

@property (nonatomic, retain) NSMutableArray *busStops;

@end

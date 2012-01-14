//
//  AlertTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusObserver.h"
#import "NewAlertTableViewController.h"

@class Alert;
@interface AlertTableViewController : UITableViewController <NewAlertTableViewController>
{
    NSMutableArray * _alerts;
}

@property (nonatomic, retain) NSMutableArray * alerts;

@end

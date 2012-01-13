//
//  NewAlertTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alert.h"

#define ROUTE_SECTION 0
#define NUMBUSSTOPS_SECTION 1
#define TIMES_SECTION 2

@protocol NewAlertTableViewController;
@class Alert;

@interface NewAlertTableViewController : UITableViewController <UINavigationControllerDelegate>
{
    @private
    Alert* alert;
    UITextField *busStopsNumber;
    id <NewAlertTableViewController> delegate;
}

@property (nonatomic, retain) Alert *alert;
@property (nonatomic, retain) id <NewAlertTableViewController> delegate;
@property (nonatomic, retain) UITextField *busStopsNumber;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@protocol NewAlertTableViewController <NSObject>

- (void) newAlertTableViewController: (NewAlertTableViewController *) newAlertTableViewController didAddAlert: (Alert *) alert;

@end
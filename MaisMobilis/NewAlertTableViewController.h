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

#define UIDATEPICKERSTARTTIME 0
#define UIDATEPICKERSTOPTIME 1

@interface NewAlertTableViewController : UITableViewController <UINavigationControllerDelegate>
{
    __unsafe_unretained id <NewAlertTableViewController> _delegate;
    
    @private
    Alert* alert;
    UITextField *busStopsNumber;
    UIActionSheet *actionSheet;
    UIDatePicker *pickerView;
}

@property (nonatomic, retain) Alert *alert;
@property (nonatomic, assign) id<NewAlertTableViewController> delegate;
@property (nonatomic, retain) UITextField *busStopsNumber;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

- (void) showUIDatePickerFor:(int) element;
- (void) saveStartTime;
- (void) saveStopTime;
- (void) saveTimeFor:(int) element;

@end

@protocol NewAlertTableViewController <NSObject>

- (void) newAlertTableViewController: (NewAlertTableViewController *) newAlertTableViewController didAddAlert: (Alert *) alert;

@end
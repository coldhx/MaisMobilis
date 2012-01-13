//
//  NewRouteTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@protocol NewRouteTableViewController;
@class Route;

@interface NewRouteTableViewController : UITableViewController <UINavigationControllerDelegate>
{
    
    UITextField *textField;
    @private
        Route *route;
        id <NewRouteTableViewController> delegate;
}
@property (nonatomic, retain) UITextField * textField;
@property (nonatomic, retain) Route *route;
@property (nonatomic, retain) id <NewRouteTableViewController> delegate;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@protocol NewRouteTableViewController <NSObject>

- (void) newRouteTableViewController: (NewRouteTableViewController *) newRouteTableViewController didAddRoute: (Route *) route;

@end
//
//  RoutePickerTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alert.h"
#import "Route.h"

@class Alert;

@interface RoutePickerTableViewController : UITableViewController
{
    NSIndexPath * checkedIndexPath;
    @private
    Alert *alert;
    NSMutableArray *routes;
}

@property (nonatomic, retain, readonly) NSMutableArray *routes;
@property (nonatomic, retain) Alert *alert;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;

@end

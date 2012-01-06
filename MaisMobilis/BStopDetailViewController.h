//
//  BStopDetailViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"

@interface BStopDetailViewController : UIViewController
{
    IBOutlet UILabel *lineLabel;
    IBOutlet UILabel *nextBuses;
    IBOutlet UITextView *nameTextView;
    BusStop * _busStop;
}

@property (nonatomic, retain) BusStop* busStop;

- (NSString*) getLineIdsString;

@end

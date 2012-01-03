//
//  BusDetailTViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface BusDetailTViewController : UITableViewController {
    Bus * _autocarro;
    NSString *_lineName;
    IBOutlet UILabel *lineLabel;
    IBOutlet UILabel *nextStopLabel;
    IBOutlet UILabel *estimatedTimeLabel;
    NSString *lineDescription;
    NSString *estimatedTime;
    NSString *nextStop;
}

@property (nonatomic, retain) Bus *autocarro;
@property (nonatomic, retain) NSString *lineName;

- (void) loadline;
- (void) loadNextStop;
- (BOOL) loadEstimatedTime;

@end

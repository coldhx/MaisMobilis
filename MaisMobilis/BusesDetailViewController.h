//
//  BusesDetailViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface BusesDetailViewController : UIViewController
{
    IBOutlet UILabel *lineLabel;
    IBOutlet UILabel *estimatedTimeLabel;
    IBOutlet UILabel *nextStopLabel;
    Bus *_bus;
}

- (NSString*) loadline;
- (NSString*) loadNextStop;
- (NSString *) loadEta;



@property (nonatomic, retain) Bus *bus;

@end

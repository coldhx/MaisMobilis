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
    BusStop * _busStop;
}

@property (nonatomic, retain) BusStop* busStop;

@end

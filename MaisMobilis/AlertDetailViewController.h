//
//  AlertDetailViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alert.h"

@interface AlertDetailViewController : UIViewController
{
    Alert *_alert;
}

@property(nonatomic, retain) Alert *alert;

@end

//
//  AlertTableViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertTableViewController : UITableViewController
{
    NSMutableArray * _alerts;
}

@property (nonatomic, retain) NSMutableArray * alerts;

@end

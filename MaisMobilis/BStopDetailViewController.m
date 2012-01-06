//
//  BStopDetailViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BStopDetailViewController.h"
#import "DataController.h"

@implementation BStopDetailViewController 

@synthesize busStop = _busStop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    [nameTextView setText:[_busStop name]];
    [lineLabel setText:[self getLineIdsString]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *) getLineIdsString
{
    NSString *ret = @"N/A";
    NSArray *results = [DataController getLineIdsForBusStopID:_busStop.busStopID];
    BusStop_Line* bl = [results objectAtIndex:0];
    ret = bl.lineID;
    
    if([results count]>1)
    {
        for(int i=1; i<results.count; i++)
        {
            bl = [results objectAtIndex:i];
            ret = [ret stringByAppendingFormat:@", %@", bl.lineID];
        }
        
    }
    return ret;
}

@end

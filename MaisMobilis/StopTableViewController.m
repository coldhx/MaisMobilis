//
//  StopTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StopTableViewController.h"
#import "BusStop.h"
#import "BStopDetailViewController.h"
#import "DataController.h"



@implementation StopTableViewController

@synthesize busStops = _busStops;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _busStops = [DataController getAllBusStops];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_busStops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusStopCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BusStop *stop = [_busStops objectAtIndex:indexPath.row];
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    [cellLabel setText:stop.name];
    
    NSArray* lines = [DataController getLineIdsForBusStopID:stop.busStopID];
    NSString* imageName;
    if([lines count] > 1) 
    {
        imageName = @"redandgreensquare.png"; 
    }
    else if([[[lines objectAtIndex:0] lineID]isEqualToString:@"1"])
    {
        imageName = @"greensquare.png";
    }
    else if([[[lines objectAtIndex:0] lineID] isEqualToString:@"2"])
    {
        imageName = @"redsquare.png";
    }
    
    UIImageView *cellImage = (UIImageView *)[cell viewWithTag:2];
    [cellImage setImage:[UIImage imageNamed:imageName]];
    
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showBusStopDetails"]) 
    {
        BStopDetailViewController *busStopDetailVC = [segue destinationViewController];
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        BusStop *bs = [_busStops objectAtIndex:selectedIndex];
        [busStopDetailVC setBusStop:bs];
    }
}


@end

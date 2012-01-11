//
//  RouteBusStopPickerTVController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RouteBusStopPickerTVController.h"
#import "NewRouteTableViewController.h"
#import "DataController.h"

#define ORIGIN 1
#define DEST 2

@interface RouteBusStopPickerTVController()
@property (nonatomic, retain) NSArray *busStops;
@end

@implementation RouteBusStopPickerTVController

@synthesize busStops;
@synthesize route;
@synthesize type;


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
    if(type == ORIGIN)
    {
        if([route destinBusStopID] != nil)
        {
            busStops = [DataController getBusStopsWithSameLineIdAs:[route destinBusStopID]];
        }
        else
            busStops = [DataController getAllBusStops];
            
    }
    else if(type == DEST)
    {
        if([route initialBusStopID] != nil)
        {
            busStops = [DataController getBusStopsWithSameLineIdAs:[route initialBusStopID]];
        }
        else
           busStops = [DataController getAllBusStops];  
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return [busStops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BusStop *bs = [busStops objectAtIndex:[indexPath row]];
    cell.textLabel.text = bs.name;
    
    if ((type == ORIGIN && bs.busStopID == route.initialBusStopID) 
        || (type == DEST && bs.busStopID == route.destinBusStopID)){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusStop *bs = [busStops objectAtIndex:[indexPath row]];
    if(type == ORIGIN) 
    {
        if([route initialBusStopID] != nil)
        {
            NSInteger index = [busStops indexOfObject:bs];
            NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
            checkedCell.accessoryType = UITableViewCellAccessoryNone;
        }
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark]; 
        route.initialBusStopID = [bs busStopID];
    }
    else if(type == DEST)
    {
        if([route destinBusStopID] != nil)
        {
            NSInteger index = [busStops indexOfObject:bs];
            NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
            checkedCell.accessoryType = UITableViewCellAccessoryNone;
        }
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark]; 
        route.destinBusStopID = [bs busStopID];
    }
    
}

@end

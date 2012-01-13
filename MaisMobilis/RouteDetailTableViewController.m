//
//  RouteDetailTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RouteDetailTableViewController.h"
#import "BuseStopDetailTableViewController.h"
#import "DataController.h"
#import "BusStop.h"

#define DESIGNATION_SECTION 0
#define ORIGSTOP_SECTION 1
#define DESTSTOP_SECTION 2

@implementation RouteDetailTableViewController


@synthesize route;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    switch (section) {
        case DESIGNATION_SECTION:
            title = @"Designação:";
            break;
        case ORIGSTOP_SECTION:
            title = @"Paragem de origem:";
            break;
        case DESTSTOP_SECTION:
            title = @"Paragem de destino:";
            break;
        default:
            break;
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    NSString * label = nil;
    
    switch (indexPath.section) {
        case DESIGNATION_SECTION:
            label = route.desination;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case ORIGSTOP_SECTION:
            label = [[DataController getBusStopByBusStopID:route.initialBusStopID] name];
            break;
        case DESTSTOP_SECTION:
            label = [[DataController getBusStopByBusStopID:route.destinBusStopID] name];
            break;
        default:
            break;
    }

    cell.textLabel.text = label;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.section) {
        case ORIGSTOP_SECTION:
                [self performSegueWithIdentifier:@"showBusStopDetail" sender: tableView];
            break;
        case DESTSTOP_SECTION:
                [self performSegueWithIdentifier:@"showBusStopDetail" sender: tableView];
            break;
        default:
            break;
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showBusStopDetail"]) 
    {
        BusStop *bs = nil;
        BuseStopDetailTableViewController *nextView = nil;
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] section];
        switch (selectedIndex) 
        {
            case ORIGSTOP_SECTION:
                bs = [DataController getBusStopByBusStopID:route.initialBusStopID];
                nextView = [segue destinationViewController];
                [nextView setBusStop:bs];
                break;
            case DESTSTOP_SECTION:
                bs = [DataController getBusStopByBusStopID:route.destinBusStopID];
                nextView = [segue destinationViewController];
                [nextView setBusStop:bs];
                break;
            default:
                break;
        }
    }
    
}

@end

//
//  AlertDetailTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlertDetailTableViewController.h"
#import "RouteDetailTableViewController.h"
#import "DataController.h"

#define ROUTE_SECTION 0
#define NUMSTOPS_SECTION 1
#define TIMES_SECTION 2


@implementation AlertDetailTableViewController
@synthesize alert;

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
        case ROUTE_SECTION:
            title = @"Percurso associado";
            break;
        case NUMSTOPS_SECTION:
            title = @"Paragens de antecedência:";
            break;
        case TIMES_SECTION:
            title = @"Intervalo de tempo:";
            break;
        default:
            break;
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *startime = [dateFormatter stringFromDate:[alert startTime]];
    NSString *stoptime = [dateFormatter stringFromDate:[alert stopTime]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *label = nil;
    
    switch (indexPath.section) {
        case ROUTE_SECTION:
            label = [DataController getRouteNameForRouteID:alert.routeID];
            break;
        case NUMSTOPS_SECTION:
            label = [alert.busStopDelayNumber stringValue];
            break;
        case TIMES_SECTION:
            label = [NSString stringWithFormat:@"Entre as %@ e as %@", startime,stoptime]; 
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
        case ROUTE_SECTION:
            [self performSegueWithIdentifier: @"showRouteDetails" sender:tableView];
            break;
            
        default:
            break;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showRouteDetails"])
    {
        Route *r = [DataController getRouteForRouteID:alert.routeID];
        RouteDetailTableViewController *nextView = [segue destinationViewController];
        [nextView setRoute:r];
    }
}

@end
